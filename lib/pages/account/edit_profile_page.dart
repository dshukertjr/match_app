import 'dart:io';

import 'package:app/cubits/auth/auth_cubit.dart';
import 'package:app/models/editing_profile_image.dart';
import 'package:app/models/user_private.dart';
import 'package:app/utilities/app_snackbar.dart';
import 'package:app/utilities/color.dart';
import 'package:app/utilities/validator.dart';
import 'package:app/widgets/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  static const String name = 'EditProfilePage';
  static Route<dynamic> route() {
    return MaterialPageRoute<void>(
      builder: (BuildContext context) => EditProfilePage(),
    );
  }

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<EditingProfileImage> _editingProfileImages =
      List<EditingProfileImage>.filled(6, null);
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _sexualOrientation;
  String _wantingSexualOrientation;
  bool _haveCalledSetup = false;
  bool _haveEdited = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('プロフィール編集'),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () {
              _save(context);
            },
            textColor: appBlue,
            icon: Icon(Feather.check),
            label: const Text('保存'),
          ),
        ],
      ),
      body: CubitConsumer<AuthCubit, AuthState>(
        listener: (BuildContext context, AuthState state) {
          if (state.errorMessage != null) {
            AppSnackbar.error(context: context, message: state.errorMessage);
          } else if (state is AuthSuccess) {
            AppSnackbar.regular(context: context, message: '変更が完了いたしました');
          }
        },
        builder: (BuildContext context, AuthState state) {
          if (state is AuthSuccess) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    LayoutBuilder(builder:
                        (BuildContext context, BoxConstraints constraints) {
                      return Wrap(
                        children: List<Widget>.generate(
                          6,
                          (int index) => _profileImageButton(
                            context: context,
                            editingProfileImages: _editingProfileImages,
                            index: index,
                            availableWidth: constraints.maxWidth,
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _nameController,
                      onChanged: (_) {
                        _haveEdited = true;
                      },
                      decoration: const InputDecoration(
                        labelText: '名前',
                      ),
                      validator: nameValidator,
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      onChanged: (_) {
                        _haveEdited = true;
                      },
                      maxLines: null,
                      maxLength: maxDescriptionLength,
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'プロフィール',
                      ),
                      validator: descriptionValidator,
                    ),
                    const SizedBox(height: 24),
                    DropdownButtonFormField<String>(
                      value: _sexualOrientation,
                      decoration: const InputDecoration(
                        labelText: '自分のセクシュアリティ',
                      ),
                      onChanged: (String value) {
                        _haveEdited = true;
                        setState(() {
                          _sexualOrientation = value;
                        });
                      },
                      validator: requiredValidator,
                      items: UserPrivate.sexualOrientations
                          .map<DropdownMenuItem<String>>(
                            (String sexualOrientation) =>
                                DropdownMenuItem<String>(
                              child: Text(
                                UserPrivate.sexualOrientationToJapanese(
                                    sexualOrientation),
                              ),
                              value: sexualOrientation,
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 24),
                    DropdownButtonFormField<String>(
                      value: _wantingSexualOrientation,
                      decoration: const InputDecoration(
                        labelText: 'マッチしたい人',
                      ),
                      onChanged: (String value) {
                        _haveEdited = true;
                        setState(() {
                          _wantingSexualOrientation = value;
                        });
                      },
                      validator: requiredValidator,
                      items: UserPrivate.sexualOrientations
                          .where((String sexualOrientation) =>
                              sexualOrientation != SexualOrientation.hide)
                          .map<DropdownMenuItem<String>>(
                            (String sexualOrientation) =>
                                DropdownMenuItem<String>(
                              child: Text(
                                UserPrivate.sexualOrientationToJapanese(
                                    sexualOrientation),
                              ),
                              value: sexualOrientation,
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: CustomLoader(),
            );
          }
        },
      ),
    );
  }

  @override
  void didChangeDependencies() {
    _setup();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _setup() {
    if (_haveCalledSetup) {
      return;
    }
    _haveCalledSetup = true;
    final AuthState state = CubitProvider.of<AuthCubit>(context).state;
    if (state is AuthSuccess) {
      final UserPrivate userPrivate = state.userPrivate;
      setState(() {
        _nameController.text = userPrivate.name;
        _descriptionController.text = userPrivate.description;
        _sexualOrientation = userPrivate.sexualOrientation;
        _wantingSexualOrientation = userPrivate.wantSexualOrientation;
        _editingProfileImages =
            EditingProfileImage.fromImageUrls(userPrivate.imageUrls);
      });
    }
  }

  Widget _profileImageButton({
    @required BuildContext context,
    @required List<EditingProfileImage> editingProfileImages,
    @required int index,
    @required double availableWidth,
  }) {
    final EditingProfileImage editingProfileImage = editingProfileImages[index];
    Widget child = Center(
      child: Icon(
        Feather.plus_circle,
        color: appBlue,
      ),
    );
    if (editingProfileImage?.imageFile != null) {
      child = Ink.image(
        image: FileImage(editingProfileImage.imageFile),
        fit: BoxFit.cover,
      );
    } else if (editingProfileImage?.imageUrl != null) {
      child = Ink.image(
        image: NetworkImage(
          editingProfileImage.imageUrl,
        ),
        fit: BoxFit.cover,
      );
    }
    return SizedBox(
      width: availableWidth / 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AspectRatio(
          aspectRatio: 9 / 12,
          child: Material(
            clipBehavior: Clip.antiAlias,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: InkWell(
              onTap: () async {
                final PickedFile imageFile = await ImagePicker().getImage(
                  source: ImageSource.gallery,
                  maxHeight: 600,
                  maxWidth: 400,
                  imageQuality: 75,
                );
                if (imageFile != null) {
                  _haveEdited = true;
                  setState(() {
                    _editingProfileImages = EditingProfileImage.addNewImage(
                      editingProfileImages: _editingProfileImages,
                      updatingIndex: index,
                      newFile: File(imageFile.path),
                    );
                  });
                }
              },
              child: child,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _save(BuildContext context) async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    if (!_haveEdited) {
      AppSnackbar.error(context: context, message: '編集をしてから保存してください');
      return;
    }
    await CubitProvider.of<AuthCubit>(context).saveUserPrivate(
      name: _nameController.text,
      description: _descriptionController.text,
      editingProfileImages: _editingProfileImages,
      birthDate: null,
      sexualOrientation: _sexualOrientation,
      wantSexualOrientation: _wantingSexualOrientation,
    );
  }
}

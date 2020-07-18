import 'dart:io';

import 'package:app/cubits/auth/auth_cubit.dart';
import 'package:app/models/editing_profile_image.dart';
import 'package:app/models/user_private.dart';
import 'package:app/utilities/navitate_on_auth_state_change.dart';
import 'package:app/utilities/validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class EnterProfilePage extends StatefulWidget {
  static const String name = 'EnterProfilePage';
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
      settings: const RouteSettings(name: name),
      builder: (_) => EnterProfilePage(),
    );
  }

  @visibleForTesting
  static const Key nameTextFieldKey = Key('enterProfileNameTextFieldKey');

  @visibleForTesting
  static const Key birthDateTextFieldKey =
      Key('enterProfileBirthDateTextFieldKey');

  @visibleForTesting
  static const Key pageSubmitButtonKey = Key('enterProfilePageSubmitButtonKey');

  @visibleForTesting
  static const Key pageSexualOrientationKey =
      Key('enterProfilePageSexualOrientationKey');

  @visibleForTesting
  static const Key pageWantSexualOrientationKey =
      Key('enterProfilePageWantSexualOrientationKey');

  @override
  _EnterProfilePageState createState() => _EnterProfilePageState();
}

class _EnterProfilePageState extends State<EnterProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  DateTime _birthDate;
  final TextEditingController _birthDateController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File _profileImageFile;
  String _selfSexualOrientation;
  String _wantSexualOrientation;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('プロフィール登録'),
      ),
      body: _body(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _fab(context),
    );
  }

  Widget _fab(BuildContext context) {
    return CubitBuilder<AuthCubit, AuthState>(builder: (_, AuthState state) {
      if (state is AuthLoading) {
        return const RaisedButton(
          key: EnterProfilePage.pageSubmitButtonKey,
          onPressed: null,
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        );
      }
      return RaisedButton(
        key: EnterProfilePage.pageSubmitButtonKey,
        onPressed: _submit,
        child: const Text('次へ'),
      );
    });
  }

  Widget _body(BuildContext context) {
    return CubitListener<AuthCubit, AuthState>(
      listener: navigateOnAuthStateChange,
      child: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: <Widget>[
          _page1(context),
          _page2(context),
          _page3(context),
        ],
      ),
    );
  }

  Widget _page2(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('あなたについて教えてください', style: Theme.of(context).textTheme.headline4),
        const Text('＊プロフィール上に表示されます'),
        RadioListTile<String>(
          key: EnterProfilePage.pageSexualOrientationKey,
          groupValue: _selfSexualOrientation,
          value: SexualOrientation.gay,
          onChanged: (String val) {
            setState(() {
              _selfSexualOrientation = val;
            });
          },
          title: const Text('ゲイ'),
        ),
        RadioListTile<String>(
          groupValue: _selfSexualOrientation,
          value: SexualOrientation.lesbian,
          onChanged: (String val) {
            setState(() {
              _selfSexualOrientation = val;
            });
          },
          title: const Text('レズビアン'),
        ),
        RadioListTile<String>(
          groupValue: _selfSexualOrientation,
          value: SexualOrientation.bisexual,
          onChanged: (String val) {
            setState(() {
              _selfSexualOrientation = val;
            });
          },
          title: const Text('バイセクシュアル'),
        ),
        RadioListTile<String>(
          groupValue: _selfSexualOrientation,
          value: SexualOrientation.transgender,
          onChanged: (String val) {
            setState(() {
              _selfSexualOrientation = val;
            });
          },
          title: const Text('トランスジェンダー'),
        ),
        RadioListTile<String>(
          groupValue: _selfSexualOrientation,
          value: SexualOrientation.hide,
          onChanged: (String val) {
            setState(() {
              _selfSexualOrientation = val;
            });
          },
          title: const Text('答えない'),
        ),
      ],
    );
  }

  Widget _page3(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('閲覧する/される相手を選択してください',
            style: Theme.of(context).textTheme.headline4),
        RadioListTile<String>(
          key: EnterProfilePage.pageWantSexualOrientationKey,
          groupValue: _wantSexualOrientation,
          value: SexualOrientation.gay,
          onChanged: (String val) {
            setState(() {
              _wantSexualOrientation = val;
            });
          },
          title: const Text('ゲイ'),
        ),
        RadioListTile<String>(
          groupValue: _wantSexualOrientation,
          value: SexualOrientation.lesbian,
          onChanged: (String val) {
            setState(() {
              _wantSexualOrientation = val;
            });
          },
          title: const Text('レズビアン'),
        ),
        RadioListTile<String>(
          groupValue: _wantSexualOrientation,
          value: SexualOrientation.bisexual,
          onChanged: (String val) {
            setState(() {
              _wantSexualOrientation = val;
            });
          },
          title: const Text('バイセクシュアル'),
        ),
        RadioListTile<String>(
          groupValue: _wantSexualOrientation,
          value: SexualOrientation.transgender,
          onChanged: (String val) {
            setState(() {
              _wantSexualOrientation = val;
            });
          },
          title: const Text('トランスジェンダー'),
        ),
        RadioListTile<String>(
          groupValue: _wantSexualOrientation,
          value: SexualOrientation.hide,
          onChanged: (String val) {
            setState(() {
              _wantSexualOrientation = val;
            });
          },
          title: const Text('答えない'),
        ),
      ],
    );
  }

  /// Set profile image, name, and birthDate
  Widget _page1(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Center(
              child: Material(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: const CircleBorder(),
                child: InkWell(
                  onTap: _pickProfileImage,
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: _profileImageFile == null
                        ? Ink(
                            color: Colors.blueGrey,
                            child: Center(
                              child: Icon(
                                Icons.image,
                                color: Colors.white.withOpacity(0.7),
                              ),
                            ),
                          )
                        : Ink.image(
                            image: FileImage(_profileImageFile),
                            fit: BoxFit.cover,
                            child: Center(
                              child: Icon(
                                Icons.image,
                                size: 40,
                                color: Colors.white.withOpacity(0.7),
                              ),
                            ),
                          ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            TextFormField(
              key: EnterProfilePage.nameTextFieldKey,
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'ニックネーム',
              ),
              validator: requiredValidator,
            ),
            const SizedBox(height: 24),
            TextFormField(
              key: EnterProfilePage.birthDateTextFieldKey,
              readOnly: true,
              onTap: _chooseBirthDate,
              controller: _birthDateController,
              decoration: const InputDecoration(
                labelText: '生年月日',
              ),
              validator: requiredValidator,
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _birthDateController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _submit() {
    final int page = _pageController.page.round();
    if (page == 0 && !_formKey.currentState.validate()) {
      return;
    } else if (page == 1 && _selfSexualOrientation == null) {
      return;
    } else if (page == 2 && _wantSexualOrientation == null) {
      return;
    }
    if (page < 2) {
      _pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      final String name = _nameController.text;
      CubitProvider.of<AuthCubit>(context).saveUserPrivate(
        name: name,
        editingProfileImages: <EditingProfileImage>[
          EditingProfileImage(imageFile: _profileImageFile)
        ],
        birthDate: _birthDate,
        sexualOrientation: _selfSexualOrientation,
        wantSexualOrientation: _wantSexualOrientation,
      );
    }
  }

  Future<void> _chooseBirthDate() async {
    final DateTime now = DateTime.now();
    final DateTime eiteenYearsAgo = DateTime(now.year - 18, now.month, now.day);
    final DateTime birthDate = await DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime(1900, 1, 1),
      maxTime: eiteenYearsAgo,
      currentTime: _birthDate,
      locale: LocaleType.jp,
    );
    if (birthDate != null) {
      setState(() {
        _birthDate = birthDate;
        _birthDateController.text =
            DateFormat('yyyy年MM月dd日').format(_birthDate);
      });
    }
  }

  Future<void> _pickProfileImage() async {
    final PickedFile selectedImageFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxHeight: 600,
      maxWidth: 400,
      imageQuality: 75,
    );
    if (selectedImageFile != null) {
      setState(() {
        _profileImageFile = File(selectedImageFile.path);
      });
    }
  }
}

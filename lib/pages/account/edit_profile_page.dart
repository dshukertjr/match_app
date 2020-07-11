import 'package:app/cubits/auth/auth_cubit.dart';
import 'package:app/models/user_private.dart';
import 'package:app/utilities/color.dart';
import 'package:app/utilities/validator.dart';
import 'package:app/widgets/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:flutter_icons/flutter_icons.dart';

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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('プロフィール編集'),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () {
              Navigator.of(context).pop();
            },
            textColor: appBlue,
            icon: Icon(Feather.check),
            label: const Text('保存'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: CubitConsumer<AuthCubit, AuthState>(
          listener: (BuildContext context, AuthState state) {
            if (state is AuthSuccess) {
              final UserPrivate userPrivate = state.userPrivate;
              _nameController.text = userPrivate.name;
              _descriptionController.text = userPrivate.description;
            }
          },
          builder: (BuildContext context, AuthState state) {
            if (state is AuthSuccess) {
              final UserPrivate userPrivate = state.userPrivate;
              return Form(
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
                            imageUrls: userPrivate.imageUrls,
                            index: index,
                            availableWidth: constraints.maxWidth,
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: '名前',
                      ),
                      validator: nameValidator,
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      maxLines: null,
                      maxLength: maxDescriptionLength,
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'プロフィール',
                      ),
                      validator: descriptionValidator,
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              );
            } else {
              return Center(
                child: CustomLoader(),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _profileImageButton({
    @required BuildContext context,
    @required List<String> imageUrls,
    @required int index,
    @required double availableWidth,
  }) {
    final bool hasImageAtTheIndex = index < imageUrls.length;
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
              onTap: () {},
              child: hasImageAtTheIndex
                  ? Ink.image(
                      image: NetworkImage(
                        imageUrls[index],
                      ),
                      fit: BoxFit.cover,
                    )
                  : Center(
                      child: Icon(Feather.image),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

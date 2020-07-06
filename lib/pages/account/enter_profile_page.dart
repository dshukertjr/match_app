import 'dart:io';

import 'package:app/blocs/auth/auth_bloc.dart';
import 'package:app/models/profile.dart';
import 'package:app/utilities/validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class EnterProfilePage extends StatefulWidget {
  static const name = 'EnterProfilePage';
  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (context) => EnterProfilePage(),
    );
  }

  @visibleForTesting
  static const enterProfileNameTextFieldKey =
      Key('enterProfileNameTextFieldKey');

  @visibleForTesting
  static const enterProfileBirthDateTextFieldKey =
      Key('enterProfileBirthDateTextFieldKey');

  @visibleForTesting
  static const enterProfilePageSubmitButtonKey =
      Key('enterProfilePageSubmitButtonKey');

  @override
  _EnterProfilePageState createState() => _EnterProfilePageState();
}

class _EnterProfilePageState extends State<EnterProfilePage> {
  final _nameController = TextEditingController();
  DateTime _birthDate;
  final _birthDateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  File _profileImageFile;
  SexualOrientation _sexualOrientation = SexualOrientation.blank();
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('プロフィール登録'),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              BlocProvider.of<AuthBloc>(context).add(AuthLoggedOut());
            },
            child: Text('logout'),
          ),
        ],
      ),
      body: _body(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _fab(),
    );
  }

  RaisedButton _fab() {
    return RaisedButton(
      key: EnterProfilePage.enterProfilePageSubmitButtonKey,
      onPressed: () {
        if (!_formKey.currentState.validate()) {
          return;
        }
        _pageController.nextPage(
            duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
      },
      child: Text('次へ'),
    );
  }

  Widget _body(BuildContext context) {
    return PageView(
      controller: _pageController,
      children: <Widget>[
        _page1(),
        _page2(context),
      ],
    );
  }

  Widget _page2(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('あなたについて教えてください', style: Theme.of(context).textTheme.headline4),
        Text('＊プロフィール上に表示されます'),
        Row(
          children: <Widget>[
            Checkbox(
              value: _sexualOrientation.maleG,
              onChanged: (val) {
                setState(() {
                  _sexualOrientation = _sexualOrientation.copyWith(maleG: val);
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  /// Set profile image, name, and birthDate
  Widget _page1() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Center(
              child: Material(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: CircleBorder(),
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
                            image: Image.file(_profileImageFile).image,
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
            SizedBox(height: 24),
            TextFormField(
              key: EnterProfilePage.enterProfileNameTextFieldKey,
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'ニックネーム',
              ),
              validator: Validator.requiredValidator,
            ),
            SizedBox(height: 24),
            TextFormField(
              key: EnterProfilePage.enterProfileBirthDateTextFieldKey,
              readOnly: true,
              onTap: _chooseBirthDate,
              controller: _birthDateController,
              decoration: InputDecoration(
                labelText: '生年月日',
              ),
              validator: Validator.requiredValidator,
            ),
            SizedBox(height: 24),
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

  void _chooseBirthDate() async {
    final now = DateTime.now();
    final eiteenYearsAgo = DateTime(now.year - 18, now.month, now.day);
    final birthDate = await DatePicker.showDatePicker(
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

  void _pickProfileImage() async {
    final selectedImageFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxHeight: 500,
      maxWidth: 500,
      imageQuality: 75,
    );
    if (selectedImageFile != null) {
      setState(() {
        _profileImageFile = File(selectedImageFile.path);
      });
    }
  }
}

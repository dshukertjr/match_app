import 'dart:io';

import 'package:app/cubits/auth/auth_cubit.dart';
import 'package:app/models/profile.dart';
import 'package:app/utilities/validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class EnterProfilePage extends StatefulWidget {
  static const name = 'EnterProfilePage';
  static Route<dynamic> route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: name),
      builder: (context) => EnterProfilePage(),
    );
  }

  @visibleForTesting
  static const nameTextFieldKey = Key('enterProfileNameTextFieldKey');

  @visibleForTesting
  static const birthDateTextFieldKey = Key('enterProfileBirthDateTextFieldKey');

  @visibleForTesting
  static const pageSubmitButtonKey = Key('enterProfilePageSubmitButtonKey');

  @visibleForTesting
  static const pageSexualOrientationKey =
      Key('enterProfilePageSexualOrientationKey');

  @visibleForTesting
  static const pageWantSexualOrientationKey =
      Key('enterProfilePageWantSexualOrientationKey');

  @override
  _EnterProfilePageState createState() => _EnterProfilePageState();
}

class _EnterProfilePageState extends State<EnterProfilePage> {
  final _nameController = TextEditingController();
  DateTime _birthDate;
  final _birthDateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  File _profileImageFile;
  String _selfSexualOrientation;
  String _wantSexualOrientation;
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('プロフィール登録'),
        actions: <Widget>[
          if (!kReleaseMode)
            FlatButton(
              onPressed: () {
                CubitProvider.of<AuthCubit>(context).logout();
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
      key: EnterProfilePage.pageSubmitButtonKey,
      onPressed: _submit,
      child: Text('次へ'),
    );
  }

  Widget _body(BuildContext context) {
    return PageView(
      controller: _pageController,
      children: <Widget>[
        _page1(),
        _page2(context),
        _page3(context),
      ],
    );
  }

  Widget _page2(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('あなたについて教えてください', style: Theme.of(context).textTheme.headline4),
        Text('＊プロフィール上に表示されます'),
        RadioListTile<String>(
          key: EnterProfilePage.pageSexualOrientationKey,
          groupValue: _selfSexualOrientation,
          value: SexualOrientation.gay,
          onChanged: (val) {
            setState(() {
              _selfSexualOrientation = val;
            });
          },
          title: Text('ゲイ'),
        ),
        RadioListTile<String>(
          groupValue: _selfSexualOrientation,
          value: SexualOrientation.lesbian,
          onChanged: (val) {
            setState(() {
              _selfSexualOrientation = val;
            });
          },
          title: Text('レズビアン'),
        ),
        RadioListTile<String>(
          groupValue: _selfSexualOrientation,
          value: SexualOrientation.bisexual,
          onChanged: (val) {
            setState(() {
              _selfSexualOrientation = val;
            });
          },
          title: Text('バイセクシュアル'),
        ),
        RadioListTile<String>(
          groupValue: _selfSexualOrientation,
          value: SexualOrientation.transgender,
          onChanged: (val) {
            setState(() {
              _selfSexualOrientation = val;
            });
          },
          title: Text('トランスジェンダー'),
        ),
        RadioListTile<String>(
          groupValue: _selfSexualOrientation,
          value: SexualOrientation.hide,
          onChanged: (val) {
            setState(() {
              _selfSexualOrientation = val;
            });
          },
          title: Text('答えない'),
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
          onChanged: (val) {
            setState(() {
              _wantSexualOrientation = val;
            });
          },
          title: Text('ゲイ'),
        ),
        RadioListTile<String>(
          groupValue: _wantSexualOrientation,
          value: SexualOrientation.lesbian,
          onChanged: (val) {
            setState(() {
              _wantSexualOrientation = val;
            });
          },
          title: Text('レズビアン'),
        ),
        RadioListTile<String>(
          groupValue: _wantSexualOrientation,
          value: SexualOrientation.bisexual,
          onChanged: (val) {
            setState(() {
              _wantSexualOrientation = val;
            });
          },
          title: Text('バイセクシュアル'),
        ),
        RadioListTile<String>(
          groupValue: _wantSexualOrientation,
          value: SexualOrientation.transgender,
          onChanged: (val) {
            setState(() {
              _wantSexualOrientation = val;
            });
          },
          title: Text('トランスジェンダー'),
        ),
        RadioListTile<String>(
          groupValue: _wantSexualOrientation,
          value: SexualOrientation.hide,
          onChanged: (val) {
            setState(() {
              _wantSexualOrientation = val;
            });
          },
          title: Text('答えない'),
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
              key: EnterProfilePage.nameTextFieldKey,
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'ニックネーム',
              ),
              validator: Validator.requiredValidator,
            ),
            SizedBox(height: 24),
            TextFormField(
              key: EnterProfilePage.birthDateTextFieldKey,
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

  void _submit() {
    final page = _pageController.page.round();
    if (page == 0 && !_formKey.currentState.validate()) {
      return;
    } else if (page == 1 && _selfSexualOrientation == null) {
      return;
    } else if (page == 2 && _wantSexualOrientation == null) {
      return;
    }
    if (page < 2) {
      _pageController.nextPage(
          duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      final name = _nameController.text;
      CubitProvider.of<AuthCubit>(context).saveProfile(
        name: name,
        imageFile: _profileImageFile,
        birthDate: _birthDate,
        sexualOrientation: _selfSexualOrientation,
        wantSexualOrientation: _wantSexualOrientation,
      );
    }
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

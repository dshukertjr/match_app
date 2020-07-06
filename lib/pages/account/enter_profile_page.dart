import 'package:app/blocs/auth/auth_bloc.dart';
import 'package:app/utilities/validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
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
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
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
              RaisedButton(
                key: EnterProfilePage.enterProfilePageSubmitButtonKey,
                onPressed: () {
                  if (!_formKey.currentState.validate()) {
                    return;
                  }
                },
                child: Text('次へ'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _birthDateController.dispose();
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
    setState(() {
      _birthDate = birthDate;
      _birthDateController.text = DateFormat('yyyy年MM月dd日').format(_birthDate);
    });
  }
}

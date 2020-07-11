import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveDialog extends StatelessWidget {
  const AdaptiveDialog({
    Key key,
    @required String title,
    Widget content,
    @required String confirmLabel,
    String cancelLabel = 'キャンセル',
    @required void Function() confirmOnPressed,
    void Function() cancelOnPressed,
  })  : _title = title,
        _content = content,
        _confirmLabel = confirmLabel,
        _cancelLabel = cancelLabel,
        _confirmOnPressed = confirmOnPressed,
        _cancelOnPressed = cancelOnPressed,
        super(key: key);

  final String _title;
  final Widget _content;
  final String _confirmLabel;
  final String _cancelLabel;
  final void Function() _confirmOnPressed;
  final void Function() _cancelOnPressed;

  @override
  Widget build(BuildContext context) {
    final TargetPlatform platform = Theme.of(context).platform;
    if (platform == TargetPlatform.iOS) {
      return CupertinoAlertDialog(
        title: Text(_title),
        content: _content,
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text(_cancelLabel),
            onPressed: _cancelOnPressed ??
                () {
                  Navigator.of(context).pop();
                },
          ),
          CupertinoDialogAction(
            child: Text(_confirmLabel),
            onPressed: _confirmOnPressed,
          ),
        ],
      );
    } else {
      return AlertDialog(
        title: Text(_title),
        content: _content,
        actions: <Widget>[
          FlatButton(
            child: Text(_cancelLabel),
            onPressed: _cancelOnPressed ??
                () {
                  Navigator.of(context).pop();
                },
          ),
          FlatButton(
            child: Text(_confirmLabel),
            onPressed: _confirmOnPressed,
          ),
        ],
      );
    }
  }
}

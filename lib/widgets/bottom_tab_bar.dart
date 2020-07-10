import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class BottomTabBar extends StatelessWidget {
  const BottomTabBar({
    Key key,
    @required void Function(int) onTabChanged,
  })  : _onTabChanged = onTabChanged,
        super(key: key);

  final void Function(int) _onTabChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        _tabButton(
          index: 0,
          iconData: Feather.calendar,
          label: 'ホーム',
        ),
      ],
    );
  }

  Widget _tabButton({
    @required int index,
    @required IconData iconData,
    @required String label,
  }) {
    return Expanded(
      child: InkResponse(
        onTap: () {
          _onTabChanged(index);
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(iconData),
            Text(label),
          ],
        ),
      ),
    );
  }
}

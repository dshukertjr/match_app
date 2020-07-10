import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class TabInfo {
  const TabInfo({
    @required this.iconData,
    @required this.label,
  });

  final IconData iconData;
  final String label;
}

class BottomTabBar extends StatelessWidget {
  const BottomTabBar({
    Key key,
    @required void Function(int) onTabChanged,
  })  : _onTabChanged = onTabChanged,
        super(key: key);

  final void Function(int) _onTabChanged;

  static const List<TabInfo> _tabInfo = <TabInfo>[
    TabInfo(iconData: Feather.user, label: 'ユーザー'),
    TabInfo(iconData: Feather.heart, label: '検索'),
    TabInfo(iconData: Feather.message_circle, label: '会話'),
  ];

  @override
  Widget build(BuildContext context) {
    return Ink(
      color: Colors.white,
      child: Row(
        children: _tabInfo
            .map(
              (TabInfo tabInfo) => _tabButton(
                tabInfo: tabInfo,
                index: _tabInfo.indexOf(tabInfo),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _tabButton({
    @required int index,
    @required TabInfo tabInfo,
  }) {
    return Expanded(
      child: InkResponse(
        onTap: () {
          _onTabChanged(index);
        },
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Icon(tabInfo.iconData),
        ),
      ),
    );
  }
}

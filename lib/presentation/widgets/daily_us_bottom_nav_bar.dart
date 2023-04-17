import 'package:daily_us/common/ui/colors.dart';
import 'package:flutter/material.dart';

class DailyUsBottomNavBar extends StatefulWidget {
  const DailyUsBottomNavBar({
    super.key,
    required this.items,
    required this.onTap,
    required this.backgroundColor,
    this.showLabel = true,
    this.controller,
  });

  final List<DailyUsBottomNavBarItem> items;
  final DailyUsBottomNavBarController? controller;
  final void Function(int) onTap;
  final Color backgroundColor;
  final bool showLabel;

  @override
  State<DailyUsBottomNavBar> createState() => _DailyUsBottomNavBarState();
}

class _DailyUsBottomNavBarState extends State<DailyUsBottomNavBar>
    with DailyUsBottomNavBarController {
  final List<int> buttonItems = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      widget.controller?.clickItem = clickItemCallback;
    }
  }

  void clickItemCallback(int index) {
    if (buttonItems.contains(index)) {
      widget.onTap(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: widget.items.asMap().entries.map((entry) {
          int idx = entry.key;
          DailyUsBottomNavBarItem item = entry.value;
          buttonItems.add(idx);

          return Semantics(
            label: item.label,
            child: _createButtonItem(idx, item),
          );
        }).toList(),
      ),
    );
  }

  IconButton _createButtonItem(
    int idx,
    DailyUsBottomNavBarItem item,
  ) =>
      IconButton(
        padding: const EdgeInsets.all(20.0),
        onPressed: () {
          widget.onTap(idx);
        },
        icon: widget.showLabel
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  item.icon,
                  const SizedBox(
                    height: 4.0,
                  ),
                  Text(
                    item.label,
                    style: item.labelStyle,
                  ),
                ],
              )
            : item.icon,
      );
}

class DailyUsBottomNavBarItem {
  DailyUsBottomNavBarItem({
    required this.icon,
    required this.label,
    this.labelStyle,
  });

  final Widget icon;
  final String label;
  TextStyle? labelStyle;
}

typedef ClickedItemType = void Function(int index);

class DailyUsBottomNavBarController {
  late ClickedItemType clickItem;
}

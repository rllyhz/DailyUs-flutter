import 'package:daily_us/common/ui/colors.dart';
import 'package:flutter/material.dart';

class DailyUsBottomNavBar extends StatefulWidget {
  const DailyUsBottomNavBar({
    super.key,
    required this.items,
    required this.onTap,
    required this.backgroundColor,
    this.showLabel = true,
  });

  final List<DailyUsBottomNavBarItem> items;
  final void Function(int) onTap;
  final Color backgroundColor;
  final bool showLabel;

  @override
  State<DailyUsBottomNavBar> createState() => _DailyUsBottomNavBarState();
}

class _DailyUsBottomNavBarState extends State<DailyUsBottomNavBar> {
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

          return Semantics(
            label: item.label,
            child: IconButton(
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
            ),
          );
        }).toList(),
      ),
    );
  }
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

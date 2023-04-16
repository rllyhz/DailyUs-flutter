import 'package:daily_us/common/constants.dart';
import 'package:daily_us/common/ui/colors.dart';
import 'package:daily_us/presentation/widgets/decorations/text_decorations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DailyUsAppBar extends StatelessWidget {
  const DailyUsAppBar({
    super.key,
    required this.onBack,
    required this.title,
  });

  final void Function() onBack;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            InkResponse(
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: onBack,
              child: SvgPicture.asset(
                'assets/icon_back.svg',
                width: backIconSize,
                colorFilter: ColorFilter.mode(purple700Color, BlendMode.srcIn),
              ),
            ),
            const SizedBox(
              width: 32.0,
            ),
            Text(
              title,
              style: titleTextStyle(),
            ),
          ],
        ),
      ),
    );
  }
}

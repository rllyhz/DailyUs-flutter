import 'package:flutter/material.dart';

class DailyUsDialog extends StatelessWidget {
  const DailyUsDialog({
    super.key,
    required this.title,
    required this.content,
    this.negativeAction,
    this.positiveAction,
    this.showActions = true,
  });

  final Widget title;
  final Widget content;
  final bool showActions;
  final Widget? negativeAction;
  final Widget? positiveAction;

  @override
  Widget build(BuildContext context) {
    // var totalHeightScreen = MediaQuery.of(context).size.height;
    // var dialogHeight = totalHeightScreen * 0.8;
    // if (totalHeightScreen >= 520.0) {
    //   dialogHeight = 320.0;
    // }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Card(
          surfaceTintColor: Colors.white,
          elevation: 4.0,
          color: Colors.white,
          child: ListView(
            padding: const EdgeInsets.symmetric(
              vertical: 24.0,
              horizontal: 24.0,
            ),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: <Widget>[
              SizedBox(
                width: double.infinity,
                child: title,
              ),
              const SizedBox(
                height: 24.0,
              ),
              SizedBox(
                width: double.infinity,
                child: content,
              ),
              if (showActions)
                const SizedBox(
                  height: 28.0,
                ),
              if (showActions)
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      if (negativeAction != null) negativeAction!,
                      const SizedBox(
                        width: 8.0,
                      ),
                      if (positiveAction != null) positiveAction!,
                    ],
                  ),
                ),
            ],
          )),
    );
  }
}

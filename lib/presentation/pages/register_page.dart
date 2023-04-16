import 'package:daily_us/common/constants.dart';
import 'package:daily_us/common/localizations.dart';
import 'package:daily_us/common/ui/theme.dart';
import 'package:daily_us/presentation/widgets/daily_us_app_bar.dart';
import 'package:daily_us/presentation/widgets/daily_us_text_field.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  static const valueKey = ValueKey("RegisterPage");

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  RegisterPage({
    super.key,
    required this.onSuccessRegister,
  });

  final void Function() onSuccessRegister;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: screenPaddingSize),
            child: Stack(
              alignment: AlignmentDirectional.topCenter,
              children: <Widget>[
                Positioned.fill(
                  child: SizedBox.expand(
                    child: Column(
                      children: <Widget>[
                        DailyUsAppBar(
                          onBack: () {
                            Navigator.of(context).pop();
                          },
                          title: AppLocalizations.of(context)!.titleRegister,
                        ),
                        const SizedBox(
                          height: 32.0,
                        ),
                        DailyUsTextField(
                          hintText: AppLocalizations.of(context)!.nameHint,
                          controller: _nameController,
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        DailyUsTextField(
                          hintText: AppLocalizations.of(context)!.emailHint,
                          controller: _emailController,
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        DailyUsTextField(
                          hintText: AppLocalizations.of(context)!.passwordHint,
                          controller: _passwordController,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: screenPaddingSize,
                  left: 0,
                  right: 0,
                  child: appButton(
                    text: AppLocalizations.of(context)!.buttonRegister,
                    onPressed: () {
                      var name = _nameController.text.toString();
                      var email = _emailController.text.toString();
                      var password = _passwordController.text.toString();

                      // print("Name: $name");
                      // print("Email: $email");
                      // print("Password: $password");
                      // onSuccessRegister();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

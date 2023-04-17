import 'package:daily_us/common/constants.dart';
import 'package:daily_us/common/helpers.dart';
import 'package:daily_us/common/localizations.dart';
import 'package:daily_us/common/ui/colors.dart';
import 'package:daily_us/common/ui/theme.dart';
import 'package:daily_us/domain/entities/auth_info.dart';
import 'package:daily_us/presentation/bloc/login/login_bloc.dart';
import 'package:daily_us/presentation/widgets/daily_us_app_bar.dart';
import 'package:daily_us/presentation/widgets/daily_us_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  static const valueKey = ValueKey("LoginPage");

  const LoginPage({
    super.key,
    required this.onSuccessLogin,
  });

  final void Function(AuthInfo) onSuccessLogin;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    context.read<LoginBloc>().stream.listen((state) {
      if (state is LoginStateError) {
        _showSnackbar(context, state.message);
      } else if (state is LoginStateSuccess) {
        _showSnackbar(
          context,
          AppLocalizations.of(context)!.loginSuccessMessage,
        );
        widget.onSuccessLogin(state.authInfo);
      }
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
                SizedBox.expand(
                  child: Column(
                    children: <Widget>[
                      DailyUsAppBar(
                        onBack: () {
                          context.read<LoginBloc>().add(OnCancelLogin());
                          Navigator.of(context).pop();
                        },
                        title: AppLocalizations.of(context)!.titleLogin,
                      ),
                      const SizedBox(
                        height: 32.0,
                      ),
                      DailyUsTextField(
                        controller: _emailController,
                        hintText: AppLocalizations.of(context)!.emailHint,
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      DailyUsTextField(
                        controller: _passwordController,
                        hintText: AppLocalizations.of(context)!.passwordHint,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: screenPaddingSize,
                  left: 0,
                  right: 0,
                  child: appButton(
                    text: AppLocalizations.of(context)!.buttonLogin,
                    showLoadingState:
                        context.watch<LoginBloc>().state is LoginStateLoading,
                    onPressed: () {
                      var email = _emailController.value.text;
                      var password = _passwordController.value.text;
                      _validateForm(context, email, password);
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

  void _validateForm(BuildContext context, String email, String password) {
    if (email.isEmpty) {
      _showSnackbar(
        context,
        AppLocalizations.of(context)!.emailEmptyMessage,
      );
      return;
    }
    if (!validateEmailFormat(email)) {
      _showSnackbar(
        context,
        AppLocalizations.of(context)!.emailInvalidMessage,
      );
      return;
    }
    if (password.isEmpty) {
      _showSnackbar(
        context,
        AppLocalizations.of(context)!.passwordEmptyMessage,
      );
      return;
    }
    if (password.length < 6) {
      _showSnackbar(
        context,
        AppLocalizations.of(context)!.passwordInvalidFormatMessage,
      );
      return;
    }

    context.read<LoginBloc>().add(OnSubmitLogin(email, password));
  }

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          backgroundColor: primaryColor,
          content: Text(
            message,
            style: appTextStyle(
              color: Colors.white,
            ),
          )),
    );
  }
}

import 'package:daily_us/common/constants.dart';
import 'package:daily_us/common/helpers.dart';
import 'package:daily_us/common/localizations.dart';
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
    required this.onBack,
  });

  final void Function(AuthInfo) onSuccessLogin;
  final void Function() onBack;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late AnimationController _animController;
  late Animation<double> _fadeInOpacityAnimValue;
  final _animDuration = const Duration(seconds: 1);
  final _animDelay = const Duration(milliseconds: 300);

  @override
  void initState() {
    super.initState();

    _animController = AnimationController(
      vsync: this,
      duration: _animDuration,
    );
    _fadeInOpacityAnimValue =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animController);

    context.read<LoginBloc>().stream.listen((state) {
      if (state is LoginStateError && mounted) {
        showToast(
          getFailureMessage(context, state.failure),
        );
      } else if (state is LoginStateSuccess && mounted) {
        showToast(
          AppLocalizations.of(context)!.loginSuccessMessage,
          isError: false,
        );

        widget.onSuccessLogin(state.authInfo);
      }
    });

    Future.delayed(
      _animDelay,
      () => _animController.forward(),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Scaffold(
          body: SizedBox.expand(
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: screenPaddingSize),
                child: Stack(
                  alignment: AlignmentDirectional.topCenter,
                  children: <Widget>[
                    SizedBox.expand(
                      child: Column(
                        children: <Widget>[
                          DailyUsAppBar(
                            onBack: () {
                              if (context.mounted) {
                                context
                                    .read<LoginBloc>()
                                    .add(OnCancelLoginEvent());
                                widget.onBack();
                              }
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
                            obscureText: true,
                            hintText:
                                AppLocalizations.of(context)!.passwordHint,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: screenPaddingSize,
                      left: 0,
                      right: 0,
                      child: FadeTransition(
                        opacity: _fadeInOpacityAnimValue,
                        child: appButton(
                          text: AppLocalizations.of(context)!.buttonLogin,
                          showLoadingState: state is LoginStateLoading,
                          onPressed: () {
                            var email = _emailController.value.text;
                            var password = _passwordController.value.text;
                            _validateForm(context, email, password);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _validateForm(BuildContext context, String email, String password) {
    if (email.isEmpty) {
      showToast(
        AppLocalizations.of(context)!.emailEmptyMessage,
      );
      return;
    }
    if (!validateEmailFormat(email)) {
      showToast(
        AppLocalizations.of(context)!.emailInvalidMessage,
      );
      return;
    }
    if (password.isEmpty) {
      showToast(
        AppLocalizations.of(context)!.passwordEmptyMessage,
      );
      return;
    }
    if (!validatePasswordFormat(password)) {
      showToast(
        AppLocalizations.of(context)!.passwordInvalidFormatMessage,
      );
      return;
    }

    context.read<LoginBloc>().add(OnSubmitLoginEvent(email, password));
  }
}

import 'dart:async';

import 'package:daily_us/common/constants.dart';
import 'package:daily_us/common/helpers.dart';
import 'package:daily_us/common/localizations.dart';
import 'package:daily_us/common/ui/theme.dart';
import 'package:daily_us/presentation/bloc/register/register_block.dart';
import 'package:daily_us/presentation/widgets/daily_us_app_bar.dart';
import 'package:daily_us/presentation/widgets/daily_us_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  static const valueKey = ValueKey("RegisterPage");

  const RegisterPage({
    super.key,
    required this.onShouldShowDialog,
    required this.onBack,
  });

  final void Function() onShouldShowDialog;
  final void Function() onBack;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with TickerProviderStateMixin {
  final TextEditingController _nameController = TextEditingController();
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

    context.read<RegisterBloc>().stream.listen((state) async {
      if (state is RegisterStateError && mounted) {
        showToast(
          getFailureMessage(context, state.failure),
        );
      } else if (state is RegisterStateSuccess && mounted) {
        widget.onShouldShowDialog();
      }
    });

    Future.delayed(
      _animDelay,
      () => _animController.forward(),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
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
                Positioned.fill(
                  child: SizedBox.expand(
                    child: Column(
                      children: <Widget>[
                        DailyUsAppBar(
                          onBack: () {
                            if (context.mounted) {
                              context
                                  .read<RegisterBloc>()
                                  .add(OnCancelRegisterEvent());
                              widget.onBack();
                            }
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
                          obscureText: true,
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
                  child: FadeTransition(
                    opacity: _fadeInOpacityAnimValue,
                    child: appButton(
                      text: AppLocalizations.of(context)!.buttonRegister,
                      showLoadingState: context.watch<RegisterBloc>().state
                          is RegisterStateLoading,
                      onPressed: () {
                        var name = _nameController.text.toString();
                        var email = _emailController.text.toString();
                        var password = _passwordController.text.toString();

                        _validateForm(context, name, email, password);
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
  }

  void _validateForm(
    BuildContext context,
    String name,
    String email,
    String password,
  ) {
    if (name.isEmpty) {
      showToast(
        AppLocalizations.of(context)!.nameEmptyMessage,
      );
      return;
    }
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

    context
        .read<RegisterBloc>()
        .add(OnSubmitRegisterEvent(name, email, password));
  }
}

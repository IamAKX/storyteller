import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_teller/screen/onboarding/login_screen.dart';
import 'package:story_teller/util/color.dart';
import 'package:story_teller/util/theme.dart';
import 'package:story_teller/widget/button_progress.dart';
import 'package:story_teller/widget/custom_text.dart';
import 'package:story_teller/widget/gaps.dart';

import '../../service/auth_provider.dart';
import '../../service/snakbar_service.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});
  static const String routePath = '/forgotPasswordScreen';

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController otpCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();

  bool isPasswordVisible = false;

  late AuthProvider _auth;

  togglePasswordVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    SnackBarService.instance.buildContext = context;
    _auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: getBody(context),
    );
  }

  getBody(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(defaultPadding),
      children: [
        verticalGap(defaultPadding),
        Text(
          'Forgot password✨',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Text(
          'Enter registered email to get password reset link',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: themeGrey),
        ),
        verticalGap(defaultPadding),
        getSubTitle('Email'),
        TextField(
          controller: emailCtrl,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            hintText: 'Email',
          ),
        ),
        // TextButton(
        //   onPressed: () {},
        //   child: const Text('Send OTP'),
        // ),
        // verticalGap(defaultPadding),
        // getSubTitle('One Time Password (OTP)'),
        // TextField(
        //   controller: otpCtrl,
        //   keyboardType: TextInputType.number,
        //   decoration: const InputDecoration(
        //     hintText: 'OTP',
        //   ),
        // ),
        // verticalGap(defaultPadding),
        // getSubTitle('New Password'),
        // TextField(
        //   controller: passwordCtrl,
        //   obscureText: !isPasswordVisible,
        //   keyboardType: TextInputType.visiblePassword,
        //   decoration: InputDecoration(
        //     hintText: 'New Password',
        //     suffixIcon: IconButton(
        //       onPressed: () {
        //         togglePasswordVisibility();
        //       },
        //       icon: Icon(
        //         isPasswordVisible ? Icons.visibility_off : Icons.visibility,
        //         color: textColor,
        //       ),
        //     ),
        //   ),
        // ),
        // TextButton(onPressed: () {}, child: const Text('Forgot Password?')),
        verticalGap(defaultPadding * 1.5),
        ElevatedButton(
          onPressed: () {
            _auth.resetPasswordLink(emailCtrl.text).then((value) {
              if (value) {
                Navigator.pushNamedAndRemoveUntil(
                    context, LoginScreen.routePath, (route) => false);
              }
            });
          },
          child: _auth.status == AuthStatus.authenticating
              ? const ButtonProgressIndicator()
              : const Text('Reset Password'),
        ),
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                LoginScreen.routePath, (route) => false);
          },
          child: const Text('Login'),
        )
      ],
    );
  }
}

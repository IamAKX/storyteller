import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_teller/main.dart';
import 'package:story_teller/screen/home_container/home_container.dart';
import 'package:story_teller/screen/onboarding/forgot_password_screen.dart';
import 'package:story_teller/screen/onboarding/register_screen.dart';
import 'package:story_teller/service/snakbar_service.dart';
import 'package:story_teller/util/api.dart';
import 'package:story_teller/util/color.dart';
import 'package:story_teller/util/prefs_key.dart';
import 'package:story_teller/util/theme.dart';
import 'package:story_teller/widget/custom_text.dart';
import 'package:story_teller/widget/gaps.dart';

import '../../service/api_provider.dart';
import '../../service/auth_provider.dart';
import '../../widget/button_progress.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String routePath = '/loginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();

  bool isPasswordVisible = false;
  late AuthProvider _auth;
  late ApiProvider _api;

  togglePasswordVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    SnackBarService.instance.buildContext = context;
    _auth = Provider.of<AuthProvider>(context);
    _api = Provider.of<ApiProvider>(context);
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
          'Log in to your account✨',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Text(
          'Welcome back, please enter your detail',
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
        verticalGap(defaultPadding),
        getSubTitle('Password'),
        TextField(
          controller: passwordCtrl,
          obscureText: !isPasswordVisible,
          keyboardType: TextInputType.visiblePassword,
          decoration: InputDecoration(
            hintText: 'Password',
            suffixIcon: IconButton(
              onPressed: () {
                togglePasswordVisibility();
              },
              icon: Icon(
                isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                color: textColor,
              ),
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                ForgotPasswordScreen.routePath, (route) => false);
          },
          child: const Text('Forgot Password?'),
        ),
        verticalGap(defaultPadding * 1.5),
        ElevatedButton(
          onPressed: () async {
            if (emailCtrl.text.isEmpty || passwordCtrl.text.isEmpty) {
              SnackBarService.instance
                  .showSnackBarError('All fields are mandatory');
              return;
            }
            _auth
                .loginUserWithEmailAndPassword(
                    emailCtrl.text, passwordCtrl.text)
                .then((value) async {
              if (value) {
                Map<String, dynamic> response = await _api
                    .getRequest(Api.getUserByFirebaseAuthId + _auth.user!.uid);
                prefs.setInt(PrefsKey.userId, response['data']['id']);
                prefs.setString(PrefsKey.userFirebaseAuthId, _auth.user!.uid);
                Navigator.of(context).pushNamedAndRemoveUntil(
                    HomeContainer.routePath, (route) => false);
              }
            });
          },
          child: _api.status == ApiStatus.loading ||
                  _auth.status == AuthStatus.authenticating
              ? const ButtonProgressIndicator()
              : const Text('Login'),
        ),
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                RegisterScreen.routePath, (route) => false);
          },
          child: const Text('Register'),
        )
      ],
    );
  }
}

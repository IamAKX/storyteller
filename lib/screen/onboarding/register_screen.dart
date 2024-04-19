import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_teller/enums/subscription_status.dart';
import 'package:story_teller/enums/user_status.dart';
import 'package:story_teller/model/user_model.dart';
import 'package:story_teller/screen/onboarding/login_screen.dart';
import 'package:story_teller/service/api_provider.dart';
import 'package:story_teller/service/auth_provider.dart';
import 'package:story_teller/util/api.dart';
import 'package:story_teller/util/color.dart';
import 'package:story_teller/util/theme.dart';
import 'package:story_teller/widget/custom_text.dart';
import 'package:story_teller/widget/gaps.dart';

import '../../service/snakbar_service.dart';
import '../../widget/button_progress.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const String routePath = '/registerScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController nameCtrl = TextEditingController();

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
          'Create an account✨',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Text(
          'Welcome! please enter your detail',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: themeGrey),
        ),
        verticalGap(defaultPadding),
        getSubTitle('Name'),
        TextField(
          controller: nameCtrl,
          keyboardType: TextInputType.name,
          decoration: const InputDecoration(
            hintText: 'Name',
          ),
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
        verticalGap(defaultPadding * 1.5),
        ElevatedButton(
          onPressed: () {
            if (nameCtrl.text.isEmpty ||
                emailCtrl.text.isEmpty ||
                passwordCtrl.text.isEmpty) {
              SnackBarService.instance
                  .showSnackBarError('All fields are mandatory');
              return;
            }

            _auth
                .registerUserWithEmailAndPassword(
                    nameCtrl.text, emailCtrl.text, passwordCtrl.text)
                .then((value) async {
              if (value) {
                UserModel user = UserModel();
                user.name = nameCtrl.text;
                user.email = emailCtrl.text;
                user.firebaseAuthId = _auth.user?.uid;
                user.status = UserStatus.ACTIVE.name;
                user.subscribtionStatus =
                    SubscribtionStatus.NOT_SUBSCRIBED.name;
                Map<String, dynamic> requestBody = user.toMap();
                requestBody.removeWhere((key, value) => value == null);
                _api.postRequest(Api.createUser, requestBody).then((value) {
                  debugPrint('resp : $value');
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      LoginScreen.routePath, (route) => false);
                });
              }
            });
          },
          child: _api.status == ApiStatus.loading ||
                  _auth.status == AuthStatus.authenticating
              ? const ButtonProgressIndicator()
              : const Text('Register'),
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

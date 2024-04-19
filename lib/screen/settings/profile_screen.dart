import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_teller/main.dart';
import 'package:story_teller/model/user_model.dart';
import 'package:story_teller/util/api.dart';
import 'package:story_teller/util/color.dart';
import 'package:story_teller/util/prefs_key.dart';
import 'package:story_teller/widget/button_progress.dart';
import 'package:story_teller/widget/gaps.dart';

import '../../service/api_provider.dart';
import '../../service/auth_provider.dart';
import '../../service/snakbar_service.dart';
import '../../util/theme.dart';
import '../../widget/custom_text.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  static const String routePath = '/profileScreen';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController bioCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();

  bool isPasswordVisible = false;
  late AuthProvider _auth;
  late ApiProvider _api;
  UserModel? user;

  togglePasswordVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => reloadScreen(),
    );
  }

  reloadScreen() async {
    await _api
        .getRequest(
            '${Api.getAllUserById}${prefs.getInt(PrefsKey.userId).toString()}')
        .then((value) {
      user = UserModel.fromMap(value['data']);
      nameCtrl.text = user?.name ?? '';
      phoneCtrl.text = user?.mobile ?? '';
      bioCtrl.text = user?.bio ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    SnackBarService.instance.buildContext = context;
    _auth = Provider.of<AuthProvider>(context);
    _api = Provider.of<ApiProvider>(context);

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: defaultPadding,
            ),
            child: getSubTitle('Profile'),
          ),
          verticalGap(defaultPadding),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              children: [
                getSubTitle('Name'),
                TextField(
                  controller: nameCtrl,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    hintText: 'Name',
                  ),
                ),
                verticalGap(defaultPadding),
                getSubTitle('Phone'),
                TextField(
                  controller: phoneCtrl,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  decoration: const InputDecoration(
                    hintText: 'Phone',
                  ),
                ),
                verticalGap(defaultPadding),
                getSubTitle('Bio'),
                TextField(
                  controller: bioCtrl,
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  minLines: 3,
                  decoration: const InputDecoration(
                      hintText: 'Bio', alignLabelWithHint: true),
                ),
                verticalGap(defaultPadding),
                ElevatedButton(
                  onPressed: () {
                    if (nameCtrl.text.isEmpty) {
                      SnackBarService.instance
                          .showSnackBarError('Name cannot be empty');
                      return;
                    }
                    Map<String, dynamic> requestBody = {};
                    requestBody['name'] = nameCtrl.text;

                    if (phoneCtrl.text.isNotEmpty &&
                        phoneCtrl.text.length != 10) {
                      SnackBarService.instance
                          .showSnackBarError('Invalid phone number');
                      return;
                    }
                    if (phoneCtrl.text.length == 10) {
                      requestBody['mobile'] = phoneCtrl.text;
                    }

                    if (bioCtrl.text.isNotEmpty) {
                      requestBody['bio'] = bioCtrl.text;
                    }

                    _api
                        .putRequest('${Api.updateUser}${user?.id}', requestBody)
                        .then((value) => SnackBarService.instance
                            .showSnackBarInfo(value['message']));
                  },
                  child: _api.status == ApiStatus.loading
                      ? const ButtonProgressIndicator()
                      : const Text('Save'),
                ),
                verticalGap(defaultPadding),
                const Divider(
                  color: themeGrey,
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
                        isPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: textColor,
                      ),
                    ),
                  ),
                ),
                verticalGap(defaultPadding),
                ElevatedButton(
                  onPressed: () {
                    if (passwordCtrl.text.isEmpty) {
                      SnackBarService.instance
                          .showSnackBarError('Enter new password');
                      return;
                    }
                    _auth.updatePassword(passwordCtrl.text).then((value) {
                      if (value) {
                        passwordCtrl.text = '';
                      }
                    });
                  },
                  child: _auth.status == AuthStatus.authenticating
                      ? const ButtonProgressIndicator()
                      : const Text('Save'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

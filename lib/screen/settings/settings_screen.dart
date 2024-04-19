import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_teller/main.dart';
import 'package:story_teller/screen/onboarding/login_screen.dart';
import 'package:story_teller/screen/settings/profile_screen.dart';
import 'package:story_teller/screen/settings/subscribtion_screen.dart';
import 'package:story_teller/util/color.dart';

import '../../service/api_provider.dart';
import '../../service/auth_provider.dart';
import '../../service/snakbar_service.dart';
import '../../util/theme.dart';
import '../../widget/custom_text.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late AuthProvider _auth;
  late ApiProvider _api;

  @override
  Widget build(BuildContext context) {
    SnackBarService.instance.buildContext = context;
    _auth = Provider.of<AuthProvider>(context);
    _api = Provider.of<ApiProvider>(context);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: defaultPadding,
              top: defaultPadding,
            ),
            child: getSubTitle('Settings'),
          ),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  onTap: () =>
                      Navigator.of(context).pushNamed(ProfileScreen.routePath),
                  leading: const Icon(
                    Icons.person_outline,
                    color: Colors.green,
                  ),
                  title: const Text('Profile'),
                ),
                const Divider(
                  color: themeGrey,
                ),
                ListTile(
                  onTap: () => Navigator.of(context)
                      .pushNamed(SubscribtionScreen.routePath),
                  leading: const Icon(
                    Icons.card_membership_outlined,
                    color: Colors.amber,
                  ),
                  title: const Text('Subscription'),
                ),
                const Divider(
                  color: themeGrey,
                ),
                const ListTile(
                  leading: Icon(
                    Icons.feedback_outlined,
                    color: Colors.cyan,
                  ),
                  title: Text('Feedback'),
                ),
                const Divider(
                  color: themeGrey,
                ),
                ListTile(
                  onTap: () {
                    prefs.clear();
                    _auth.logoutUser();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        LoginScreen.routePath, (route) => false);
                  },
                  leading: const Icon(
                    Icons.logout_outlined,
                    color: Colors.red,
                  ),
                  title: const Text('Logout'),
                ),
                const Divider(
                  color: themeGrey,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'version 0.0.1',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: themeGrey),
                ),
                Text(
                  '© 2024, Story Teller',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: themeGrey),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

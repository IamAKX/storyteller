import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story_teller/screen/home_container/home_container.dart';
import 'package:story_teller/screen/onboarding/login_screen.dart';
import 'package:story_teller/service/api_provider.dart';
import 'package:story_teller/util/theme.dart';

import 'firebase_options.dart';
import 'service/auth_provider.dart';
import 'util/router.dart';

late SharedPreferences prefs;
final navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => ApiProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Story Teller',
        debugShowCheckedModeBanner: false,
        theme: globalTheme(context),
        onGenerateRoute: NavRoute.generatedRoute,
        home: getHomePage(),
      ),
    );
  }

  Widget getHomePage() {
    if (AuthProvider.instance.user != null) {
      return const HomeContainer();
    }
    return const LoginScreen();
  }
}

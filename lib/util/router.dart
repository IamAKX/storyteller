import 'package:flutter/material.dart';
import 'package:story_teller/model/story_model.dart';
import 'package:story_teller/screen/chat_screen/chat_screen.dart';
import 'package:story_teller/screen/home_container/home_container.dart';
import 'package:story_teller/screen/onboarding/forgot_password_screen.dart';
import 'package:story_teller/screen/onboarding/register_screen.dart';
import 'package:story_teller/screen/settings/profile_screen.dart';
import 'package:story_teller/screen/settings/subscribtion_screen.dart';

import '../screen/onboarding/login_screen.dart';

class NavRoute {
  static MaterialPageRoute<dynamic> generatedRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginScreen.routePath:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case RegisterScreen.routePath:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case ForgotPasswordScreen.routePath:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case HomeContainer.routePath:
        return MaterialPageRoute(builder: (_) => const HomeContainer());
      case ProfileScreen.routePath:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case SubscribtionScreen.routePath:
        return MaterialPageRoute(builder: (_) => const SubscribtionScreen());
      case ChatScreen.routePath:
        return MaterialPageRoute(
          builder: (_) => ChatScreen(
            story: settings.arguments as StoryModel,
          ),
        );

      default:
        return errorRoute();
    }
  }
}

errorRoute() {
  return MaterialPageRoute(builder: (_) {
    return const Scaffold(
      body: Center(
        child: Text('Undefined route'),
      ),
    );
  });
}

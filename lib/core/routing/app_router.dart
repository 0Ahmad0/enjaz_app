import 'package:flutter/material.dart';

import '../../app/features/all_members/screens/all_members_screen.dart';
import '../../app/features/auth/screens/check_inbox_screen.dart';
import '../../app/features/auth/screens/forgot_password_screen.dart';
import '../../app/features/auth/screens/login_screen.dart';
import '../../app/features/auth/screens/sign_up_screen.dart';
import '../../app/features/create_project/screens/create_project_screen.dart';
import '../../app/features/messages/screens/messages_screen.dart';
import '../../app/features/navbar/screens/navbar_screen.dart';
import '../../app/features/progress_pictures/screens/progress_picture_screen.dart';
import '../../app/features/project_details/screens/project_details_screen.dart';
import '../../app/features/splash/splash_screen.dart';
import 'routes.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(
          builder: (_) => SplashScreen(),
        );

      case Routes.loginRoute:
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );
      case Routes.signUpRoute:
        return MaterialPageRoute(
          builder: (_) => SignUpScreen(),
        );
      case Routes.forgotPasswordRoute:
        return MaterialPageRoute(
          builder: (_) => ForgotPasswordScreen(),
        );
      case Routes.checkYourInboxRoute:
        return MaterialPageRoute(
          builder: (_) => CheckInboxScreen(),
        );

      /// Nav Bar Screens
      case Routes.navbarRoute:
        return MaterialPageRoute(
          builder: (_) => NavbarScreen(),
        );
        case Routes.messagesRoute:
        return MaterialPageRoute(
          builder: (_) => MessagesScreen(),
        );
      case Routes.createProjectRoute:
        return MaterialPageRoute(
          builder: (_) => CreateProjectScreen(),
        );
        case Routes.projectDetailsRoute:
        return MaterialPageRoute(
          builder: (_) => ProjectDetailsScreen(),
        );
        case Routes.progressPictureRoute:
        return MaterialPageRoute(
          builder: (_) => ProgressPictureScreen(),
        );
        case Routes.allMembersRoute:
        return MaterialPageRoute(
          builder: (_) => AllMembersScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('NO DATA')),
          ),
        );
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manager/ui/controller/auth_controller.dart';
import 'package:task_manager/ui/screens/auth%20screen/sign_in_screen.dart';
import 'package:task_manager/ui/screens/main_bottom_nav_screen.dart';
import 'package:task_manager/ui/utilities/asset_path.dart';
import 'package:task_manager/ui/widgets/background_widgets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 1));

    bool isLoggedIn = await AuthController.checkAuthState();

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              isLoggedIn ? const MainBottomNavScreen() : const SignInScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGroundWidgets(
        child: Center(
          child: SvgPicture.asset(
            AssetPath.logoSvg,
            width: 160,
          ),
        ),
      ),
    );
  }
}

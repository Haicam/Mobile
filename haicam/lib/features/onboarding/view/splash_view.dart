import 'package:flutter/material.dart';
import 'package:prac_haicam/core/utils/app_colors.dart';
import 'package:prac_haicam/core/utils/app_images.dart';
import 'package:prac_haicam/features/auth/view/login_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    goToHome();
  }

  void goToHome() async {
    await Future.delayed(const Duration(milliseconds: 3000), () {});
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginView(),
      ),
    );
  }

  validateAndSubmit() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        color: AppColors.lightGrey,
        alignment: Alignment.center,
        child: const Image(
          image: AssetImage(appLogoImage),
        ),
      ),
    );
  }
}

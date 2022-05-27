import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prac_haicam/common/widgets/base_widget.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  validateAndSubmit() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.primary,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            addHeight(100),
            logoText('WADERA'),
            addHeight(30),
            regularSpace(),
            headerTitleText('SIGN UP'),
            addHeight(30),
            appPrimaryTextField(
                'Email', false, FontAwesomeIcons.envelope, "email"),
            regularSpace(),
            appPrimaryTextField(
                'Mobile', false, FontAwesomeIcons.phone, "phone"),
            regularSpace(),
            appPrimaryTextField(
                'Password', true, FontAwesomeIcons.eyeSlash, "password"),
            addHeight(30),
            appPrimaryButton('Register', validateAndSubmit),
            regularSpace(),
            horizentalBar(),
            regularSpace(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [bodyDarkText('Back to login')],
            ),
          ],
        ),
      ),
    );
  }
}

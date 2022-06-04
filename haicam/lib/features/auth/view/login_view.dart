import 'package:flutter/material.dart';
import 'package:prac_haicam/common/utils/app_colors.dart';
import 'package:prac_haicam/common/utils/app_font.dart';
import 'package:prac_haicam/common/widgets/base_widget.dart';
import 'package:prac_haicam/features/home/view/home_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  var email, password, phoneNumber, fullName;
  final formKey = GlobalKey<FormState>();

  goToHome() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeView(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: buildMainView(),
      ),
    );
  }

  Widget buildMainView() {
    return SingleChildScrollView(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 20, left: 16.0, right: 16, bottom: 16),
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16.0),
          child: buildContentView(),
        ),
      ),
    );
  }

  Widget buildContentView() {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: buildLogoTextView() + buildInputView(),
      ),
    );
  }

  List<Widget> buildLogoTextView() {
    return <Widget>[
      addHeight(60),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          logoText('HAICAM'),
        ],
      ),
      addHeight(50),
      bodyLightText('Get great experience with tracky'),
      addHeight(20),
    ];
  }

  List<Widget> buildInputView() {
    return <Widget>[
      Container(
        height: 50,
        padding: const EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          color: AppColors.lightGrey,
          borderRadius: BorderRadius.circular(50),
        ),
        child: TabBar(
          indicatorColor: AppColors.lightGrey,
          labelColor: AppColors.unSelectedTab,
          unselectedLabelColor: AppColors.selectedTab,
          indicatorWeight: 5,
          labelStyle: const TextStyle(fontSize: AppFonts.bodySizePrimary),
          indicator: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(50),
          ),
          tabs: const [
            Tab(text: ("Sign In")),
            Tab(text: "Sign Up"),
          ],
        ),
      ),
      addHeight(20),
      Container(
        height: 500,
        padding: const EdgeInsets.all(2.0),
        decoration: const BoxDecoration(),
        child: TabBarView(
          children: <Widget>[
            buildSignInTab(),
            buildSignUpTab(),
          ],
        ),
      ),
    ];
  }

  Widget buildSignInTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        addHeight(20),
        bodyDarkText('Username / Email'),
        regularSpace(),
        SizedBox(
          child: TextField(
            minLines: 1,
            key: email,
            obscureText: false,
            style: const TextStyle(fontSize: 12, height: 0.5),
            decoration: InputDecoration(
              labelStyle: const TextStyle(color: AppColors.lightGrey2),
              labelText: "Enter your email",
              prefixIcon: const Icon(
                Icons.person,
                size: 18,
                color: AppColors.lightGrey2,
              ),
              suffixIconColor: AppColors.lightGrey2,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: AppColors.lightGrey2,
                  width: 0.5,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    const BorderSide(color: AppColors.lightGrey2, width: 0.5),
              ),
            ),
          ),
        ),
        addHeight(20),
        bodyDarkText('Password'),
        regularSpace(),
        SizedBox(
          child: TextField(
            minLines: 1,
            key: password,
            obscureText: true,
            style: const TextStyle(fontSize: 12, height: 0.5),
            decoration: InputDecoration(
              labelStyle: const TextStyle(color: AppColors.lightGrey2),
              labelText: "Enter your password",
              prefixIcon: const Icon(
                Icons.lock,
                size: 18,
                color: AppColors.lightGrey2,
              ),
              suffixIconColor: AppColors.lightGrey2,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: AppColors.lightGrey2,
                  width: 0.5,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    const BorderSide(color: AppColors.lightGrey2, width: 0.5),
              ),
            ),
          ),
        ),
        addHeight(30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            appPrimaryButton('Sign in', goToHome),
          ],
        ),
        addHeight(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            bodyLightText(
              'Forgot Password?',
            ),
          ],
        ),
      ],
    );
  }

  Widget buildSignUpTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        addHeight(30),
        bodyDarkText('Full Name'),
        regularSpace(),
        SizedBox(
          child: TextField(
            minLines: 1,
            key: fullName,
            obscureText: false,
            style: const TextStyle(fontSize: 12, height: 0.5),
            decoration: InputDecoration(
              labelStyle: const TextStyle(color: AppColors.lightGrey2),
              labelText: "Enter your name",
              prefixIcon: const Icon(
                Icons.person,
                size: 18,
                color: AppColors.lightGrey2,
              ),
              suffixIconColor: AppColors.lightGrey2,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: AppColors.lightGrey2,
                  width: 0.5,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    const BorderSide(color: AppColors.lightGrey2, width: 0.5),
              ),
            ),
          ),
        ),
        addHeight(30),
        bodyDarkText('Phone Number'),
        regularSpace(),
        SizedBox(
          child: TextField(
            minLines: 1,
            key: phoneNumber,
            obscureText: false,
            style: const TextStyle(fontSize: 12, height: 0.5),
            decoration: InputDecoration(
              labelStyle: const TextStyle(color: AppColors.lightGrey2),
              labelText: "Enter your number",
              prefixIcon: const Icon(
                Icons.phone,
                size: 18,
                color: AppColors.lightGrey2,
              ),
              suffixIconColor: AppColors.lightGrey2,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: AppColors.lightGrey2,
                  width: 0.5,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    const BorderSide(color: AppColors.lightGrey2, width: 0.5),
              ),
            ),
          ),
        ),
        addHeight(30),
        bodyDarkText('Password'),
        regularSpace(),
        SizedBox(
          child: TextField(
            minLines: 1,
            key: password,
            obscureText: true,
            style: const TextStyle(fontSize: 12, height: 0.5),
            decoration: InputDecoration(
              labelStyle: const TextStyle(color: AppColors.lightGrey2),
              labelText: "Enter your password",
              prefixIcon: const Icon(
                Icons.lock,
                size: 18,
                color: AppColors.lightGrey2,
              ),
              suffixIconColor: AppColors.lightGrey2,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: AppColors.lightGrey2,
                  width: 0.5,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    const BorderSide(color: AppColors.lightGrey2, width: 0.5),
              ),
            ),
          ),
        ),
        addHeight(30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            appPrimaryButton('Create Account', goToHome),
          ],
        ),
      ],
    );
  }
}

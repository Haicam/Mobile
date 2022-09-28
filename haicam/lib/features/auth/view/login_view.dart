import 'package:flutter/material.dart';
import 'package:prac_haicam/core/utils/app_colors.dart';
import 'package:prac_haicam/core/utils/app_fonts.dart';
import 'package:prac_haicam/common/widgets/base_widget.dart';
import 'package:prac_haicam/core/utils/app_routes.dart' as route;

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final formKey = GlobalKey<FormState>();

  // onTap SignIn
  validateAndSubmit() {
    Navigator.pushNamed(context, route.homeView);
  }

// This widget is the root of view.
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: _buildMainView(),
      ),
    );
  }

// build Main (elements and scroll view)
  Widget _buildMainView() {
    return SingleChildScrollView(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 20, left: 16.0, right: 16, bottom: 16),
        child: _buildContentView(),
      ),
    );
  }

//build content (build and form view)
  Widget _buildContentView() {
    return Form(
      key: const Key('form_key'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildLogoTextView() + _buildInputView(),
      ),
    );
  }

// build app logo OR Text
  List<Widget> _buildLogoTextView() {
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

// build auth Tab view
  List<Widget> _buildInputView() {
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
            Tab(text: ("Sign Up")),
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
            _buildSignInTab(),
            _buildSignUpTab(),
          ],
        ),
      ),
    ];
  }

// build sign-in view
  Widget _buildSignInTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        addHeight(20),
        bodyDarkText('Username / Email'),
        regularSpace(),
        SizedBox(
          child: TextField(
            minLines: 1,
            key: const Key('email'),
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
            key: const Key('password'),
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
            appPrimaryButton('Sign in', validateAndSubmit),
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

// build sign-up view
  Widget _buildSignUpTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        addHeight(30),
        bodyDarkText('Full Name'),
        regularSpace(),
        SizedBox(
          child: TextField(
            minLines: 1,
            key: const Key('full_name'),
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
            key: const Key('phone_number'),
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
            key: const Key('password'),
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
            appPrimaryButton('Create Account', validateAndSubmit),
          ],
        ),
      ],
    );
  }
} //end

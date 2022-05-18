import 'package:flutter/material.dart';
import 'package:prac_haicam/common/utils/app_colors.dart';
import 'package:prac_haicam/common/utils/app_font.dart';
import 'package:prac_haicam/common/widgets/base_widget.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  validateAndSubmit() {}
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _buildMainView(),
      ),
    );
  }

  Widget _buildMainView() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          addHeight(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              logoText('HAICAM'),
            ],
          ),
          addHeight(40),
          // bodyDarkText('Login'),
          bodyLightText('Get great experience with tracky'),
          addHeight(20),
          Container(
            height: 40,
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
              labelStyle: const TextStyle(fontSize: AppFonts.smallSize),
              indicator: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(50),
              ),
              tabs: const [
                Tab(
                  text: "Sign In",
                ),
                Tab(text: "Sign Up"),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                Center(
                  child: _buildTabSignIn(),
                ),
                Center(
                  child: _buildTabSignUp(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabSignIn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        addHeight(30),
        bodyDarkText('Username / Email'),
        regularSpace(),
        appPrimaryTextField(
            'Enter your username', false, Icons.person, "email"),
        regularSpace(),
        bodyDarkText('Password'),
        regularSpace(),
        appPrimaryTextField(
            'Enter your password', true, Icons.lock, "password"),
        addHeight(15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            appPrimaryButton('Sign in', validateAndSubmit),
          ],
        ),
        addHeight(15),
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

  Widget _buildTabSignUp() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        addHeight(30),
        bodyDarkText('Full Name'),
        regularSpace(),
        appPrimaryTextField(
            'Enter your username', false, Icons.person, "email"),
        regularSpace(),
        bodyDarkText('Phone Number'),
        regularSpace(),
        appPrimaryTextField(
            'Enter your number', false, Icons.phone, "password"),
        regularSpace(),
        bodyDarkText('Password'),
        regularSpace(),
        appPrimaryTextField('Enter your password', true, Icons.lock, "phone"),
        addHeight(15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            appPrimaryButton('Create Account', validateAndSubmit),
          ],
        ),
      ],
    );
  }
}

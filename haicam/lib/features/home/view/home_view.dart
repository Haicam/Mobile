import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:prac_haicam/common/widgets/base_widget.dart';
import 'package:prac_haicam/features/home/controller/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.primary,
      body: SingleChildScrollView(
        child: Column(
          children: [
            logoText('HAICAM'),
          ],
        ),
      ),
    );
  }
}

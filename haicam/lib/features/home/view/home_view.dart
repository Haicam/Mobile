import 'package:flutter/material.dart';
import 'package:prac_haicam/common/widgets/base_widget.dart';
import 'package:prac_haicam/features/menu/widget/navigation_drawer_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: const IconThemeData(),
        title: Center(child: logoText("HAICAM")),
      ),
      drawer: NavigationDrawer(),
      body: Center(child: headerTitleText("HOME")),
    );
  }
}

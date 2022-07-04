import 'package:flutter/material.dart';
import 'package:prac_haicam/common/drawer/navigation_drawer_widget.dart';
import 'package:prac_haicam/common/widgets/base_widget.dart';

class WorldWarView extends StatefulWidget {
  const WorldWarView({Key? key}) : super(key: key);

  @override
  State<WorldWarView> createState() => _WorldWarViewState();
}

class _WorldWarViewState extends State<WorldWarView> {
  // This widget is the root of view.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: const IconThemeData(),
        title: Center(child: bodyDarkText("World War II")),
        actions: [
          Container(),
        ],
      ),
      drawer: NavigationDrawer(),
      body: buildMainView(),
    );
  }

  // build main
  Widget buildMainView() {
    return Center(
      child: Text('World War II'),
    );
  }
}

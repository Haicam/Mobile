import 'package:flutter/material.dart';
import 'package:prac_haicam/features/home/view/home_view.dart';
import 'package:prac_haicam/features/setting/view/app_setting_view.dart';

class NavigationDrawer extends StatelessWidget {
  final padding = const EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {
    const name = 'Frank';
    const email = 'frank@haicam.tech';

    return Drawer(
      child: Material(
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 40),
            buildHeader(
              name: name,
              email: email,
              onClicked: () => Navigator.of(context).pop(),
            ),
            Container(
              padding: padding,
              child: Column(
                children: [
                  const Divider(),
                  buildMenuItem(
                    text: 'Home',
                    icon: Icons.home,
                    onClicked: () => selectedItem(context, 0),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Setting',
                    icon: Icons.settings,
                    onClicked: () => selectedItem(context, 1),
                  ),
                  // const SizedBox(height: 16),
                  // buildMenuItem(
                  //   text: 'Camera Setting',
                  //   icon: Icons.camera,
                  //   onClicked: () => selectedItem(context, 2),
                  // ),
                  // buildMenuItem(
                  //   text: 'Devices',
                  //   icon: Icons.device_hub,
                  //   onClicked: () => selectedItem(context, 3),
                  // ),
                  // const SizedBox(height: 16),
                  // buildMenuItem(
                  //   text: 'Logout',
                  //   icon: Icons.logout,
                  //   onClicked: () => selectedItem(context, 4),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader({
    required String name,
    required String email,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(const EdgeInsets.symmetric(vertical: 5)),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const CircleAvatar(
                radius: 12,
                // backgroundColor: AppColors.black,
                child: Icon(Icons.close),
              )
            ],
          ),
        ),
      );

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    // const color = Colors.black;
    // const hoverColor = Colors.black87;

    return ListTile(
      // leading: Icon(icon, color: backgroundColor),
      leading: Icon(icon),
      // title: Text(text, style: const TextStyle(color: backgroundColor)),
      title: Text(text),
      // hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const HomeView(),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const AppSettingView(),
        ));
        break;
    }
  }
}

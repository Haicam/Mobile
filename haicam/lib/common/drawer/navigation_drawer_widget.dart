import 'package:flutter/material.dart';
import 'package:prac_haicam/core/utils/app_routes.dart' as route;
import 'package:prac_haicam/localization/language_constants.dart';

import '../../core/utils/local_string.dart';
import '../../features/camera/view/addcamera/add_camera_screen.dart';

class NavigationDrawer extends StatelessWidget {
  final padding = const EdgeInsets.symmetric(horizontal: 20);

   static const int MENU_ITEM_INDEX_HOME = 0,
      MENU_ITEM_INDEX_ADD_CAMERA = 1,
      MENU_ITEM_INDEX_SETTINGS = 2,
      MENU_ITEM_INDEX_WORL_WAR_II = 3;

  // This widget is the root of the widget.
  // Including Drawer View list menu
  // Name and Email data
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
                    text: getTranslated(context, LocalString.home)!,
                    icon: Icons.home,
                    onClicked: () => selectedItem(context, MENU_ITEM_INDEX_HOME),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: getTranslated(context, LocalString.add_camera)!,
                    icon: Icons.add_a_photo,
                    onClicked: () => selectedItem(context, MENU_ITEM_INDEX_ADD_CAMERA),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: getTranslated(context, LocalString.setting)!,
                    icon: Icons.settings,
                    onClicked: () => selectedItem(context, MENU_ITEM_INDEX_SETTINGS),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: getTranslated(context, LocalString.world_war_II)!,
                    icon: Icons.history_edu,
                    onClicked: () => selectedItem(context, MENU_ITEM_INDEX_WORL_WAR_II),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

//build drawer header view
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

  //build drawer item list setting
  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    return ListTile(
      // leading: Icon(icon, color: backgroundColor),
      leading: Icon(icon),
      // title: Text(text, style: const TextStyle(color: backgroundColor)),
      title: Text(text),
      // hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

//build on selected action
  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();
    switch (index) {
      case MENU_ITEM_INDEX_HOME:
        Navigator.pushNamed(context, route.homeView);
        break;
      case MENU_ITEM_INDEX_SETTINGS:
        Navigator.pushNamed(context, route.appSettingView);
        break;
      case MENU_ITEM_INDEX_WORL_WAR_II:
        Navigator.pushNamed(context, route.worldWarView);
        break;

      case MENU_ITEM_INDEX_ADD_CAMERA:
        Navigator.push(context,
            new MaterialPageRoute(builder: (context) => new AddCameraScreen()));
        break;
    }
  }
} //end

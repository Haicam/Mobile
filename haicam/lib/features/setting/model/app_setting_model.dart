import 'package:flutter/material.dart';

List dataList = [
  {
    "name": "More Setting",
    // "icon": Icons.payment,
    "subMenu": [
      {"name": "Hub"},
      {"name": "Device"}
    ]
  },
  // {
  //   "name": "m-1",
  //   "icon": Icons.volume_up,
  //   "subMenu": [
  //     {
  //       "name": "ms-1",
  //       "subMenu": [
  //         {"name": "ms-m"},
  //         {"name": "ms-m"}
  //       ]
  //     },
  //     {
  //       "name": "ms-2",
  //       "subMenu": [
  //         {"name": "ms-m"}
  //       ]
  //     },
  //     {
  //       "name": "ms-3",
  //       "subMenu": [
  //         {"name": "ms-m"},
  //         {"name": "ms-m"}
  //       ]
  //     },
  //     {
  //       "name": "ms-4",
  //       "subMenu": [
  //         {"name": "ms-m"},
  //         {"name": "ms-m"}
  //       ]
  //     }
  //   ]
  // }
];

class Menu {
  String? name;
  IconData? icon;
  List<Menu>? subMenu = [];

  Menu({this.name, this.subMenu, this.icon});

  Menu.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    icon = json['icon'];
    if (json['subMenu'] != null) {
      subMenu?.clear();
      json['subMenu'].forEach((v) {
        subMenu?.add(Menu.fromJson(v));
      });
    }
  }
}

import 'package:flutter/material.dart';
import 'package:quran/ui/contents/deceased_prayer_page.dart';
import 'package:quran/ui/contents/developer_page.dart';
import 'package:quran/ui/contents/help_page.dart';
import 'package:quran/ui/contents/share_page.dart';

class DrawerModel {
  late int id;
  late String title;
  late IconData icon;
  late Widget launchWidget;

  DrawerModel(
      {required this.id,
      required this.title,
      required this.launchWidget,
      required this.icon});
}

/*
Banner Data Information
width = 800px
height = 600px
 */

List<DrawerModel> drawerModelData = [
  DrawerModel(
      id: 1,
      title: "Doa Almarhum",
      icon: Icons.front_hand_outlined,
      launchWidget: const DeceasedPrayerPage()),
  DrawerModel(
      id: 2,
      title: "Pengembang",
      icon: Icons.info_outline,
      launchWidget: const DeveloperPage()),
  DrawerModel(
      id: 3,
      title: "Bantuan",
      icon: Icons.help_outline_outlined,
      launchWidget: const HelpPage()),
  DrawerModel(
      id: 4,
      title: "Bagikan",
      icon: Icons.star_border,
      launchWidget: const SharePage()),
];

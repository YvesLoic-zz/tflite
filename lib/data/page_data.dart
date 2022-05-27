import 'package:flutter/material.dart';

class PageData {
  final String title;
  final IconData icon;
  final Color bgColor;
  final Color textColor;
  final Color logoColor;
  final Color cardColor;
  final String screen;
  final String subtitle;

  PageData({
    required this.title,
    required this.icon,
    this.bgColor = Colors.white,
    this.textColor = Colors.black,
    required this.logoColor,
    required this.cardColor,
    required this.screen,
    required this.subtitle,
  });
}

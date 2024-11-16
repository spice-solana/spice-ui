import 'package:flutter/material.dart';

enum AppIcon { ligthIcon, darkIcon }

final appicon = {
  AppIcon.ligthIcon: const Icon(Icons.nightlight_outlined, color: Colors.black),
  AppIcon.darkIcon: const Icon(Icons.sunny, color: Colors.grey),
};
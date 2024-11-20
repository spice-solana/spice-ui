import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:oktoast/oktoast.dart';
import 'package:spice_ui/screens/home_screen.dart';
import 'package:spice_ui/screens/notification_screen.dart';
import 'package:spice_ui/theme/controller/tb_cubit.dart';
import 'package:spice_ui/theme/controller/theme_states.dart';
import 'package:spice_ui/theme/themes.dart';
import 'package:spice_ui/transaction_bundle/controller/tb_cubit.dart';
import 'package:spice_ui/widgets/no_thumb_scroll_behavior.dart';


void main() async {
  var path = kIsWeb ? "" : Directory.systemTemp.path;
  Hive.init(path);

  await Hive.openBox('appBox');

  runApp(BlocProvider<ThemeCubit>(
      create: (context) => ThemeCubit(),
      child: BlocProvider<TbCubit>(
          create: (context) => TbCubit(),
          child: BlocBuilder<ThemeCubit, ThemeState>(builder: (context, state) {
            final bool isMobile = !kIsWeb ||
                (defaultTargetPlatform == TargetPlatform.iOS ||
                    defaultTargetPlatform == TargetPlatform.android) ||
                MediaQuery.of(context).size.width < 1258;
            return OKToast(
              child: MaterialApp(
                title: 'Spice',
                scrollBehavior:
                    NoThumbScrollBehavior().copyWith(scrollbars: false),
                debugShowCheckedModeBanner: false,
                theme: state.darkTheme
                    ? apptheme[AppTheme.dark]
                    : apptheme[AppTheme.ligth],
                home: isMobile ? const NotificationScreen() : const HomeScreen(),
              ),
            );
          }))));
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spice_ui/screens/home_screen.dart';
import 'package:spice_ui/theme/controller/theme_cubit.dart';
import 'package:spice_ui/theme/controller/theme_states.dart';
import 'package:spice_ui/theme/themes.dart';
import 'package:spice_ui/widgets/no_thumb_scroll_behavior.dart';

void main() async {

  // var path = kIsWeb ? "" : Directory.systemTemp.path;
  // Hive.init(path);

  runApp(BlocProvider<ThemeCubit>(
      create: (context) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
        return MaterialApp(
          title: 'Spice',
          scrollBehavior: NoThumbScrollBehavior().copyWith(scrollbars: false),
          debugShowCheckedModeBanner: false,
          theme: state.darkTheme
              ? apptheme[AppTheme.dark]
              : apptheme[AppTheme.ligth],
          home: const HomeScreen(),
        );
  })));
}

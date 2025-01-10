import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spice_ui/theme/controller/theme_cubit.dart';
import 'package:spice_ui/theme/controller/theme_states.dart';
import 'package:spice_ui/transaction_bundle/theme_icons.dart';
import 'package:spice_ui/widgets/backlight_custom_icon.dart';
import 'package:spice_ui/widgets/backlight_icon.dart';
import 'package:spice_ui/widgets/custom_tb_menu.dart';
import 'package:spice_ui/widgets/custom_vertical_divider.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;


class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
          height: 36.0,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              border: Border(
                  top: BorderSide(
                      color: Colors.grey.withOpacity(0.2), width: 1.0))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // SizedBox(
                      //   height: 10.0,
                      //   width: 10.0,
                      //   child: rive.RiveAnimation.asset(
                      //     'assets/rive/live.riv',
                      //     fit: BoxFit.cover,
                      //     alignment: Alignment.center,
                      //   ),
                      // ),
                      // SizedBox(width: 16.0),
                      // Text('Live')
                      Container(
                        height: 8.0,
                        width: 8.0,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.amber),
                      ),
                      const SizedBox(width: 16.0),
                      const Text('Testnet', style: TextStyle(fontSize: 14.0))
                    ],
                  ),
                  const SizedBox(width: 32.0),
                  const CustomVerticalDivider(height: 36.0),
                  const SizedBox(width: 32.0),
                  BlocBuilder<ThemeCubit, ThemeState>(
                      builder: (context, state) => BacklightIcon(
                          iconData: appicon[state.darkTheme],
                          iconSize: 18.0,
                          onTap: () =>
                              context.read<ThemeCubit>().changeTheme())),
                  const SizedBox(width: 32.0),
                  const CustomVerticalDivider(height: 36.0),
                  const SizedBox(width: 32.0),
                  const CustomTbMenu(),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BacklightCustomIcon(
                      assetIcon: "x",
                      onTap: () => js.context
                          .callMethod('open', ['https://x.com/spice_protocol']),
                      iconSize: 17.0),
                  const SizedBox(width: 32.0),
                  BacklightCustomIcon(
                      assetIcon: "telegram",
                      onTap: () => js.context
                          .callMethod('open', ['https://t.me/spicelp']),
                      iconSize: 17.0),
                  const SizedBox(width: 32.0),
                  BacklightCustomIcon(
                      assetIcon: "docs",
                      onTap: () => js.context.callMethod('open',
                          ['https://spice.slite.page/p/l0emu5gAcQxsrO']),
                      iconSize: 19.0),
                  const SizedBox(width: 32.0),
                  BacklightCustomIcon(
                      assetIcon: "github",
                      onTap: () => js.context.callMethod(
                          'open', ['https://github.com/spice-solana']),
                      iconSize: 21.0),
                ],
              )
            ],
          ),
        );
  }
}
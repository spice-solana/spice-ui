import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:spice_ui/adapter/cubit/adapter_cubit.dart';
import 'package:spice_ui/adapter/cubit/adapter_states.dart';
import 'package:spice_ui/utils/extensions.dart';
import 'package:spice_ui/utils/links.dart';
import 'package:spice_ui/widgets/app_bar_menu_item.dart';
import 'package:spice_ui/widgets/custom_inkwell.dart';
import 'package:spice_ui/widgets/custom_vertical_divider.dart';


class TopWebBar extends StatefulWidget {
  final int state;
  const TopWebBar({super.key, required this.state});

  @override
  State<TopWebBar> createState() => _TopWebBarState();
}

class _TopWebBarState extends State<TopWebBar> {

  bool hideNotification = false;

  @override
  Widget build(BuildContext context) {
    final AdapterCubit adapterCubit = context.read<AdapterCubit>();
    return Column(
      children: [
        // hideNotification ? const SizedBox() : Container(
        //   height: 35.0,
        //   width: MediaQuery.of(context).size.width,
        //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
        //   alignment: Alignment.center,
        //   color: Colors.amber.shade200,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: [
        //       const SizedBox(),
        //       TextUnderline(text: "✅ Launched at Solana Devnet. Getting ready to launch on the main network", onTap: () => js.context.callMethod('open', ["https://info.spice.so/roadmap"])),
        //       CustomInkWell(
        //         onTap: () {
        //           setState(() {
        //             hideNotification = true;
        //           });
        //         },
        //         child: const Icon(Icons.clear, size: 16.0, color: Colors.black)),
        //     ],
        //   ),
        // ),

        Container(
          height: 50.0,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              border: Border(
                  bottom: BorderSide(
                      color: Theme.of(context).hintColor, width: 1.0))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/logos/spice_logo.svg',
                          height: 23.0, width: 23.0),
                      const SizedBox(width: 64.0),
                      AppBarMenuItem(
                          onTap: () => context.go('/swap'),
                          title: "Swap",
                          isActive: widget.state == 1
                              ? true
                              : false),
                      const SizedBox(width: 16.0),
                      const CustomVerticalDivider(height: 12.0),
                      const SizedBox(width: 16.0),
                      AppBarMenuItem(
                          onTap: () => context.go('/'),
                          title: "Liquidity",
                          isActive: widget.state == 2
                              ? true
                              : false),
                      const SizedBox(width: 16.0),
                      const CustomVerticalDivider(height: 12.0),
                      const SizedBox(width: 16.0),
                      AppBarMenuItem(
                          onTap: () => context.go('/portfolio'),
                          title: "Portfolio",
                          isActive: widget.state == 3
                              ? true
                              : false),
                    ],
                  ),
                ),
                BlocBuilder<AdapterCubit, AdapterStates>(
                    builder: (context, state) {
                  if (state is ConnectedAdapterState) {
                    return CustomInkWell(
                      onTap: () => adapterCubit.disconnect(),
                      child: Container(
                        height: 32.0,
                        width: 160.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(5.0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(state.address.toString().cutText(),
                                style: const TextStyle(
                                    color: Colors.redAccent, fontSize: 14.0)),
                            const SizedBox(width: 8.0),
                            const Icon(Icons.power_settings_new, size: 18.0, color: Colors.redAccent)
                          ],
                        ),
                      ),
                    );
                  }

                  if (state is UnconnectedAdapterState) {
                    return CustomInkWell(
                      onTap: () => adapterCubit.connect(),
                      child: Container(
                        height: 32.0,
                        width: 160.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.onPrimary,
                            borderRadius: BorderRadius.circular(5.0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text('Connect',
                                style: TextStyle(color: Colors.black)),
                            const SizedBox(width: 16.0),
                            SvgPicture.asset(walletLogo,
                                height: 16.0, width: 16.0),
                          ],
                        ),
                      ),
                    );
                  }

                  return const SizedBox();
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spice_ui/adapter/controller/adapter_cubit.dart';
import 'package:spice_ui/adapter/controller/adapter_states.dart';
import 'package:spice_ui/main/controller/main_cubit.dart';
import 'package:spice_ui/main/controller/main_states.dart';
import 'package:spice_ui/utils/extensions.dart';
import 'package:spice_ui/widgets/app_bar_menu_item.dart';
import 'package:spice_ui/widgets/custom_inkwell.dart';
import 'package:spice_ui/widgets/custom_vertical_divider.dart';
import 'package:spice_ui/widgets/text_underline.dart';

class TopBar extends StatefulWidget {
  const TopBar({super.key});

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {

  bool hideNotification = false;

  @override
  Widget build(BuildContext context) {
    final MainCubit mainCubit = context.read<MainCubit>();
    final AdapterCubit adapterCubit = context.read<AdapterCubit>();
    return Column(
      children: [

        hideNotification ? const SizedBox() : Container(
          height: 35.0,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          alignment: Alignment.center,
          color: Colors.amber.shade200,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(),
              TextUnderline(text: "🫡 Soon to be launched at Solana Devnet", onTap: () {}),
              CustomInkWell(
                onTap: () {
                  setState(() {
                    hideNotification = true;
                  });
                },
                child: const Icon(Icons.clear, size: 16.0, color: Colors.black)),
            ],
          ),
        ),

        Container(
          height: 50.0,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              border: Border(
                  bottom: BorderSide(
                      color: Colors.grey.withOpacity(0.2), width: 1.0))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/logos/spice_logo.svg',
                          height: 21.0, width: 21.0),
                      const SizedBox(width: 64.0),
                      AppBarMenuItem(
                          onTap: () {
                            setState(() {
                              context.read<MainCubit>().moveToSwapScreen();
                            });
                          },
                          title: "Swap",
                          isActive: mainCubit.state is SwapScreenState
                              ? true
                              : false),
                      const SizedBox(width: 16.0),
                      const CustomVerticalDivider(height: 12.0),
                      const SizedBox(width: 16.0),
                      AppBarMenuItem(
                          onTap: () => setState(() {
                                context.read<MainCubit>().moveToLiquidityScreen();
                              }),
                          title: "Liquidity",
                          isActive: mainCubit.state is LiquidityScreenState
                              ? true
                              : false),
                      const SizedBox(width: 16.0),
                      const CustomVerticalDivider(height: 12.0),
                      const SizedBox(width: 16.0),
                      AppBarMenuItem(
                          onTap: () => setState(() {
                                context.read<MainCubit>().moveToPortfolioScreen();
                              }),
                          title: "Portfolio",
                          isActive: mainCubit.state is PortfolioScreenState
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
                        child: Text(state.address.toString().cutText(),
                            style: const TextStyle(
                                color: Colors.redAccent, fontSize: 14.0)),
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
                            color: const Color(0xFF80EEFB),
                            borderRadius: BorderRadius.circular(5.0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text('Connect',
                                style: TextStyle(color: Colors.black)),
                            const SizedBox(width: 16.0),
                            SvgPicture.asset('assets/logos/phantom_logo.svg',
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

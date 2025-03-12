  import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spice_ui/adapter/cubit/adapter_cubit.dart';
import 'package:spice_ui/adapter/cubit/adapter_states.dart';
import 'package:spice_ui/portfolio/cubit/portfolio_cubit.dart';
import 'package:spice_ui/service/config.dart';
import 'package:spice_ui/models/pool.dart';
import 'package:spice_ui/service/spice_program.dart';
import 'package:spice_ui/theme/cubit/theme_cubit.dart';
import 'package:spice_ui/utils/extensions.dart';
import 'package:spice_ui/utils/links.dart';
import 'package:spice_ui/widgets/custom_inkwell.dart';
import 'package:spice_ui/widgets/text_underline.dart';
import 'package:url_launcher/url_launcher.dart';


void showActionDialog(BuildContext context, {required Pool pool, required String action, required String title, required Color actionColor, required String balance}) {
    Navigator.maybePop(context);
    final TextEditingController controllerAmount = TextEditingController();
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Dialog(
            child: Container(
              height: 500.0,
              width: 400.0,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                border: Border.all(
                  color: Colors.grey.withOpacity(0.2),
                  width: 1.0,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        pool.logoUrl,
                        width: 50,
                        height: 50,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.broken_image, size: 50),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        pool.symbol,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextUnderline(
                        text: pool.mint == SpiceProgram.solAddress ? "Native" : pool.mint.cutText(),
                        fontSize: 13.0,
                        color: Colors.grey,
                        onTap: () => launchUrl(Uri.parse(
                          "https://explorer.solana.com/address/${pool.mint}?cluster=${SolanaConfig.cluster}")),
                      )
                    ],
                  ),
                  const SizedBox(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      height: 100.0,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).hintColor,
                          width: 1.0,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Pool',
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.grey)),
                              const SizedBox(height: 8.0),
                              Container(
                                  height: 50.0,
                                  padding: const EdgeInsets.all(8.0),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(5.0)),
                                  child: Row(
                                    children: [
                                      Image.asset(pool.logoUrl,
                                          height: 25.0, width: 25.0),
                                      const SizedBox(width: 8.0),
                                      Text(pool.symbol),
                                      const SizedBox(width: 8.0),
                                    ],
                                  ))
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                      Icons.account_balance_wallet_outlined,
                                      size: 14.0,
                                      color: Colors.grey),
                                  const SizedBox(width: 8.0),
                                  Text('${balance.formatNumWithCommas()} ${pool.symbol}',
                                      style: const TextStyle(
                                          fontSize: 14.0, color: Colors.grey)),
                                ],
                              ),
                              const SizedBox(height: 8.0),
                              Container(
                                  height: 50.0,
                                  alignment: Alignment.center,
                                  constraints: const BoxConstraints(
                                      maxHeight: 50.0, maxWidth: 200.0),
                                  child: TextField(
                                    controller: controllerAmount,
                                    cursorColor: Theme.of(context).hintColor,
                                    cursorWidth: 1.0,
                                    decoration: InputDecoration(
                                      hintText: '0.00',
                                      hintStyle: TextStyle(
                                          fontSize: 21.0,
                                          color: Colors.grey.withOpacity(0.2)),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.zero,
                                    ),
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(fontSize: 21.0),
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal:
                                                true),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(RegExp(
                                          r'^\d*\.?\d*')),
                                    ],
                                  )),
                                  const SizedBox(height: 16.0),
                                  action == "add" ? Text("By providing liquidity, you'll earn a portion of trading fees") : SizedBox()
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  BlocBuilder<AdapterCubit, AdapterStates>(
                    builder: (context, state) {
                      if (state is ConnectedAdapterState) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0, right: 16.0, left: 16.0),
                          child: CustomInkWell(
                            onTap: () async {
                              Navigator.maybePop(context);
                              if (action == "add") {
                                await context.read<PortfolioCubit>().increaseLiquidity(adapter: context.read<AdapterCubit>(), pool: pool, amount: controllerAmount.text, isDark: context.read<ThemeCubit>().state.darkTheme);
                              } else if (action == "withdraw") {
                                await context.read<PortfolioCubit>().decreaseLiquidity(adapter: context.read<AdapterCubit>(), pool: pool, amount: controllerAmount.text, isDark: context.read<ThemeCubit>().state.darkTheme);
                              }
                            },
                            child: Container(
                              height: 45.0,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: actionColor,
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: Text(title,
                                  style: const TextStyle(color: Colors.black)),
                            ),
                          ),
                        );
                      }
          
                      if (state is UnconnectedAdapterState) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0, right: 16.0, left: 16.0),
                          child: CustomInkWell(
                            onTap: () => context.read<AdapterCubit>().connect(),
                            child: Container(
                              height: 45.0,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.secondary,
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text('Connect',
                                      style: TextStyle(color: Colors.black)),
                                  const SizedBox(width: 16.0),
                                  SvgPicture.asset(
                                      walletLogo,
                                      height: 16.0,
                                      width: 16.0),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
          
                      return const SizedBox();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:rive/rive.dart' as rive;
import 'package:spice_ui/data.dart';
import 'package:spice_ui/adapter/phantom_adapter.dart';
import 'package:spice_ui/theme/controller/tb_cubit.dart';
import 'package:spice_ui/theme/controller/theme_states.dart';
import 'package:spice_ui/transaction_bundle/theme_icons.dart';
import 'package:spice_ui/utils/extensions.dart';
import 'package:spice_ui/utils/toastification.dart';
import 'package:spice_ui/widgets/backlight_custom_icon.dart';
import 'package:spice_ui/widgets/backlight_icon.dart';
import 'package:spice_ui/widgets/custom_tb_menu.dart';
import 'package:spice_ui/widgets/custom_inkwell.dart';
import 'package:spice_ui/widgets/custom_vertical_divider.dart';
import 'package:spice_ui/widgets/pool_card_widget.dart';
import 'package:spice_ui/widgets/pool_table_widget.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? walletAddress;
  bool isTables = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              // Container(
              //   height: 35.0,
              //   width: MediaQuery.of(context).size.width,
              //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
              //   alignment: Alignment.center,
              //   color: Colors.greenAccent.shade200,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       const SizedBox(),
              //       TextUnderline(text: "Spice deployment on devnet in January", onTap: () {}),
              //       const Icon(Icons.clear, size: 16.0, color: Colors.grey),
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
                            color: Colors.grey.withOpacity(0.2), width: 1.0))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomInkWell(
                        onTap: () => html.window.location.reload(),
                        child: SizedBox(
                          width: 160.0,
                          child: Row(
                            children: [
                              SvgPicture.asset('assets/icons/spice_logo.svg',
                              height: 18.0, width: 18.0
                              ),
                              const SizedBox(width: 16.0),
                              const Text('SPICE'),
                              const SizedBox(width: 16.0),
                              const Text('devnet',
                                  style: TextStyle(
                                      fontSize: 12.0, color: Colors.amber))
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 32.0,
                        width: 440.0,
                        child: TextField(
                          // onTap: _openMenu,
                          textCapitalization: TextCapitalization.words,
                          cursorColor: Colors.grey.withOpacity(0.2),
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            fillColor: Colors.transparent,
                            hintText: "Search pool",
                            isDense: true,
                            hintStyle: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.normal,
                                color: Theme.of(context)
                                    .hintColor
                                    .withOpacity(0.5)),
                            filled: true,
                            suffixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(CupertinoIcons.command,
                                    size: 12.0,
                                    color: Colors.grey.withOpacity(0.8)),
                                const SizedBox(width: 4.0),
                                Text('k',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.grey.withOpacity(0.8)))
                              ],
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                    color: Colors.grey.withOpacity(0.2),
                                    width: 1.0)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                    color: Colors.grey.withOpacity(0.2),
                                    width: 1.0)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                    color: Colors.grey.withOpacity(0.2),
                                    width: 1.0)),
                          ),
                        ),
                      ),
                      walletAddress != null
                          ? CustomInkWell(
                              onTap: () async {
                                PhantomAdapter.disconnect();
                                walletAddress = null;
                                setState(() {});
                              },
                              child: Container(
                                height: 32.0,
                                width: 160.0,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(5.0)),
                                child: Text(walletAddress.toString().cutText(),
                                    style: const TextStyle(
                                        color: Colors.redAccent,
                                        fontSize: 14.0)),
                              ),
                            )
                          : CustomInkWell(
                              onTap: () async {
                                walletAddress = await PhantomAdapter.connect();
                                setState(() {});
                              },
                              child: Container(
                                height: 32.0,
                                width: 160.0,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: const Color(0xFF80EEFB),
                                    borderRadius: BorderRadius.circular(5.0)),
                                child: const Text('CONNECT',
                                    style: TextStyle(color: Colors.black)),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 420.0,
                    width: MediaQuery.of(context).size.width / 1.7,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                          Colors.grey.withOpacity(0.05),
                          Colors.transparent
                        ])),
                  ),
                  const Text('Single-sided liquidity protocol',
                      textAlign: TextAlign.center,
                      style: TextStyle(letterSpacing: -2.0, fontSize: 38.0)),
                  const SizedBox(height: 32.0),
                  Text('EASE OF USE ⋅ NO INPERMANENT LOSS ⋅ HIGH YIELD',
                      style: TextStyle(
                          color: Colors.grey.withOpacity(0.5), fontSize: 14.0)),
                  const SizedBox(height: 32.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('Cards'),
                      const SizedBox(width: 16.0),
                      SizedBox(
                          height: 30.0,
                          width: 47.0,
                          child: FittedBox(
                              fit: BoxFit.fill,
                              child: CupertinoSwitch(
                                  value: isTables,
                                  onChanged: (value) {
                                    isTables = value;
                                    setState(() {});
                                  },
                                  trackColor: const Color(0xFF80EEFB),
                                  activeColor: const Color(0xFF80EEFB)))),
                      const SizedBox(width: 16.0),
                      const Text('Tables'),
                    ],
                  ),
                  const SizedBox(height: 32.0),
                  isTables
                      ? Column(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 1.7,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                      width: 100.0,
                                      alignment: Alignment.centerLeft,
                                      child: Text('Pools',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.grey
                                                  .withOpacity(0.5)))),
                                  Container(
                                      width: 180.0,
                                      alignment: Alignment.center,
                                      child: Text('Total liquidity',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.grey
                                                  .withOpacity(0.5)))),
                                  Container(
                                      width: 180.0,
                                      alignment: Alignment.center,
                                      child: Text('Volume (24)',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.grey
                                                  .withOpacity(0.5)))),
                                  Container(
                                      width: 180.0,
                                      alignment: Alignment.center,
                                      child: Text('Fee (24)',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.grey
                                                  .withOpacity(0.5)))),
                                  Container(
                                      width: 100.0,
                                      alignment: Alignment.centerRight,
                                      child: Text('APY',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.grey
                                                  .withOpacity(0.5)))),
                                ],
                              ),
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width / 1.7,
                                child: Divider(
                                    color: Colors.grey.withOpacity(0.2),
                                    thickness: 1.0)),
                            SizedBox(
                              height: poolsData.length * 57.0,
                              width: MediaQuery.of(context).size.width / 1.7,
                              child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: poolsData.length,
                                  itemBuilder: (context, index) {
                                    return PoolTableWidget(
                                        onTap: () => Toastification.soon(
                                            context,
                                            'Liquidity pool is not active'),
                                        poolName: poolsData[index]['pool_name'],
                                        poolLogo: poolsData[index]['pool_logo'],
                                        totalLiquidity: poolsData[index]
                                            ['pool_liquidity'],
                                        volume24: poolsData[index]
                                            ['pool_volume_24'],
                                        fee24: poolsData[index]['pool_fee_24'],
                                        apy: poolsData[index]['pool_apy']);
                                  }),
                            ),
                          ],
                        )
                      : SizedBox(
                          width: MediaQuery.of(context).size.width / 1.7,
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 16.0,
                            runSpacing: 16.0,
                            children: poolsData.map((pool) {
                              return SizedBox(
                                width: (MediaQuery.of(context).size.width / 1.7 -32) / 3, 
                                child: PoolCardWidget(
                                  onTap: () => Toastification.soon(
                                      context, 'Liquidity pool is not active'),
                                  pool: pool,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                  const SizedBox(height: 32.0),
                ],
              ),
            ),
          ),
          Container(
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
                              shape: BoxShape.circle, color: Colors.redAccent),
                        ),
                        const SizedBox(width: 16.0),
                        const Text('Off', style: TextStyle(fontSize: 14.0))
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
                    BacklightCustomIcon(assetIcon: "x", onTap: () => js.context.callMethod(
                            'open', ['https://x.com/spice_protocol']), iconSize: 17.0),
                    const SizedBox(width: 32.0),
                    BacklightCustomIcon(assetIcon: "telegram", onTap: () => js.context.callMethod(
                            'open', ['https://t.me/spicelp']), iconSize: 17.0),
                    const SizedBox(width: 32.0),
                    BacklightCustomIcon(assetIcon: "docs", onTap: () => js.context.callMethod(
                            'open', ['https://spice.slite.page/p/l0emu5gAcQxsrO']), iconSize: 19.0),
                    const SizedBox(width: 32.0),
                    BacklightCustomIcon(assetIcon: "github", onTap: () => js.context.callMethod(
                            'open', ['https://github.com/spice-protocol']), iconSize: 21.0),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

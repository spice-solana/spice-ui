import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart' as rive;
import 'package:spice_ui/data.dart';
import 'package:spice_ui/phantom_adapter.dart';
import 'package:spice_ui/theme/controller/tb_cubit.dart';
import 'package:spice_ui/theme/controller/theme_states.dart';
import 'package:spice_ui/transaction_bundle/theme_icons.dart';
import 'package:spice_ui/utils/extensions.dart';
import 'package:spice_ui/widgets/backlight_icon.dart';
import 'package:spice_ui/widgets/backlight_text.dart';
import 'package:spice_ui/widgets/custom_tb_menu.dart';
import 'package:spice_ui/widgets/custom_inkwell.dart';
import 'package:spice_ui/widgets/custom_vertical_divider.dart';
import 'package:spice_ui/widgets/pool_table_widget.dart';
import 'package:spice_ui/widgets/pools_grid.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var walletAddress;
  bool isTables = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 50.0,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Colors.grey.withOpacity(0.2), width: 1.0))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset('assets/icons/spice_logo.png',
                          height: 21.0, width: 21.0),
                      const SizedBox(width: 16.0),
                      const Text('Spice'),
                      const SizedBox(width: 16.0),
                      const Text('devnet',
                          style: TextStyle(fontSize: 12.0, color: Colors.amber))
                    ],
                  ),
                  SizedBox(
                    height: 36.0,
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
                            color:
                                Theme.of(context).hintColor.withOpacity(0.5)),
                        filled: true,
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset('assets/icons/command_icon.png',
                                height: 12.0, width: 12.0),
                            const SizedBox(width: 4.0),
                            const Text('k',
                                style: TextStyle(
                                    fontSize: 14.0, color: Color(0xFF545454)))
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
                            walletAddress = await PhantomAdapter.disconnect();
                            setState(() {});
                          },
                          child: Container(
                            height: 36.0,
                            width: 180.0,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(5.0)),
                            child: Text(walletAddress.toString().cutText(),
                                style:
                                    const TextStyle(color: Colors.redAccent)),
                          ),
                        )
                      : CustomInkWell(
                          onTap: () async {
                            walletAddress = await PhantomAdapter.connect();
                            setState(() {});
                          },
                          child: Container(
                            height: 36.0,
                            width: 180.0,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: const Color(0xFF80EEFB),
                                borderRadius: BorderRadius.circular(5.0)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset('assets/icons/phantom_logo.png',
                                    height: 18.0, width: 18.0),
                                const SizedBox(width: 16.0),
                                const Text('Connect',
                                    style: TextStyle(color: Colors.black)),
                              ],
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 320.0,
                    width: MediaQuery.of(context).size.width / 1.7,
                    child: const rive.RiveAnimation.asset(
                      'assets/rive/spice.riv',
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    ),
                  ),
                  const Text('Unilateral liquidity',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          letterSpacing: -2.0,
                          wordSpacing: -10.0,
                          fontSize: 60.0)),
                  const Text('protocol',
                      textAlign: TextAlign.center,
                      style: TextStyle(letterSpacing: -2.0, fontSize: 60.0)),
                  const SizedBox(height: 16.0),
                  Text('FAST DATA ⋅ DEEPEST LIQIDITY ⋅ HIGH INCOME',
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
                                              color: Colors.grey
                                                  .withOpacity(0.5)))),
                                  Container(
                                      width: 180.0,
                                      alignment: Alignment.center,
                                      child: Text('Total liquidity',
                                          style: TextStyle(
                                              color: Colors.grey
                                                  .withOpacity(0.5)))),
                                  Container(
                                      width: 180.0,
                                      alignment: Alignment.center,
                                      child: Text('Volume (24)',
                                          style: TextStyle(
                                              color: Colors.grey
                                                  .withOpacity(0.5)))),
                                  Container(
                                      width: 180.0,
                                      alignment: Alignment.center,
                                      child: Text('Fee (24)',
                                          style: TextStyle(
                                              color: Colors.grey
                                                  .withOpacity(0.5)))),
                                  Container(
                                      width: 100.0,
                                      alignment: Alignment.centerRight,
                                      child: Text('APY',
                                          style: TextStyle(
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
                          height: 145.0 * poolsData.length,
                          width: MediaQuery.of(context).size.width / 1.7,
                          child: const PoolsGrid(poolsData: poolsData)),
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
                            shape: BoxShape.circle,
                            color: Colors.redAccent
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        const Text('Off')
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
                    BacklightText(text: 'X', onTap: () => js.context.callMethod('open', ['https://x.com/spice_protocol'])),
                    const SizedBox(width: 32.0),
                    BacklightText(text: 'Github', onTap: () => js.context.callMethod('open', ['https://github.com/spice-solana'])),
                    const SizedBox(width: 32.0),
                    const CustomVerticalDivider(height: 36.0),
                    const SizedBox(width: 32.0),
                    const Text('Daily Volume 0', style: TextStyle(fontSize: 14.0)),
                    const SizedBox(width: 16.0),
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

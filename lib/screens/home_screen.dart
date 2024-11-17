import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spice_ui/data.dart';
import 'package:spice_ui/phantom_adapter.dart';
import 'package:spice_ui/theme/controller/theme_cubit.dart';
import 'package:spice_ui/theme/controller/theme_states.dart';
import 'package:spice_ui/theme/theme_icons.dart';
import 'package:spice_ui/utils/extensions.dart';
import 'package:spice_ui/widgets/backlight_icon.dart';
import 'package:spice_ui/widgets/backlight_icon_text.dart';
import 'package:spice_ui/widgets/custom_drop_menu.dart';
import 'package:spice_ui/widgets/custom_inkwell.dart';
import 'package:spice_ui/widgets/custom_vertical_divider.dart';
import 'package:spice_ui/widgets/pool_table_widget.dart';
import 'package:spice_ui/widgets/blinking_live_indicator.dart';
import 'package:spice_ui/widgets/pools_grid.dart';
import 'package:spice_ui/widgets/sand_effect.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var walletAddress;
  bool isTables = true;

  final GlobalKey _buttonKey = GlobalKey();
  OverlayEntry? _overlayEntry;

  void _toggleMenu() {
    if (_overlayEntry != null) {
      _closeMenu();
    } else {
      _openMenu();
    }
  }

    void _openMenu() {
    RenderBox buttonBox = _buttonKey.currentContext!.findRenderObject() as RenderBox;
    Offset buttonPosition = buttonBox.localToGlobal(Offset.zero);
    Size buttonSize = buttonBox.size;

    Size screenSize = MediaQuery.of(context).size;

    bool openDown = buttonPosition.dy + buttonSize.height + 64.0 + 150.0 < screenSize.height;

    _overlayEntry = OverlayEntry(
      builder: (context) => CustomDropdownMenu(position: buttonPosition, openDown: openDown, onClose: _closeMenu),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _closeMenu() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

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
                  CustomInkWell(
                    onTap: () async {
                      walletAddress = await PhantomAdapter.connect();
                      setState(() {});
                    },
                    child: Container(
                      height: 36.0,
                      width: 180.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: walletAddress != null
                              ? Colors.transparent
                              : const Color(0xFF80EEFB),
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Text(
                          walletAddress != null
                              ? walletAddress.toString().cutText()
                              : 'Connect',
                          style: TextStyle(
                              color: walletAddress != null
                                  ? Colors.red.shade300
                                  : Colors.black)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Image.asset('assets/images/spice_banner.png',
                          width: MediaQuery.of(context).size.width / 1.7),
                      SandEffect(
                          width: MediaQuery.of(context).size.width / 1.7,
                          height: 100.0),
                    ],
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
                  isTables ? Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.7,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                width: 100.0,
                                alignment: Alignment.centerLeft,
                                child: Text('Pools',
                                    style: TextStyle(
                                        color: Colors.grey.withOpacity(0.5)))),
                            Container(
                                width: 180.0,
                                alignment: Alignment.center,
                                child: Text('Total liquidity',
                                    style: TextStyle(
                                        color: Colors.grey.withOpacity(0.5)))),
                            Container(
                                width: 180.0,
                                alignment: Alignment.center,
                                child: Text('Volume (24)',
                                    style: TextStyle(
                                        color: Colors.grey.withOpacity(0.5)))),
                            Container(
                                width: 180.0,
                                alignment: Alignment.center,
                                child: Text('Fee (24)',
                                    style: TextStyle(
                                        color: Colors.grey.withOpacity(0.5)))),
                            Container(
                                width: 100.0,
                                alignment: Alignment.centerRight,
                                child: Text('APY',
                                    style: TextStyle(
                                        color: Colors.grey.withOpacity(0.5)))),
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
                                  volume24: poolsData[index]['pool_volume_24'],
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
                    const BlinkingLiveIndicator(),
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
                    BacklightIcon(
                        iconData: Icons.settings,
                        iconSize: 20.0,
                        onTap: () => null),
                    const SizedBox(width: 32.0),
                    const CustomVerticalDivider(height: 36.0),
                    const SizedBox(width: 32.0),
                    BacklightIconText(
                        key: _buttonKey,
                        text: 'Normal',
                        iconData: Icons.speed,
                        iconSize: 21.0,
                        onTap: _toggleMenu)
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomVerticalDivider(height: 36.0),
                    SizedBox(width: 32.0),
                    Text('Daily Volume 134 M',
                        style: TextStyle(fontSize: 14.0)),
                    SizedBox(width: 16.0),
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

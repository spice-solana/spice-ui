import 'package:contextmenu/contextmenu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spice_ui/data.dart';
import 'package:spice_ui/phantom_adapter.dart';
import 'package:spice_ui/utils/extensions.dart';
import 'package:spice_ui/widgets/custom_inkwell.dart';
import 'package:spice_ui/widgets/custom_vertical_divider.dart';
import 'package:spice_ui/widgets/pool_table_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var walletAddress;

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
                  // Container(
                  //   height: 36.0,
                  //   width: 440.0,
                  //   alignment: Alignment.centerLeft,
                  //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  //   decoration: BoxDecoration(
                  //       border: Border.all(color: Colors.grey.withOpacity(0.2), width: 1.0),
                  //       borderRadius: BorderRadius.circular(5.0)
                  // ),
                  // child: Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: [
                  //     const Text('Search pool', style: TextStyle(color: Color(0xFF545454))),
                  //     Row(
                  //       children: [
                  //         Image.asset('assets/icons/command_icon.png', height: 12.0, width: 12.0),
                  //         const SizedBox(width: 4.0),
                  //         const Text('k', style: TextStyle(fontSize: 14.0, color: Color(0xFF545454)))
                  //       ],
                  //     ),
                  //   ],
                  // )),
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
                  Image.asset('assets/images/spice_banner.png',
                      width: MediaQuery.of(context).size.width / 1.7),
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
                                  value: true,
                                  onChanged: (value) => null,
                                  activeColor: const Color(0xFF80EEFB)))),
                      const SizedBox(width: 16.0),
                      const Text('Tables'),
                    ],
                  ),
                  const SizedBox(height: 32.0),
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
                          color: Colors.grey.withOpacity(0.2), thickness: 1.0)),
                  SizedBox(
                    height: poolsData.length * 55.0,
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
                border: Border(
                    top: BorderSide(
                        color: Colors.grey.withOpacity(0.2), width: 1.0))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      height: 8.0,
                      width: 8.0,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.greenAccent),
                    ),
                    const SizedBox(width: 16.0),
                    const Text('Live', style: TextStyle(fontSize: 14.0)),
                    const SizedBox(width: 32.0),
                    const CustomVerticalDivider(height: 36.0),
                    const SizedBox(width: 32.0),
                    Image.asset('assets/icons/sun_icon.png',
                        height: 22.0, width: 22.0),
                    const SizedBox(width: 32.0),
                    Image.asset('assets/icons/settings_icon.png',
                        height: 22.0, width: 22.0),
                    const SizedBox(width: 32.0),
                    const CustomVerticalDivider(height: 36.0),
                    const SizedBox(width: 32.0),
                    Image.asset('assets/icons/speed_icon.png',
                        height: 22.0, width: 22.0),
                    const SizedBox(width: 16.0),
                    const Text('Normal',
                        style: TextStyle(fontSize: 14.0)),
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

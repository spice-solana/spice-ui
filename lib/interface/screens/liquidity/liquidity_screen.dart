import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spice_ui/adapter/controller/adapter_cubit.dart';
import 'package:spice_ui/adapter/controller/adapter_states.dart';
// import 'package:rive/rive.dart' as rive;
import 'package:spice_ui/data/pools.dart';
import 'package:spice_ui/main/config.dart';
import 'package:spice_ui/main/controller/main_cubit.dart';
import 'package:spice_ui/models/pool.dart';
import 'package:spice_ui/utils/extensions.dart';
import 'package:spice_ui/widgets/custom_inkwell.dart';
import 'package:spice_ui/widgets/pool_card_widget.dart';
import 'package:spice_ui/widgets/pool_table_widget.dart';
import 'package:spice_ui/widgets/text_underline.dart';
import 'package:url_launcher/url_launcher.dart';

class LiquidityScreen extends StatefulWidget {
  const LiquidityScreen({super.key});

  @override
  State<LiquidityScreen> createState() => _LiquidityScreen();
}

class _LiquidityScreen extends State<LiquidityScreen> {
  final TextEditingController _controllerAmount = TextEditingController();

  bool isTables = false;

  @override
  Widget build(BuildContext context) {
    final MainCubit mainCubit = context.read<MainCubit>();
    return Expanded(
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 32.0),
            SizedBox(
              height: 32.0,
              width: 500.0,
              child: TextField(
                // onTap: _openMenu,
                textCapitalization: TextCapitalization.words,
                cursorColor: Colors.grey.withOpacity(0.2),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                  fillColor: Colors.transparent,
                  hintText: "Search crypto",
                  isDense: true,
                  hintStyle: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.normal,
                      color: Theme.of(context).hintColor.withOpacity(0.5)),
                  filled: true,
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(CupertinoIcons.command,
                          size: 12.0, color: Colors.grey.withOpacity(0.8)),
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
                          color: Colors.grey.withOpacity(0.2), width: 1.0)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                          color: Colors.grey.withOpacity(0.2), width: 1.0)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                          color: Colors.grey.withOpacity(0.2), width: 1.0)),
                ),
              ),
            ),
            const SizedBox(height: 32.0),
            const Text('Make your crypto work for you',
                textAlign: TextAlign.center,
                style: TextStyle(letterSpacing: -2.0, fontSize: 34.0)),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                width: 100.0,
                                alignment: Alignment.centerLeft,
                                child: Text('Pools',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.grey.withOpacity(0.5)))),
                            Container(
                                width: 180.0,
                                alignment: Alignment.center,
                                child: Text('Total liquidity',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.grey.withOpacity(0.5)))),
                            Container(
                                width: 180.0,
                                alignment: Alignment.center,
                                child: Text('Volume (24)',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.grey.withOpacity(0.5)))),
                            Container(
                                width: 180.0,
                                alignment: Alignment.center,
                                child: Text('Fee (24)',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.grey.withOpacity(0.5)))),
                            Container(
                                width: 100.0,
                                alignment: Alignment.centerRight,
                                child: Text('APY',
                                    style: TextStyle(
                                        fontSize: 14.0,
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
                                  onTap: () => _showDialog(context, mainCubit, pool: poolsData[index]),
                                  poolName: poolsData[index].symbol,
                                  poolLogo: poolsData[index].logoUrl,
                                  totalLiquidity: "0",
                                  volume24: "0",
                                  fee24: "0",
                                  apy: "0");
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
                      children: poolsData.map(
                        (pool) {
                          return SizedBox(
                            width:
                                (MediaQuery.of(context).size.width / 1.7 - 32) /
                                    3,
                            child: PoolCardWidget(
                              onTap: () => _showDialog(context, mainCubit, pool: pool),
                              pool: pool,
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
            const SizedBox(height: 32.0),
          ],
        ),
      ),
    );
  }

  void _showDialog(BuildContext context, MainCubit mainCubit, {required Pool pool}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          // shape: RoundedRectangleBorder(
          // borderRadius: BorderRadius.circular(16.0), // Радиус углов окна
          // ),
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
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100.0),
                      child: Image.network(
                        pool.logoUrl,
                        width: 50,
                        height: 50,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.broken_image, size: 50),
                      ),
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
                      text: pool.mint.cutText(),
                      fontSize: 13.0,
                      color: Theme.of(context).hintColor,
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
                        color: Colors.grey.withOpacity(0.2),
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
                            CustomInkWell(
                              onTap: () => null,
                              child: Container(
                                  height: 50.0,
                                  padding: const EdgeInsets.all(8.0),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(5.0)),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100.0),
                                        child: Image.network(pool.logoUrl,
                                            height: 25.0, width: 25.0),
                                      ),
                                      const SizedBox(width: 8.0),
                                      Text(pool.symbol),
                                      const SizedBox(width: 8.0),
                                    ],
                                  )),
                            )
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
                                Text('0 ${pool.symbol}',
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
                                  controller: _controllerAmount,
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
                                              true), // Поддержка чисел с точкой
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp(
                                        r'^\d*\.?\d*')), // Только числа и точка
                                  ],
                                ))
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
                          onTap: () => mainCubit.increaseLiquidity(context, pool: pool, amount: _controllerAmount.text),
                          child: Container(
                            height: 45.0,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: const Color(0xFFA1F6CA),
                                borderRadius: BorderRadius.circular(5.0)),
                            child: const Text('+ Add',
                                style: TextStyle(color: Colors.black)),
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
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(5.0)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text('Connect',
                                    style: TextStyle(color: Colors.black)),
                                const SizedBox(width: 16.0),
                                SvgPicture.asset(
                                    'assets/logos/phantom_logo.svg',
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
        );
      },
    );
  }
}

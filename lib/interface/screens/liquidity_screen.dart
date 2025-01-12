import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:rive/rive.dart' as rive;
import 'package:spice_ui/data/pools.dart';
import 'package:spice_ui/utils/toastification.dart';
import 'package:spice_ui/widgets/pool_card_widget.dart';
import 'package:spice_ui/widgets/pool_table_widget.dart';

class LiquidityScreen extends StatefulWidget {
  const LiquidityScreen({super.key});

  @override
  State<LiquidityScreen> createState() => _LiquidityScreen();
}

class _LiquidityScreen extends State<LiquidityScreen> {
  bool isTables = false;

  @override
  Widget build(BuildContext context) {
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
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            fillColor: Colors.transparent,
                            hintText: "Search crypto",
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
                                        color:
                                            Colors.grey.withOpacity(0.5)))),
                            Container(
                                width: 180.0,
                                alignment: Alignment.center,
                                child: Text('Total liquidity',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        color:
                                            Colors.grey.withOpacity(0.5)))),
                            Container(
                                width: 180.0,
                                alignment: Alignment.center,
                                child: Text('Volume (24)',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        color:
                                            Colors.grey.withOpacity(0.5)))),
                            Container(
                                width: 180.0,
                                alignment: Alignment.center,
                                child: Text('Fee (24)',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        color:
                                            Colors.grey.withOpacity(0.5)))),
                            Container(
                                width: 100.0,
                                alignment: Alignment.centerRight,
                                child: Text('APY',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        color:
                                            Colors.grey.withOpacity(0.5)))),
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
                                  onTap: () => Toastification.soon(context,
                                      'Liquidity pool is not active'),
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
                      children: poolsData.map((pool) {
                        return SizedBox(
                          width: (MediaQuery.of(context).size.width / 1.7 -
                                  32) /
                              3,
                          child: PoolCardWidget(
                            onTap: () => Toastification.soon(
                                context, 'Liquidity pool is not active'),
                            pool: pool,
                          ),
                        );
                      },).toList(),
                    ),
                  ),
            const SizedBox(height: 32.0),
          ],
        ),
      ),
    );
  }
}

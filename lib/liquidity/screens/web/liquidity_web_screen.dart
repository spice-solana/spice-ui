import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spice_ui/bars/bottom_web_bar.dart';
// import 'package:rive/rive.dart' as rive;
import 'package:spice_ui/bars/top_web_bar.dart';
import 'package:spice_ui/dialogs/action_dialog.dart';
import 'package:spice_ui/liquidity/cubit/liquidity_cubit.dart';
import 'package:spice_ui/liquidity/cubit/liquidity_states.dart';
import 'package:spice_ui/widgets/pool_card_widget.dart';
import 'package:spice_ui/widgets/pool_table_widget.dart';
import 'package:spice_ui/widgets/search_widget.dart';

class LiquidityWebScreen extends StatefulWidget {
  const LiquidityWebScreen({super.key});

  @override
  State<LiquidityWebScreen> createState() => _LiquidityWebScreen();
}

class _LiquidityWebScreen extends State<LiquidityWebScreen> {

  bool isTables = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const TopWebBar(state: 2),
          BlocBuilder<LiquidityCubit, HomeLiquidityScreenState>(
            builder: (context, state) {
              return Expanded(
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 32.0),
                      const SearchWidget(),
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
                                      inactiveTrackColor: Theme.of(context).colorScheme.onPrimary,
                                      activeTrackColor: Theme.of(context).colorScheme.onPrimary))),
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
                                  height: state.pools.length * 57.0,
                                  width: MediaQuery.of(context).size.width / 1.7,
                                  child: ListView.builder(
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: state.pools.length,
                                      itemBuilder: (context, index) {
                                        return PoolTableWidget(
                                            onTap: () => showActionDialog(context, pool: state.pools[index], action: "add", title: "+ Add", actionColor: const Color(0xFFA1F6CA), balance: '0'),
                                            poolName: state.pools[index].symbol,
                                            poolLogo: state.pools[index].logoUrl,
                                            totalLiquidity: state.pools[index].liquidity!,
                                            volume24: state.pools[index].volume!,
                                            fee24: state.pools[index].fees!,
                                            apy: state.pools[index].apy!);
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
                                children: state.pools.map(
                                  (pool) {
                                    return SizedBox(
                                      width:
                                          (MediaQuery.of(context).size.width / 1.7 - 32) /
                                              3,
                                      child: PoolCardWidget(
                                        onTap: () => showActionDialog(context, pool: pool, action: "add", title: "+ Add liquidity", actionColor: const Color(0xFFA1F6CA), balance: '0'),
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
          ),
          const BottomWebBar()
        ],
      ),
    );
  }
}

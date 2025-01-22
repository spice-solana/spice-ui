import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spice_ui/adapter/controller/adapter_cubit.dart';
import 'package:spice_ui/interface/dialogs/action_dialog.dart';
import 'package:spice_ui/main/controller/main_cubit.dart';
import 'package:spice_ui/models/portfolio.dart';
import 'package:spice_ui/widgets/backlight_text.dart';

class PositionWidget extends StatelessWidget {
  final Position position;
  const PositionWidget({super.key, required this.position});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        height: 90.0,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        color: Colors.grey.withOpacity(0.05),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              width: 100.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(100.0),
                      child: Image.network(
                          position.pool.logoUrl,
                          height: 25.0,
                          width: 25.0)),
                  const SizedBox(width: 8.0),
                  Text(position.pool.symbol),
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              width: 200.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Liquidity",
                      style: TextStyle(
                          color: Theme.of(context).hintColor.withOpacity(0.5))),
                  const SizedBox(height: 4.0),
                  Text(position.liquidity),
                  const SizedBox(height: 4.0),
                  Text("\$${position.liquidityInUsd}",
                      style: TextStyle(
                          fontFamily: '',
                          fontSize: 12.0,
                          color: Theme.of(context).hintColor.withOpacity(0.5)))
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              width: 150.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Earned",
                      style: TextStyle(
                          color: Theme.of(context).hintColor.withOpacity(0.5))),
                  const SizedBox(height: 4.0),
                  Text(position.earned),
                  const SizedBox(height: 4.0),
                  Text("\$${position.earnedInUsd}",
                      style: TextStyle(
                          fontFamily: '',
                          fontSize: 12.0,
                          color: Theme.of(context).hintColor.withOpacity(0.5)))
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () => showActionDialog(context,
                        pool: position.pool,
                        action: "withdraw",
                        title: "- Withdraw liquidity",
                        actionColor: Colors.redAccent, balance: position.liquidity),
                    icon: const Icon(Icons.remove, color: Colors.redAccent)),
                const SizedBox(width: 32.0),
                IconButton(
                    onPressed: () => showActionDialog(context,
                        pool: position.pool,
                        action: "add",
                        title: "+ Add liquidity",
                        actionColor: const Color(0xFFA1F6CA), balance: '0'),
                    icon: const Icon(Icons.add, color: Colors.greenAccent)),
                const SizedBox(width: 36.0),
                BacklightText(
                    text: "Claim",
                    onTap: () => context.read<MainCubit>().claimIncome(context, adapter: context.read<AdapterCubit>(), pool: position.pool),
                    color: Colors.amber),
              ],
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spice_ui/models/pool.dart';
import 'package:spice_ui/swap/cubit/swap_cubit.dart';
import 'package:spice_ui/utils/extensions.dart';


class ChooseTokenMobScreen extends StatelessWidget {
  final String side;
  final List<Pool> pools;
  const ChooseTokenMobScreen({super.key, required this.side, required this.pools});

  @override
  Widget build(BuildContext context) {
    final SwapCubit swapCubit = context.read<SwapCubit>();
    return SizedBox(
      height: 500.0,
      width: 400.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              IconButton(onPressed: () => swapCubit.moveToSwapScreen(), icon: Icon(Icons.arrow_back, size: 21.0, color: Theme.of(context).iconTheme.color)),
              const SizedBox(width: 16.0),
              Text('Your $side',
                        style:
                            const TextStyle(fontSize: 14.0, color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 16.0),
          Expanded(
            child: ListView.builder(
              itemCount: pools.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: ListTile(
                    onTap: () => swapCubit.chooseToken(side: side, pool: pools[index]),
                    leading: Image.asset(
                      pools[index].logoUrl,
                      height: 25.0,
                      width: 25.0,
                    ),
                    title: Text(pools[index].symbol),
                    subtitle: pools[index].mint != "So11111111111111111111111111111111111111112" ? Text(pools[index].mint.cutText(), style: const TextStyle(fontSize: 12.0, color: Colors.grey)) : null,
                  ),
                );
          })),
        ],
      ),
    );
  }
}
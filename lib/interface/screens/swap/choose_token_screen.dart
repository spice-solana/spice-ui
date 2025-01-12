import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spice_ui/main/controller/main_cubit.dart';
import 'package:spice_ui/models/pool.dart';
import 'package:spice_ui/utils/extensions.dart';


class ChooseTokenScreen extends StatelessWidget {
  final String side;
  final List<Pool> pools;
  const ChooseTokenScreen({super.key, required this.side, required this.pools});

  @override
  Widget build(BuildContext context) {
    final MainCubit mainCubit = context.read<MainCubit>();
    return Container(
      height: 500.0,
      width: 400.0,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border.all(
          color: Colors.grey.withOpacity(0.2),
          width: 1.0,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              IconButton(onPressed: () => mainCubit.moveToSwapScreen(), icon: Icon(Icons.arrow_back, size: 21.0, color: Theme.of(context).iconTheme.color)),
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
                    onTap: () => mainCubit.chooseToken(side: side, pool: pools[index]),
                    leading: ClipRRect(
                            borderRadius: BorderRadius.circular(100.0),
                            child: Image.network(
                              pools[index].logoUrl,
                              height: 25.0,
                              width: 25.0,
                            )),
                    title: Text(pools[index].symbol),
                    subtitle: pools[index].mint != "So11111111111111111111111111111111111111112" ? Text(pools[index].mint.cutText(), style: TextStyle(fontSize: 12.0, color: Theme.of(context).hintColor)) : null,
                  ),
                );
          })),
        ],
      ),
    );
  }
}
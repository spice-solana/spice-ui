import 'package:flutter/material.dart';

class PoolCardWidget extends StatelessWidget {
  final Function() onTap;
  final Map pool;
  const PoolCardWidget({super.key, required this.onTap, required this.pool});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Container(
        height: 450.0,
        width: 100.0,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.withOpacity(0.2))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100.0),
              child: Image.network(
                pool["pool_logo"]!,
                width: 50,
                height: 50,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.broken_image, size: 50),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              pool["pool_name"]!,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text.rich(TextSpan(children: [
              TextSpan(
                  text: 'Liquidity: ',
                  style: TextStyle(color: Theme.of(context).hintColor)),
              TextSpan(text: pool["pool_liquidity"]),
            ])),
            Text.rich(TextSpan(children: [
              TextSpan(
                  text: 'Volume (24h): ',
                  style: TextStyle(color: Theme.of(context).hintColor)),
              TextSpan(text: pool["pool_volume_24"]),
            ])),
            Text.rich(TextSpan(children: [
              TextSpan(
                  text: 'Fees (24h): ',
                  style: TextStyle(color: Theme.of(context).hintColor)),
              TextSpan(text: pool["pool_fee_24"]),
            ])),
            const SizedBox(height: 16),
            Text(
              "APY: ${pool["pool_apy"]}",
              style: const TextStyle(
                color: Colors.greenAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:spice_ui/models/pool.dart';

class PoolCardWidget extends StatefulWidget {
  final Function() onTap;
  final Pool pool;
  const PoolCardWidget({super.key, required this.onTap, required this.pool});

  @override
  State<PoolCardWidget> createState() => _PoolCardWidgetState();
}

class _PoolCardWidgetState extends State<PoolCardWidget> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      onHover: (value) {
        isHover = value;
        setState(() {});
      },
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Container(
        height: 450.0,
        width: 100.0,
        decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).hintColor)),
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
                    widget.pool.logoUrl,
                    width: 50,
                    height: 50,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.broken_image, size: 50),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  widget.pool.symbol,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                const Text.rich(TextSpan(children: [
                  TextSpan(
                      text: 'Liquidity: ',
                      style: TextStyle(color: Colors.grey)),
                  TextSpan(text: "0"),
                ])),
                const SizedBox(height: 4),
                const Text.rich(TextSpan(children: [
                  TextSpan(
                      text: 'Volume (24h): ',
                      style: TextStyle(color: Colors.grey)),
                  TextSpan(text: "0"),
                ])),
                const SizedBox(height: 4),
                const Text.rich(TextSpan(children: [
                  TextSpan(
                      text: 'Fees (24h): ',
                      style: TextStyle(color: Colors.grey)),
                  TextSpan(text: "0"),
                ])),
                const SizedBox(height: 16),
                const Text(
                  "APY: ${0}",
                  style: TextStyle(
                    color: Colors.greenAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            isHover ? Container(
              height: 45.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Theme.of(context).hintColor))
              ),
              child: const Text("+ Add liquidity", style: TextStyle(fontSize: 14.0, color: Colors.grey)),
            ) : const SizedBox(height: 45.0)
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:spice_ui/models/pool.dart';
import 'package:spice_ui/widgets/custom_inkwell.dart';

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
    return CustomInkWell(
      onTap: widget.onTap,
      onHover: (value) {
        isHover = value;
        setState(() {});
      },
      child: AnimatedContainer(
        height: 450.0,
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
            color: isHover ? Theme.of(context).hoverColor : Colors.transparent,
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
                Image.asset(
                  widget.pool.logoUrl,
                  width: 50,
                  height: 50,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.broken_image, size: 50),
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
                Text.rich(TextSpan(children: [
                  const TextSpan(
                      text: 'Liquidity: ',
                      style: TextStyle(color: Colors.grey)),
                  TextSpan(text: "\$${widget.pool.liquidity}"),
                ])),
                const SizedBox(height: 4),
                Text.rich(TextSpan(children: [
                  const TextSpan(
                      text: 'Volume: ',
                      style: TextStyle(color: Colors.grey)),
                  TextSpan(text: "\$${widget.pool.volume}"),
                ])),
                const SizedBox(height: 4),
                Text.rich(TextSpan(children: [
                  const TextSpan(
                      text: 'Fees: ',
                      style: TextStyle(color: Colors.grey)),
                  TextSpan(text: "\$${widget.pool.fees}"),
                ])),
                const SizedBox(height: 16),
                Text(
                  "APY: ${widget.pool.apy}%",
                  style: const TextStyle(
                    color: Colors.greenAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            isHover ? Container(
              height: 45.0,
              alignment: Alignment.center,
              child: Text("+", style: TextStyle(fontSize: 32.0, color: Colors.grey.withOpacity(0.2))),
            ) : const SizedBox(height: 45.0)
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';


class PoolTableWidget extends StatelessWidget {
  final String poolName;
  final String poolLogo;
  final String totalLiquidity;
  final String volume24;
  final String fee24;
  final String apy;
  final Function() onTap;

  const PoolTableWidget({super.key, required this.poolName, required this.poolLogo, required this.totalLiquidity, required this.volume24, required this.fee24, required this.apy, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      splashColor: Colors.transparent,
      overlayColor: WidgetStatePropertyAll(Colors.grey.withOpacity(0.04)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: 100.0,
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Image.asset(
                        poolLogo,
                        height: 25.0,
                        width: 25.0,
                      ),
                      const SizedBox(width: 16.0),
                      Text(poolName),
                    ],
                  )),
              Container(
                  width: 180.0,
                  alignment: Alignment.center,
                  child: Text('\$$totalLiquidity')),
              Container(
                  width: 180.0,
                  alignment: Alignment.center,
                  child: Text('\$$volume24')),
              Container(
                  width: 180.0,
                  alignment: Alignment.center,
                  child: Text('\$$fee24')),
              Container(
                  width: 100.0,
                  alignment: Alignment.centerRight,
                  child: Text(apy)),
            ],
          ),
        ),
      ),
    );
  }
}

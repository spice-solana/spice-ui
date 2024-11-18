import 'package:flutter/material.dart';


class PoolTableWidget extends StatelessWidget {
  final String poolName;
  final String poolLogo;
  final String totalLiquidity;
  final String volume24;
  final String fee24;
  final String apy;

  const PoolTableWidget({super.key, required this.poolName, required this.poolLogo, required this.totalLiquidity, required this.volume24, required this.fee24, required this.apy});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        
      },
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
                      ClipRRect(
                          borderRadius: BorderRadius.circular(100.0),
                          child: Image.network(
                            poolLogo,
                            height: 25.0,
                            width: 25.0,
                          )),
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

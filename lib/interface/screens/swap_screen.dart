import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SwapScreen extends StatefulWidget {
  const SwapScreen({super.key});

  @override
  State<SwapScreen> createState() => _SwapScreenState();
}

class _SwapScreenState extends State<SwapScreen> {
  bool isTables = true;
  String? walletAddress;

  @override
  Widget build(BuildContext context) {
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              const SizedBox(height: 16.0),
              Container(
                height: 100.0,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.withOpacity(0.2),
                    width: 1.0,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Your selling',
                            style:
                                TextStyle(fontSize: 14.0, color: Colors.grey)),
                        const SizedBox(height: 8.0),
                        Container(
                            height: 50.0,
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(5.0)),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(100.0),
                                  child: Image.network(
                                      'https://s2.coinmarketcap.com/static/img/coins/64x64/5426.png',
                                      height: 25.0,
                                      width: 25.0),
                                ),
                                const SizedBox(width: 8.0),
                                const Text('SOL'),
                                const SizedBox(width: 8.0),
                                const Icon(Icons.arrow_drop_down_rounded,
                                    color: Colors.grey)
                              ],
                            ))
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.account_balance_wallet_outlined,
                                size: 14.0, color: Colors.grey),
                            SizedBox(width: 8.0),
                            Text('0 SOL',
                                style: TextStyle(
                                    fontSize: 14.0, color: Colors.grey)),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Container(
                            height: 50.0,
                            alignment: Alignment.center,
                            constraints: const BoxConstraints(
                                maxHeight: 50.0, maxWidth: 200.0),
                            child: TextField(
                              cursorColor: Theme.of(context).hintColor,
                              decoration: InputDecoration(
                                hintText: '0.00',
                                hintStyle: TextStyle(
                                    fontSize: 21.0,
                                    color: Colors.grey.withOpacity(0.2)),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                              ),
                              textAlign: TextAlign.right,
                              style: const TextStyle(fontSize: 21.0),
                              keyboardType: const TextInputType.numberWithOptions(
                                  decimal: true), // Поддержка чисел с точкой
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp(
                                    r'^\d*\.?\d*')), // Только числа и точка
                              ],
                            ))
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              Icon(Icons.swap_vert_rounded,
                  color: Colors.grey.withOpacity(0.5)),
              const SizedBox(height: 16.0),
              Container(
                height: 100.0,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.withOpacity(0.2),
                    width: 1.0,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Your buying',
                            style:
                                TextStyle(fontSize: 14.0, color: Colors.grey)),
                        const SizedBox(height: 8.0),
                        Container(
                            height: 50.0,
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(5.0)),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(100.0),
                                  child: Image.network(
                                      'https://s2.coinmarketcap.com/static/img/coins/64x64/3408.png',
                                      height: 25.0,
                                      width: 25.0),
                                ),
                                const SizedBox(width: 8.0),
                                const Text('USDC'),
                                const SizedBox(width: 8.0),
                                const Icon(Icons.arrow_drop_down_rounded,
                                    color: Colors.grey)
                              ],
                            ))
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.account_balance_wallet_outlined,
                                size: 14.0, color: Colors.grey),
                            SizedBox(width: 8.0),
                            Text('0 USDC',
                                style: TextStyle(
                                    fontSize: 14.0, color: Colors.grey)),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Container(
                            height: 50.0,
                            alignment: Alignment.center,
                            child: const Text('0.00',
                                style: TextStyle(fontSize: 21.0)))
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Container(
              height: 45.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: const Color(0xFFA1F6CA),
                  borderRadius: BorderRadius.circular(5.0)),
              child: const Text('Swap', style: TextStyle(color: Colors.black)),
            ),
          ),
        ],
      ),
    );
  }
}

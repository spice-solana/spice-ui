import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spice_ui/adapter/cubit/adapter_cubit.dart';
import 'package:spice_ui/adapter/cubit/adapter_states.dart';
import 'package:spice_ui/models/pool.dart';
import 'package:spice_ui/models/sroute.dart';
import 'package:spice_ui/swap/cubit/swap_cubit.dart';
import 'package:spice_ui/theme/cubit/theme_cubit.dart';
import 'package:spice_ui/utils/links.dart';
import 'package:spice_ui/widgets/custom_inkwell.dart';


class SwapMobScreen extends StatefulWidget {
  final Pool a;
  final Pool b;
  final bool isRouteLoading;
  final Sroute? spiceRoute;
  final String? error;
  const SwapMobScreen(
      {super.key,
      required this.a,
      required this.b,
      required this.isRouteLoading,
      this.spiceRoute,
      this.error});

  @override
  State<SwapMobScreen> createState() => _SwapMobScreenState();
}

class _SwapMobScreenState extends State<SwapMobScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final SwapCubit swapCubit = context.read<SwapCubit>();
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 500.0,
            width: 400.0,
            padding: const EdgeInsets.all(16.0),
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
                          color: Theme.of(context).hintColor,
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
                              CustomInkWell(
                                onTap: () =>
                                    swapCubit.moveToChooseTokenScreen("selling"),
                                child: Container(
                                    height: 50.0,
                                    padding: const EdgeInsets.all(8.0),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(5.0)),
                                    child: Row(
                                      children: [
                                        Image.asset(widget.a.logoUrl,
                                            height: 25.0, width: 25.0),
                                        const SizedBox(width: 8.0),
                                        Text(widget.a.symbol),
                                        const SizedBox(width: 8.0),
                                        const Icon(Icons.arrow_drop_down_rounded,
                                            color: Colors.grey)
                                      ],
                                    )),
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.account_balance_wallet_outlined,
                                      size: 14.0, color: Colors.grey),
                                  const SizedBox(width: 8.0),
                                  Text('0 ${widget.a.symbol}',
                                      style: const TextStyle(
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
                                    controller: _controller,
                                    onChanged: (value) =>
                                        swapCubit.getRoute(inputAmount: value),
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
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal:
                                                true), // Поддержка чисел с точкой
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'^\d*\.?\d*')),
                                    ],
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    CustomInkWell(
                      onTap: () {
                        _controller.clear();
                        swapCubit.tokensFlip();
                      },
                      child: Icon(Icons.swap_vert_rounded,
                          color: Colors.grey.withOpacity(0.5)),
                    ),
                    const SizedBox(height: 16.0),
                    Container(
                      height: 100.0,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).hintColor,
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
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.grey)),
                              const SizedBox(height: 8.0),
                              CustomInkWell(
                                onTap: () =>
                                    swapCubit.moveToChooseTokenScreen("buying"),
                                child: Container(
                                    height: 50.0,
                                    padding: const EdgeInsets.all(8.0),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(5.0)),
                                    child: Row(
                                      children: [
                                        Image.asset(widget.b.logoUrl,
                                            height: 25.0, width: 25.0),
                                        const SizedBox(width: 8.0),
                                        Text(widget.b.symbol),
                                        const SizedBox(width: 8.0),
                                        const Icon(Icons.arrow_drop_down_rounded,
                                            color: Colors.grey)
                                      ],
                                    )),
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                      Icons.account_balance_wallet_outlined,
                                      size: 14.0,
                                      color: Colors.grey),
                                  const SizedBox(width: 8.0),
                                  Text('0 ${widget.b.symbol}',
                                      style: const TextStyle(
                                          fontSize: 14.0, color: Colors.grey)),
                                ],
                              ),
                              const SizedBox(height: 8.0),
                              Container(
                                  height: 50.0,
                                  alignment: Alignment.center,
                                  child: widget.isRouteLoading
                                      ? const SizedBox(
                                          height: 21.0,
                                          width: 21.0,
                                          child: CircularProgressIndicator(
                                              color: Colors.grey,
                                              strokeWidth: 1.0))
                                      : Text(
                                          widget.spiceRoute?.uiOutputAmount ?? "",
                                          style: const TextStyle(fontSize: 21.0)))
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Text(widget.error ?? '',
                    style: const TextStyle(fontSize: 14.0, color: Colors.red)),
                BlocBuilder<AdapterCubit, AdapterStates>(
                  builder: (context, state) {
                    if (state is ConnectedAdapterState) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: CustomInkWell(
                          onTap: () => swapCubit.swap(context,
                              adapter: context.read<AdapterCubit>(),
                              route: widget.spiceRoute!,
                              isDark: context.read<ThemeCubit>().state.darkTheme),
                          child: Container(
                            height: 45.0,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: widget.isRouteLoading
                                    ? Theme.of(context).colorScheme.secondary
                                    : const Color(0xFFA1F6CA),
                                borderRadius: BorderRadius.circular(5.0)),
                            child: const Text('Swap',
                                style: TextStyle(color: Colors.black)),
                          ),
                        ),
                      );
                    }
          
                    if (state is UnconnectedAdapterState) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: CustomInkWell(
                          onTap: () => context.read<AdapterCubit>().connect(),
                          child: Container(
                            height: 45.0,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.secondary,
                                borderRadius: BorderRadius.circular(5.0)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text('Connect',
                                    style: TextStyle(color: Colors.black)),
                                const SizedBox(width: 16.0),
                                SvgPicture.asset(walletLogo,
                                    height: 16.0, width: 16.0),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
          
                    return const SizedBox();
                  },
                ),
              ],
            ),
          ),
        ],
    );
  }
}

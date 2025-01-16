import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spice_ui/adapter/controller/adapter_cubit.dart';
import 'package:spice_ui/adapter/controller/adapter_states.dart';
import 'package:spice_ui/main/controller/main_cubit.dart';
import 'package:spice_ui/models/pool.dart';
import 'package:spice_ui/models/sroute.dart';
import 'package:spice_ui/widgets/custom_inkwell.dart';
import 'package:spice_ui/widgets/linear_route_update_bar.dart';

class SwapScreen extends StatefulWidget {
  final Pool a;
  final Pool b;
  final bool isRouteLoading;
  final Sroute? spiceRoute;
  final String? error;
  const SwapScreen(
      {super.key,
      required this.a,
      required this.b,
      required this.isRouteLoading,
      this.spiceRoute,
      this.error});

  @override
  State<SwapScreen> createState() => _SwapScreenState();
}

class _SwapScreenState extends State<SwapScreen> {
  final TextEditingController _controller = TextEditingController();

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
                        CustomInkWell(
                          onTap: () =>
                              mainCubit.moveToChooseTokenScreen("selling"),
                          child: Container(
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
                                    child: Image.network(widget.a.logoUrl,
                                        height: 25.0, width: 25.0),
                                  ),
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
                                  mainCubit.getRoute(inputAmount: value),
                              cursorColor: Theme.of(context).hintColor,
                              cursorWidth: 1.0,
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
              CustomInkWell(
                onTap: () {
                  _controller.clear();
                  mainCubit.tokensFlip();
                },
                child: Icon(Icons.swap_vert_rounded,
                    color: Colors.grey.withOpacity(0.5)),
              ),
              const SizedBox(height: 16.0),
              Stack(
                alignment: Alignment.topLeft,
                children: [
                  widget.spiceRoute != null ? LinearRouteUpdateBar(inputAmount: _controller.text, duration: widget.spiceRoute!.routeUpdateTime) : const SizedBox(),
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
                            CustomInkWell(
                              onTap: () =>
                                  mainCubit.moveToChooseTokenScreen("buying"),
                              child: Container(
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
                                        child: Image.network(widget.b.logoUrl,
                                            height: 25.0, width: 25.0),
                                      ),
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
                                const Icon(Icons.account_balance_wallet_outlined,
                                    size: 14.0, color: Colors.grey),
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
                                            color: Colors.grey, strokeWidth: 1.0))
                                    : Text(widget.spiceRoute?.uiOutputAmount ?? "",
                                        style: const TextStyle(fontSize: 21.0)))
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Text(widget.error ?? '', style: const TextStyle(fontSize: 14.0, color: Colors.red)),
          BlocBuilder<AdapterCubit, AdapterStates>(
            builder: (context, state) {

              if (state is ConnectedAdapterState) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: CustomInkWell(
                    onTap: () => mainCubit.swap(context, route: widget.spiceRoute!),
                    child: Container(
                      height: 45.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: widget.isRouteLoading
                              ? Colors.grey
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
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text('Connect',
                                  style: TextStyle(color: Colors.black)),
                              const SizedBox(width: 16.0),
                              SvgPicture.asset('assets/logos/phantom_logo.svg',
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
    );
  }
}

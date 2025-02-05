import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spice_ui/adapter/controller/adapter_cubit.dart';
import 'package:spice_ui/adapter/controller/adapter_states.dart';
import 'package:spice_ui/main/controller/main_cubit.dart';
import 'package:spice_ui/models/portfolio.dart';
import 'package:spice_ui/widgets/custom_inkwell.dart';
import 'package:spice_ui/widgets/position_widget.dart';
import 'package:spice_ui/widgets/stat_widget.dart';

class PortfolioScreen extends StatefulWidget {
  final bool showLoadingIndicator;
  final Portfolio? portfolio;
  const PortfolioScreen(
      {super.key, required this.showLoadingIndicator, required this.portfolio});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdapterCubit, AdapterStates>(builder: (context, state) {
      if (state is ConnectedAdapterState) {
        return widget.showLoadingIndicator
            ? const Center(child: Text('Loading...'))
            : Expanded(
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 100.0),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.7,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            StatWidget(
                                title: "Total liquidity", data: "\$${widget.portfolio != null ? widget.portfolio?.totalLiquidityInUsd : 0}"),
                            StatWidget(title: "Earned", data: "\$${widget.portfolio != null ? widget.portfolio?.earnedInUsd : 0}"),
                            StatWidget(
                                title: "All-time claimed", data: "\$${widget.portfolio != null ? widget.portfolio?.allTimeClaimedInUsd : 0}"),
                          ],
                        ),
                      ),
                      const SizedBox(height: 100.0),
                      SizedBox(
                          width: MediaQuery.of(context).size.width / 1.7,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Your liquidity',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .hintColor
                                          .withOpacity(0.5))),
                              IconButton(
                                  onPressed: () => context
                                      .read<MainCubit>()
                                      .updatePortfolio(
                                          context.read<AdapterCubit>()),
                                  icon: Icon(Icons.refresh,
                                      size: 18.0,
                                      color: Theme.of(context)
                                          .hintColor
                                          .withOpacity(0.5)))
                            ],
                          )),
                      widget.portfolio == null || widget.portfolio!.positions.isEmpty
                      ? SizedBox(
                        width: MediaQuery.of(context).size.width / 1.7,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 100.0),
                          child: Center(child: Column(
                            children: [
                              const Text("You don't have a position"),
                              const SizedBox(height: 16.0),
                              CustomInkWell(
                                onTap: () => context.read<MainCubit>().moveToLiquidityScreen(),
                                child: Container(
                                  height: 32.0,
                                  width: 260.0,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: const Color(0xFFA1F6CA),
                                      borderRadius: BorderRadius.circular(5.0)),
                                  child: const Text('Open position',
                                      style: TextStyle(color: Colors.black)),
                                ),
                              ),
                            ],
                          )),
                        ),
                      ) 
                      : SizedBox(
                        height: widget.portfolio!.positions.length * 106.0,
                        width: MediaQuery.of(context).size.width / 1.7,
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: widget.portfolio?.positions.length,
                          itemBuilder: (context, index) {
                              return PositionWidget(position: widget.portfolio!.positions[index]);
                          }),
                      ),
                    ],
                  ),
                ),
              );
      }

      if (state is UnconnectedAdapterState) {
        return Center(
            child: Text('Connect your wallet to get portfolio data',
                style: TextStyle(
                    color: Theme.of(context).hintColor.withOpacity(0.5))));
      }

      return const SizedBox();
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:spice_ui/adapter/controller/adapter_cubit.dart';
import 'package:spice_ui/bars/bottom_bar.dart';
import 'package:spice_ui/bars/top_bar.dart';
import 'package:spice_ui/portfolio/cubit/portfolio_cubit.dart';
import 'package:spice_ui/portfolio/cubit/portfolio_states.dart';
import 'package:spice_ui/widgets/custom_inkwell.dart';
import 'package:spice_ui/widgets/custom_vertical_divider.dart';
import 'package:spice_ui/widgets/loading_text.dart';
import 'package:spice_ui/widgets/position_widget.dart';
import 'package:spice_ui/widgets/rotor_anim.dart';
import 'package:spice_ui/widgets/stat_widget.dart';


class PortfolioScreenController extends StatelessWidget {
  const PortfolioScreenController({super.key});

  @override
  Widget build(BuildContext context) {
    final AdapterCubit adapterCubit = context.read<AdapterCubit>();
    final PortfolioCubit portfolioCubit = context.read<PortfolioCubit>();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const TopBar(state: 3),
          BlocBuilder<PortfolioCubit, PortfolioStates>(builder: (context, state) {
            if (state is LoadingPortfolioScreenState) {
              return const Center(child: LoadingText());
            }

            if (state is LoadedPortfolioScreenState) {
              return Expanded(
                      child: SingleChildScrollView(
                        physics: const ClampingScrollPhysics(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 32.0),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 1.7,
                              child: Column(
                                children: [
                                  Divider(color: Theme.of(context).hintColor),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      StatWidget(
                                          title: "Total liquidity", data: "\$${state.portfolio != null ? state.portfolio?.totalLiquidityInUsd : 0}"),
                                      const CustomVerticalDivider(height: 35.0),
                                      StatWidget(title: "Earned", data: "\$${state.portfolio != null ? state.portfolio?.earnedInUsd : 0}"),
                                      const CustomVerticalDivider(height: 35.0),
                                      StatWidget(
                                          title: "All-time claimed", data: "\$${state.portfolio != null ? state.portfolio?.allTimeClaimedInUsd : 0}"),
                                    ],
                                  ),
                                  Divider(color: Theme.of(context).hintColor),
                                ],
                              ),
                            ),
                            const SizedBox(height: 32.0),
                            Container(
                              height: MediaQuery.of(context).size.height / 3,
                              width: MediaQuery.of(context).size.width / 1.7,
                              alignment: Alignment.center,
                              child: RotorAnim(isPlaying: state.portfolio!.positions.isNotEmpty),
                            ),
                            const SizedBox(height: 32.0),
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
                                        onPressed: () => portfolioCubit.updatePortfolio(signer: adapterCubit.signer!),
                                        icon: Icon(Icons.refresh,
                                            size: 18.0,
                                            color: Theme.of(context)
                                                .hintColor
                                                .withOpacity(0.5)))
                                  ],
                                )),
                            state.portfolio == null || state.portfolio!.positions.isEmpty
                            ? SizedBox(
                              width: MediaQuery.of(context).size.width / 1.7,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 100.0),
                                child: Center(child: Column(
                                  children: [
                                    const Text("You don't have a position"),
                                    const SizedBox(height: 16.0),
                                    CustomInkWell(
                                      onTap: () => context.go('/'),
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
                              height: state.portfolio!.positions.length * 106.0,
                              width: MediaQuery.of(context).size.width / 1.7,
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.portfolio?.positions.length,
                                itemBuilder: (context, index) {
                                    return PositionWidget(position: state.portfolio!.positions[index]);
                                }),
                            ),
                          ],
                        ),
                      ),
                    );
            }
          
            if (state is NoPortfolioScreenState) {
              return Center(
                  child: Text('Connect your wallet to get portfolio data',
                      style: TextStyle(
                          color: Theme.of(context).hintColor.withOpacity(0.5))));
            }
          
            return const SizedBox();
          }),
          const BottomBar()
        ],
      ),
    );
  }
}

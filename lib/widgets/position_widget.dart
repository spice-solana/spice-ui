import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spice_ui/adapter/controller/adapter_cubit.dart';
import 'package:spice_ui/dialogs/action_dialog.dart';
import 'package:spice_ui/models/portfolio.dart';
import 'package:spice_ui/portfolio/cubit/portfolio_cubit.dart';
import 'package:spice_ui/widgets/backlight_text.dart';
import 'package:spice_ui/widgets/custom_inkwell.dart';
import 'package:spice_ui/widgets/dots_menu_element.dart';


class PositionWidget extends StatefulWidget {
  final Position position;
  const PositionWidget({super.key, required this.position});

  @override
  State<PositionWidget> createState() => _PositionWidgetState();
}

class _PositionWidgetState extends State<PositionWidget> {
  final GlobalKey _buttonKey = GlobalKey();
  OverlayEntry? _overlayEntry;

  void _toggleMenu() {
    if (_overlayEntry != null) {
      _closeMenu();
    } else {
      _openMenu();
    }
  }

    void _openMenu() {
    final RenderBox buttonBox = _buttonKey.currentContext!.findRenderObject() as RenderBox;
    final Offset buttonPosition = buttonBox.localToGlobal(Offset.zero);
    final Size buttonSize = buttonBox.size;
    final Size screenSize = MediaQuery.of(context).size;

    final bool openDown = buttonPosition.dy + buttonSize.height + 64.0 + 150.0 <
        screenSize.height;

    _overlayEntry = OverlayEntry(
      builder: (BuildContext overlayContext) {
        return GestureDetector(
          onTap: _closeMenu,
          child: Stack(
            children: [
              Container(
                color: Colors.transparent,
              ),
              Positioned(
                left: buttonPosition.dx,
                top: openDown
                    ? buttonPosition.dy + 64.0
                    : buttonPosition.dy - 64.0,
                child: Material(
                  elevation: 8,
                  color: Colors.transparent,
                  child: Container(
                    width: 220,
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.2),
                        width: 1.0,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DotsMenuElement(title: '+ Increase liquidity', onTap: () {
                          _closeMenu();
                          showActionDialog(context, pool: widget.position.pool, action: "add", title: "Increase liquidity", actionColor: Colors.greenAccent, balance: widget.position.liquidity);
                        }),
                        DotsMenuElement(title: '- Withdraw liquidity', onTap: () {
                          _closeMenu();
                          showActionDialog(context, pool: widget.position.pool, action: "withdraw", title: "Withdraw liquidity", actionColor: Colors.redAccent, balance: widget.position.liquidity);
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _closeMenu() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        height: 90.0,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        color: Colors.grey.withOpacity(0.05),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              width: 100.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(100.0),
                      child: Image.network(
                          widget.position.pool.logoUrl,
                          height: 25.0,
                          width: 25.0)),
                  const SizedBox(width: 8.0),
                  Text(widget.position.pool.symbol),
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              width: 200.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Liquidity",
                      style: TextStyle(
                          color: Theme.of(context).hintColor.withOpacity(0.5))),
                  const SizedBox(height: 4.0),
                  Text(widget.position.liquidity),
                  const SizedBox(height: 4.0),
                  Text("\$${widget.position.liquidityInUsd}",
                      style: TextStyle(
                          fontFamily: '',
                          fontSize: 12.0,
                          color: Theme.of(context).hintColor.withOpacity(0.5)))
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              width: 150.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Earned",
                      style: TextStyle(
                          color: Theme.of(context).hintColor.withOpacity(0.5))),
                  const SizedBox(height: 4.0),
                  Text(widget.position.earned),
                  const SizedBox(height: 4.0),
                  Text("\$${widget.position.earnedInUsd}",
                      style: TextStyle(
                          fontFamily: '',
                          fontSize: 12.0,
                          color: Theme.of(context).hintColor.withOpacity(0.5)))
                ],
              ),
            ),
            Row(
              children: [
                // IconButton(
                //     onPressed: () => showActionDialog(context,
                //         pool: position.pool,
                //         action: "withdraw",
                //         title: "- Withdraw liquidity",
                //         actionColor: Colors.redAccent, balance: position.liquidity),
                //     icon: const Icon(Icons.remove, color: Colors.redAccent)),
                // const SizedBox(width: 32.0),
                // IconButton(
                //     onPressed: () => showActionDialog(context,
                //         pool: position.pool,
                //         action: "add",
                //         title: "+ Add liquidity",
                //         actionColor: const Color(0xFFA1F6CA), balance: '0'),
                //     icon: const Icon(Icons.add, color: Colors.greenAccent)),
                // const SizedBox(width: 36.0),
                BacklightText(
                    text: "Claim",
                    onTap: () => context.read<PortfolioCubit>().claimIncome(context, adapter: context.read<AdapterCubit>(), pool: widget.position.pool),
                    color: Colors.amber),
                const SizedBox(width: 36.0),
                CustomInkWell(
                  key: _buttonKey,
                  onTap: _toggleMenu,
                  child: Icon(Icons.more_vert, color: Colors.grey.withOpacity(0.6))),
              ],
            )
          ],
        ),
      ),
    );
  }
}

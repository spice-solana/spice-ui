import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spice_ui/transaction_bundle/controller/tb_cubit.dart';
import 'package:spice_ui/transaction_bundle/controller/tb_states.dart';
import 'package:spice_ui/widgets/custom_inkwell.dart';

class CustomTbMenu extends StatefulWidget {
  const CustomTbMenu({super.key});

  @override
  State<CustomTbMenu> createState() => _CustomTbMenuState();
}

class _CustomTbMenuState extends State<CustomTbMenu> {
  bool isHover = false;

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
    final RenderBox buttonBox =
        _buttonKey.currentContext!.findRenderObject() as RenderBox;
    final Offset buttonPosition = buttonBox.localToGlobal(Offset.zero);
    final Size buttonSize = buttonBox.size;
    final Size screenSize = MediaQuery.of(context).size;

    final bool openDown = buttonPosition.dy + buttonSize.height + 64.0 + 150.0 <
        screenSize.height;

    Widget buildMenuOption({
      required String title,
      required String value,
      required bool isSelected,
      required VoidCallback onTap,
    }) {
      return CustomInkWell(
        onTap: onTap,
        child: Container(
          height: 50.0,
          width: 110.0,
          decoration: BoxDecoration(
            color: isSelected
                ? Theme.of(context).colorScheme.onPrimary
                : Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14.0,
                  color: isSelected ? Colors.black : Colors.grey,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 12.0,
                  color: isSelected ? Colors.black : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      );
    }

    menuSwitcher() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildMenuOption(
            title: 'Normal',
            value: '0.00004',
            isSelected: context.read<TbCubit>().currencyPriority == 1,
            onTap: () {
              context.read<TbCubit>().changePriority(1);
              setState(() {});
            },
          ),
          buildMenuOption(
            title: 'High',
            value: '0.001583',
            isSelected: context.read<TbCubit>().currencyPriority == 2,
            onTap: () {
              context.read<TbCubit>().changePriority(2);
              setState(() {});
            },
          ),
          buildMenuOption(
            title: 'Turbo',
            value: '0.005',
            isSelected: context.read<TbCubit>().currencyPriority == 3,
            onTap: () {
              context.read<TbCubit>().changePriority(3);
              setState(() {});
            },
          ),
        ],
      );
    }

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
                    : buttonPosition.dy - 150.0 - 64.0,
                child: Material(
                  elevation: 8,
                  color: Colors.transparent,
                  child: Container(
                    height: 200,
                    width: 400,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.2),
                        width: 1.0,
                      ),
                    ),
                    child: BlocBuilder<TbCubit, TransactionBundleState>(
                      builder: (context, state) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Transaction priority',
                                style: TextStyle(fontSize: 14.0)),
                            menuSwitcher(),
                            const SizedBox(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 30.0,
                                  width: 47.0,
                                  child: FittedBox(
                                    fit: BoxFit.fill,
                                    child: CupertinoSwitch(
                                      value: state.jito,
                                      onChanged: (value) =>
                                          context.read<TbCubit>().onJito(value),
                                      activeColor: const Color(0xFF80EEFB),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16.0),
                                const Text(
                                  'Use Jito bundled transactions',
                                  style: TextStyle(fontSize: 14.0),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
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
    return CustomInkWell(
      key: _buttonKey,
      onHover: (value) {
        setState(() {
          isHover = value;
        });
      },
      onTap: _toggleMenu,
      child: Row(
        children: [
          Icon(
            Icons.speed,
            size: 21.0,
            color: isHover ? Theme.of(context).colorScheme.onPrimary : null,
          ),
          const SizedBox(width: 16.0),
          Text(
            context.read<TbCubit>().priorityType,
            style: TextStyle(
              color: isHover ? Theme.of(context).colorScheme.onPrimary : null,
              fontSize: 14.0,
            ),
          ),
        ],
      ),
    );
  }
}

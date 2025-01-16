import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spice_ui/main/controller/main_cubit.dart';

class LinearRouteUpdateBar extends StatefulWidget {
  final int duration;
  final String inputAmount;
  const LinearRouteUpdateBar({super.key, required this.inputAmount, required this.duration});

  @override
  State<LinearRouteUpdateBar> createState() => _LinearRouteUpdateBarState();
}

class _LinearRouteUpdateBarState extends State<LinearRouteUpdateBar> {

  double containerWidth = 400.0;
  Timer? debounce;

    @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() => containerWidth = 0.0);
    });
    debounce = Timer.periodic(Duration(seconds: widget.duration), (timer) {
      context.read<MainCubit>().getRoute(inputAmount: widget.inputAmount);
    });
  }

  @override
  void dispose() {
    super.dispose();
    debounce?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 1.0,
      width: containerWidth,
      duration: Duration(seconds: widget.duration),
      curve: Curves.linear,
      decoration: BoxDecoration(
        border: Border.all(
            color: Theme.of(context).colorScheme.onPrimary, width: 1.0),
      ),
    );
  }
}

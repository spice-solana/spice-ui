import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class BottomMobBar extends StatelessWidget {
  final int active;
  const BottomMobBar({super.key, required this.active});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).hintColor,
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildNavButton(context, "Swap", "/swap", active == 1 ? true : false),
          _buildNavButton(
              context, "Liquidity", "/", active == 2 ? true : false),
          _buildNavButton(
              context, "Portfolio", "/portfolio", active == 3 ? true : false),
        ],
      ),
    );
  }

  Widget _buildNavButton(
      BuildContext context, String title, String route, bool isActive) {
    return GestureDetector(
      onTap: () => context.go(route),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
          color: isActive ? null : Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}

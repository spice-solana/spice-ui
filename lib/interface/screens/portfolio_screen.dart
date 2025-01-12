import 'package:flutter/material.dart';


class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("No data", style: TextStyle(color: Colors.grey.withOpacity(0.2))));
  }
}

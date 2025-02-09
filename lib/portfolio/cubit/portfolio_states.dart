import 'package:spice_ui/models/portfolio.dart';

abstract class PortfolioStates {}

class LoadingPortfolioScreenState extends PortfolioStates {}

class LoadedPortfolioScreenState extends PortfolioStates {
  final Portfolio? portfolio;

  LoadedPortfolioScreenState({required this.portfolio});
}

class NoPortfolioScreenState extends PortfolioStates {}
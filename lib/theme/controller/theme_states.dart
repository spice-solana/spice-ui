class ThemeState {
  final bool icon;
  final bool darkTheme;

  ThemeState({required this.icon, required this.darkTheme});

  factory ThemeState.init(bool isTheme) =>
      ThemeState(icon: isTheme, darkTheme: isTheme);
}

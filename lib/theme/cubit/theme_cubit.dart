import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'theme_states.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit({state}) : super(ThemeState.init(Hive.box('appBox').isNotEmpty ? Hive.box('appBox').get('themeKey') : true));

  Future<void> changeTheme() async {
    var box = Hive.box('appBox');
    final bool darkTheme = box.get('themeKey') ?? true;
    await box.put('themeKey', !darkTheme);
    emit(ThemeState(icon: !darkTheme, darkTheme: !darkTheme));
  }

}

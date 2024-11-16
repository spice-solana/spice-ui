import 'package:flutter_bloc/flutter_bloc.dart';
import 'theme_states.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit({state}) : super(ThemeState.init(true));

  Future<void> changeTheme() async {
    // var box = Hive.box(appBox);
    // Settings? settings = box.get(settingsKey);
    // settings!.darkTheme = !settings.darkTheme;
    // box.put(settingsKey, settings);
    // emit(ThemeState(icon: !state.icon, darkTheme: !state.darkTheme));
  }

}

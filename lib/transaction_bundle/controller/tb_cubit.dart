import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hive/hive.dart';
import 'tb_states.dart';

class TbCubit extends Cubit<TransactionBundleState> {
  TbCubit({state}) : super(TransactionBundleState.init(1, false));

  var currenctPriority = 1;
  var currentJito = false;
  var priorityType = 'Normal';

  Future<void> changePriority(int priority) async {
    currenctPriority = priority;
    // var box = Hive.box('appBox');
    // final bool darkTheme = box.get('themeKey') ?? false;
    // await box.put('themeKey', !darkTheme);

    switch (priority) {
      case 1:
        priorityType = 'Normal';
        break;
      case 2:
        priorityType = 'High';
        break;
      case 3:
        priorityType = 'Turbo';
        break;
    }

    emit(TransactionBundleState(priority: currenctPriority, jito: currentJito));
  }

    Future<void> onJito(bool jito) async {
    currentJito = jito;
    // var box = Hive.box('appBox');
    // final bool darkTheme = box.get('themeKey') ?? false;
    // await box.put('themeKey', !darkTheme);
    emit(TransactionBundleState(priority: currenctPriority, jito: jito));
  }

}

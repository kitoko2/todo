import 'package:get_it/get_it.dart';
import 'package:todo/core/di_files/auth_module.dart';
import 'package:todo/core/di_files/core_module.dart';

import 'note_module.dart';

final getIt = GetIt.instance;

class Di {
  static Future<void> init() async {
    await CoreModule.init(getIt);
    await AuthModule.init(getIt);
    await NoteModule.init(getIt);
  }
}

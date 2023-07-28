import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:hive/hive.dart';

import '../../models/pessoa_model.dart';

class CacheHive {
  static build() async {
    var documentsDirectory =
        await path_provider.getApplicationDocumentsDirectory();

    Hive.init(documentsDirectory.path);

    Hive.registerAdapter<PessoaModel>(PessoaModelAdapter());

    await Hive.openBox('myBox');
  }
}

import 'package:get_it/get_it.dart';
import 'package:pokedex_flutter/data/api/api.dart';

void initApi() {
  GetIt.I.registerSingleton<NetworkHelper>(
    NetworkHelper(),
  );
}

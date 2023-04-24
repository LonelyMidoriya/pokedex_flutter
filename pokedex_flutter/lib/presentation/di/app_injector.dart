import 'package:pokedex_flutter/presentation/di/repository_injector.dart';
import 'api_injector.dart';
import 'db_injector.dart';

Future<void> initInjectors() async {
  initApi();
  await initDb();
  initRepository();
}
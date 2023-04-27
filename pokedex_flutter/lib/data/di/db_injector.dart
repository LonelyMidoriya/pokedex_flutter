import '../db/DataBase.dart';

Future<void> initDb() async {
  await DatabaseRepository.instance.database;
}
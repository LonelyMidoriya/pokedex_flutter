import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'models/Pokemon.dart';
import 'models/PokemonEntry.dart';

class DatabaseRepository {
  static const String id = 'id';
  static const String height = 'height';
  static const String hpStat = 'hpStat';
  static const String tableName1 = 'Table1';
  static const String tableName2 = 'Table2';
  static const String name = 'name';
  static const String attackStat = 'attackStat';
  static const String defenseStat = 'defenseStat';
  static const String spAttackStat = 'spAttackStat';
  static const String spDefStat = 'spDefStat';
  static const String speedStat = 'speedStat';
  static const String weight = 'weight';
  static const String types = 'types';
  static const String url = 'url';


  static final DatabaseRepository instance = DatabaseRepository._init();
  DatabaseRepository._init();

  Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('pokemondb.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
create table ${tableName1} ( 
  ${id} integer primary key, 
  ${height} integer not null,
  ${hpStat} integer not null,
  ${name} text not null,
  ${attackStat} integer not null,
  ${defenseStat} integer not null,
  ${spAttackStat} integer not null,
  ${spDefStat} integer not null,
  ${speedStat} integer not null,
  ${weight} integer not null,
  ${types} text not null)
''');
    await db.execute('''
  create table ${tableName2} ( 
  ${url} text not null,
  ${name} text primary key)
''');
  }

  Future<void> insertPokemon({required Pokemon pokemon}) async {
      final db = await instance.database;
      await db.insert(tableName1, pokemon.toMap(),conflictAlgorithm: ConflictAlgorithm.ignore,);
  }

  Future<void> insertPokemonList({required PokemonEntry pokemon}) async {
    final db = await instance.database;
    await db.insert(tableName2, pokemon.toMap(),conflictAlgorithm: ConflictAlgorithm.ignore,);
  }

  Future<List<PokemonEntry>> getPokemonList(int limit, int offset) async {
    final db = await instance.database;

    final result = await db.query(tableName2,limit:limit,offset: offset);

    return result.map((json) => PokemonEntry.fromJson(json)).toList();
  }

  Future<Pokemon> getPokemon(int id) async {
    final db = await instance.database;

    final result = await db.query(tableName1,where: "id = $id");
    if(result.isNotEmpty){
      return Pokemon.fromJson(result.first);
    }
    else {
      return Pokemon(id: 0, height: 0, name: "Connection Error", hpStat: 0, attackStat: 0, defenseStat: 0,
        spAttackStat: 0, spDefStat: 0, speedStat: 0, weight: 0, types: ['error']);
    }
  }
}
import 'package:get_it/get_it.dart';
import 'package:pokedex_flutter/data/mappers/pokemon_entry_mapper.dart';
import 'package:pokedex_flutter/data/mappers/pokemon_mapper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../domain/models/pokemon.dart';
import '../../domain/models/pokemon_entry.dart';
import '../../utils/consts.dart';

class DatabaseRepository {
  final PokemonEntryMapper pokemonEntryMapper;
  final PokemonMapper pokemonMapper;
  static final DatabaseRepository instance = DatabaseRepository._init(
    GetIt.I.get<PokemonEntryMapper>(),
    GetIt.I.get<PokemonMapper>(),
  );
  DatabaseRepository._init(this.pokemonEntryMapper, this.pokemonMapper);

  Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('pokemondb9.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
create table $tableName1 ( 
  $id integer primary key, 
  $height integer not null,
  $hpStat integer not null,
  $name text not null,
  $attackStat integer not null,
  $defenseStat integer not null,
  $spAttackStat integer not null,
  $spDefStat integer not null,
  $speedStat integer not null,
  $weight integer not null,
  $types text not null)
''');
    await db.execute('''
  create table $tableName2 (
  $id int not null,  
  $urlText text not null,
  $name text primary key)
''');
    await db.execute('''
  create table $tableName3 ( 
  $pagesCount int primary key)
''');
  }

  Future<void> insertPokemon({required Pokemon pokemon}) async {
    final db = await instance.database;
    await db.insert(
      tableName1,
      pokemonMapper.toMap(pokemon),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<void> insertPagesCount({required int pagesCount}) async {
    final db = await instance.database;
    await db.insert(
      tableName3,
      {'pagesCount': pagesCount},
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<void> insertPokemonList({required PokemonEntry pokemonEntry}) async {
    final db = await instance.database;
    await db.insert(
      tableName2,
      pokemonEntryMapper.toMap(pokemonEntry),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<List<PokemonEntry>> getPokemonList(int limit, int offset) async {
    final db = await instance.database;
    final result = await db.query(tableName2,
        where: "id > $offset and id <= ${offset + limit}");
    return result
        .map((json) => pokemonEntryMapper.toPokemonEntry(json))
        .toList();
  }

  Future<int> getPagesCount() async {
    final db = await instance.database;
    final result = await db.query(tableName3);
    return result.first['pagesCount'] as int;
  }

  Future<Pokemon> getPokemon(int id) async {
    final db = await instance.database;

    final result = await db.query(tableName1, where: "id = $id");
    if (result.isNotEmpty) {
      return pokemonMapper.toPokemon(result.first);
    } else {
      return Pokemon(
          id: 0,
          height: 0,
          name: "Connection Error",
          hpStat: 0,
          attackStat: 0,
          defenseStat: 0,
          spAttackStat: 0,
          spDefStat: 0,
          speedStat: 0,
          weight: 0,
          types: ['error']);
    }
  }
}

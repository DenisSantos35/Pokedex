import 'package:flutter_application_pokedex/model/pokemons_model.dart';
import 'package:logger/logger.dart';
import 'package:sqflite/sqflite.dart';

class DataBase {
  Future<Database> get database async =>
      await openDatabase('pokemons_database.db', version: 1,
          onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE favorites_pokemons(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, type TEXT, image TEXT, is_favorite INTEGER)',
        );
      }, onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          // Se estiver atualizando da versão anterior para uma nova
          await db.execute('''
          CREATE TABLE favorites_pokemons(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            type TEXT,
            image TEXT,
            is_favorite INTEGER
          )
          ''');
        }
      });
  Future<bool> insertFavoritePokemons(PokemonsModel pokemons) async {
    try {
      final db = await database;
      final compare = await selectFavoritePokemons(pokemons.name);
      if (compare.length != 0) return false;
      final result = await db.insert(
        'favorites_pokemons',
        pokemons.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return true;
    } catch (e) {
      Logger().e(e);
      return false;
    }
  }

  Future<bool> deleteFavoritePokemons(int id) async {
    try {
      final db = await database;
      await db.delete('favorites_pokemons', where: 'id = ?', whereArgs: [id]);
      return true;
    } catch (e) {
      Logger().e(e);
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> selectFavoritePokemons(String name) async {
    final db = await (database);
    final result = await db
        .rawQuery('SELECT * FROM favorites_pokemons where name = ?', [name]);
    Logger().e(result);
    return result;
  }

  Future<List<Map<String, dynamic>>> selectAllFavoritePokemons() async {
    final db = await (database);
    final result = await db.rawQuery('SELECT * FROM favorites_pokemons ');
    Logger().e(result);
    return result;
  }
}

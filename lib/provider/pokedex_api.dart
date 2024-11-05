import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_pokedex/db/poke_data_base.dart';
import 'package:flutter_application_pokedex/model/pokemons_model.dart';

class PokedexApi {
  final _dio = Dio();
  final db = DataBase();
  List pokemons = [];
  int nextPage = 1;
  bool loading = true;

  Future<List> getPokedexApi() async {
    List data = [];
    final response = await _dio.get(
        "https://pokeapi.co/api/v2/pokemon/?offset=${(nextPage - 1) * 60}&limit=60");
    // Logger().e(response.data);
    data = response.data["results"];
    final pokemonsDetailsPromises =
        data.map((pokemons) async => fetchPokemon(pokemons["url"]));
    final pokemonsDetails = await Future.wait(pokemonsDetailsPromises);
    pokemons = [...pokemons, ...pokemonsDetails];
    nextPage++;
    loading = false;
    return pokemons;
  }

  Future<List> getPokemonsData() async {
    final dataBase = db;
    final response = dataBase.selectAllFavoritePokemons();
    return response;
  }

  Future<bool> loadMoreItems() async {
    loading = true;
    final result = await getPokedexApi();
    print(result);
    if (result.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<Map<String, dynamic>> fetchPokemon(url) async {
    try {
      final response = await _dio.get("${url.toString()}");
      PokemonsModel dataPokemons = PokemonsModel(
          name: response.data["name"].toString(),
          image: response.data["sprites"]["front_default"].toString(),
          type: response.data["types"][0]["type"]["name"].toString(),
          isFavorite: 1);

      return dataPokemons.toMap();
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> saveFavoritePokemons(PokemonsModel data) async {
    final dataBase = db;
    final result = dataBase.insertFavoritePokemons(data);
    return result;
  }

  Future<bool> deleteFavoritePokemons(int id) async {
    final dataBase = db;
    final result = dataBase.deleteFavoritePokemons(id);
    return result;
  }
}

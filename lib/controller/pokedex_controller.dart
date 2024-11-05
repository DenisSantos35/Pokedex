import 'package:flutter/material.dart';
import 'package:flutter_application_pokedex/model/pokemons_model.dart';
import 'package:flutter_application_pokedex/provider/pokedex_api.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:sqflite/sqflite.dart';

import '../db/poke_data_base.dart';

class PokedexController extends GetxController {
  final api = PokedexApi();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    api.getPokedexApi();
  }

  loadMoreItems() {
    Future<bool> result = api.loadMoreItems();
    return result;
  }

  Map<String, dynamic> dataPokemons(PokemonsModel pokemos) {
    return pokemos.toMap();
  }

  Future<bool> saveFavoritePokemons(PokemonsModel data) async {
    bool result = await api.saveFavoritePokemons(data);
    return result;
  }

  Future<bool> deleteFavoritePokemons(int id) async {
    bool result = await api.deleteFavoritePokemons(id);
    return result;
  }
}

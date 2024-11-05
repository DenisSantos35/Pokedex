import 'package:flutter/material.dart';
import 'package:flutter_application_pokedex/controller/pokedex_controller.dart';
import 'package:flutter_application_pokedex/helper/dialog_helper.dart';
import 'package:flutter_application_pokedex/model/pokemons_model.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';

import 'home_page.dart';

class FavoritePokemonsPage extends StatefulWidget {
  PokedexController controller;

  FavoritePokemonsPage({super.key, required this.controller});

  @override
  State<FavoritePokemonsPage> createState() => _FavoritePokemonsPageState();
}

class _FavoritePokemonsPageState extends State<FavoritePokemonsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "MEUS POKEMONS!",
          style: TextStyle(
              color: Colors.black,
              fontFamily: "Times New Roman",
              fontWeight: FontWeight.w700),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/ceu.jpg'), // Caminho da sua imagem
              fit: BoxFit.fill, // Ajusta a imagem ao tamanho da AppBar
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.all(0),
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/grama.jpg'),
              fit: BoxFit.fill,
            ),
          ),
          height: 100.0,
        ),
      ),
      body: Container(
          color: Colors.white,
          child: Stack(children: [
            Image.asset(
              'assets/pokemons_favoritos.webp',
              height: Get.height,
              fit: BoxFit.fill,
            ),
            FutureBuilder(
                future: widget.controller.api.getPokemonsData(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return snapshot.data!.length == 0
                        ? Center(
                            child: Padding(
                            padding: EdgeInsets.only(left: 16, right: 16),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Text(
                                  "Não há pokemons favoritos!".toUpperCase(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 30,
                                  ),
                                  textAlign: TextAlign.center),
                            ),
                          ))
                        : GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            itemCount: snapshot.data!.length ?? 0,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () async {
                                  final id = snapshot.data![index]["id"];
                                  final name = snapshot.data![index]["name"];
                                  final image = snapshot.data![index]["image"];
                                  final type = snapshot.data![index]["type"];
                                  final resultDialog =
                                      await DialogsHelper.deleteFavoriteDialog(
                                          item: name);
                                  Logger().e(resultDialog);
                                  if (resultDialog) {
                                    Logger().e(id);
                                    final result = await widget.controller
                                        .deleteFavoritePokemons(id);
                                    if (result) {
                                      DialogsHelper.sucessSave(
                                          saveOrDelete: "Deletado",
                                          page: "Pokedex");
                                      Get.offAll(HomePage());
                                    }
                                  } else {
                                    return;
                                  }
                                },
                                child: Card(
                                    color: Colors.white.withOpacity(0.8),
                                    child: Column(
                                      children: [
                                        Image.network(
                                            "${snapshot.data![index]["image"]}"),
                                        Text(
                                            "Nome: ${snapshot.data![index]["name"]}"),
                                        Text(
                                            "Tipo: ${snapshot.data![index]["type"]}"),
                                      ],
                                    )),
                              );
                            });
                  }
                }),
          ])),
    );
  }
}

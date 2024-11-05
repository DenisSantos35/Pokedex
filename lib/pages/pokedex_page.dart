import 'package:flutter/material.dart';
import 'package:flutter_application_pokedex/controller/pokedex_controller.dart';
import 'package:flutter_application_pokedex/helper/dialog_helper.dart';
import 'package:flutter_application_pokedex/model/pokemons_model.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';

class PokedexPage extends StatefulWidget {
  PokedexController controller;

  PokedexPage({super.key, required this.controller});

  @override
  State<PokedexPage> createState() => _PokedexPageState();
}

class _PokedexPageState extends State<PokedexPage> {
  late Future<List> pokemons;
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pokemons = getPokemons();
  }

  Future<List> getPokemons() async {
    return await widget.controller.api.getPokedexApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "POKEDEX",
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          setState(() {
            loading = true;
            Logger().e(loading);
            pokemons = getPokemons();
          });
          await Future.delayed(Duration(seconds: 2));
          setState(() {
            loading = false;
          });
          Logger().e(loading);
        },
        child: loading
            ? Image.asset(
                'assets/pokebola.gif',
                height: 40,
                fit: BoxFit.fill,
              )
            : const Icon(Icons.add),
      ),
      body: Container(
          color: Colors.white,
          child: Stack(children: [
            Image.asset(
              'assets/poke_open.gif',
              height: Get.height,
              fit: BoxFit.fill,
            ),
            FutureBuilder(
                future: pokemons,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                        child: CircularProgressIndicator(
                      color: Colors.white,
                    ));
                  } else {
                    return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        itemCount: snapshot.data!.length ?? 0,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () async {
                              final name = snapshot.data![index]["name"];
                              final image = snapshot.data![index]["image"];
                              final type = snapshot.data![index]["type"];
                              final resultDialog =
                                  await DialogsHelper.addFavoriteDialog(
                                      item: name);
                              Logger().e(resultDialog);
                              if (resultDialog) {
                                final result = await widget.controller
                                    .saveFavoritePokemons(PokemonsModel(
                                        name: name,
                                        image: image,
                                        type: type,
                                        isFavorite: 1));
                                if (result) {
                                  DialogsHelper.sucessSave(
                                      saveOrDelete: "Salvo", page: "Favoritos");
                                } else {
                                  DialogsHelper.errorSave(item: name);
                                }
                              } else {
                                DialogsHelper.errorSave(item: name);
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

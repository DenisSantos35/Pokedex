import 'package:flutter/material.dart';
import 'package:flutter_application_pokedex/pages/pokedex_page.dart';
import 'package:get/get.dart';

import '../controller/pokedex_controller.dart';
import 'favorite_pokemons_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "POKEDEX",
          style: TextStyle(
              color: Colors.white,
              fontFamily: "Times New Roman",
              fontWeight: FontWeight.w700),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image:
                  AssetImage('assets/ceu_noite.jpg'), // Caminho da sua imagem
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
              image: AssetImage('assets/grama_noite2.jpg'),
              fit: BoxFit.fill,
            ),
          ),
          height: 100.0,
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset(
              'assets/pokemons.gif',
              height: Get.height,
              fit: BoxFit.cover,
            ),
            Container(
              height: Get.height,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.6),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 50, left: 90, right: 90),
                    child: InkWell(
                      onTap: () {
                        Get.lazyPut(() => PokedexController());
                        Get.to(PokedexPage(controller: PokedexController()));
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.white, // Cor da borda
                            width: 2.0,
                            // Largura da borda
                          ),
                        ),
                        child: Image.asset(
                          'assets/pokedex_img.png',
                          height: Get.height,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    "Ver Pokedex",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "Times New Roman",
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontSize: 20),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 50, left: 90, right: 90),
                    child: InkWell(
                      onTap: () {
                        Get.lazyPut(() => PokedexController());
                        Get.to(FavoritePokemonsPage(
                            controller: PokedexController()));
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.white, // Cor da borda
                            width: 2.0,
                            // Largura da borda
                          ),
                        ),
                        child: Image.asset(
                          'assets/pokemon_img_button.png',
                          height: Get.height,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    "Ver Pokemons \nFavoritos",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "Times New Roman",
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        fontSize: 20),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

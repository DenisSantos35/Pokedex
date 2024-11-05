import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogsHelper {
  static Future addFavoriteDialog({required String item}) {
    return Get.defaultDialog(
      radius: 8,
      title: "Adicionar aos Favoritos",
      middleText: "Você deseja adicionar ${item.toUpperCase()} aos favoritos?",
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: 150,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                ),
                onPressed: () => Get.back(result: false),
                child: const Text(
                  "NÃO",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 150,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                ),
                onPressed: () => Get.back(result: true),
                child: const Text(
                  "SIM",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  static Future deleteFavoriteDialog({required String item}) {
    return Get.defaultDialog(
        title: "Deletar Pokemon dos Favoritos",
        middleText: "Você deseja deletar ${item.toUpperCase()} dos favoritos?",
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 150,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  onPressed: () => Get.back(result: false),
                  child: const Text(
                    "NÃO",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 150,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  onPressed: () => Get.back(result: true),
                  child: const Text(
                    "SIM",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          )
        ]);
  }

  //TODO: FAZER ERRO E SUCESSO AO SALVAR DADOS.
  static Future sucessSave(
      {required String saveOrDelete, required String page}) async {
    return Get.showSnackbar(GetSnackBar(
      titleText: Text(
        "Pokemon favorito $saveOrDelete com sucesso.",
        style: const TextStyle(color: Colors.white),
      ),
      messageText: Text(
        "Vá em $page para viusalizar seu pokemons!",
        style: const TextStyle(color: Colors.white),
      ),
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.green,
    ));
  }

  static Future errorSave({required String item}) async {
    return Get.showSnackbar(GetSnackBar(
      titleText: const Text(
        "Erro ao salvar Pokemon .",
        style: TextStyle(color: Colors.white),
      ),
      messageText: Text(
        "O ${item.toUpperCase()} já esta nos favoritos!",
        style: const TextStyle(color: Colors.white),
      ),
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.red,
    ));
  }
}

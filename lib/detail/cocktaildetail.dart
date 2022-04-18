import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_workout/constant.dart';
import 'package:flutter_workout/model/drink.dart';
import 'package:http/http.dart' as http;

class CocktailDetailScreen extends StatefulWidget {
  final String drinkId;

  const CocktailDetailScreen({Key? key, required this.drinkId})
      : super(key: key);

  @override
  _CocktailDetailState createState() => _CocktailDetailState(drinkId);
}

class MyScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class _CocktailDetailState extends State<CocktailDetailScreen> {
  String drinkId;
  List<String> ingredients = [];
  late Drink drink;

  _CocktailDetailState(this.drinkId);

  Future<Drink> getDrinkDetail() async {
    final response =
        await http.get(Uri.parse(URL_FIND_BY_ID + drinkId.toString()));
    if (response.statusCode == 200) {
      var drinkResponse = json.decode(response.body)[DRINK_RESPONSE] as List;
      drink = Drink(
          drinkResponse.first["idDrink"],
          drinkResponse.first["strDrink"],
          drinkResponse.first["strCategory"],
          drinkResponse.first["strAlcoholic"],
          drinkResponse.first["strGlass"],
          drinkResponse.first["strInstructions"],
          drinkResponse.first["strDrinkThumb"],
          drinkResponse.first["strIngredient1"],
          drinkResponse.first["strIngredient2"],
          drinkResponse.first["strIngredient3"],
          drinkResponse.first["strIngredient4"],
          drinkResponse.first["strIngredient5"],
          drinkResponse.first["strIngredient6"],
          drinkResponse.first["strIngredient7"],
          drinkResponse.first["strIngredient8"],
          drinkResponse.first["strIngredient9"],
          drinkResponse.first["strIngredient10"],
          drinkResponse.first["strIngredient11"],
          drinkResponse.first["strIngredient12"],
          drinkResponse.first["strIngredient13"],
          drinkResponse.first["strIngredient14"],
          drinkResponse.first["strIngredient15"]);

      getListIngredient();
    } else {
      throw Exception(ERROR_CANNOT_FETCH_DATA);
    }
    return drink;
  }

  void getListIngredient() {
    ingredients = [];
    ingredients.add(drink.ingredient1 ?? "");
    ingredients.add(drink.ingredient2 ?? "");
    ingredients.add(drink.ingredient3 ?? "");
    ingredients.add(drink.ingredient4 ?? "");
    ingredients.add(drink.ingredient5 ?? "");
    ingredients.add(drink.ingredient6 ?? "");
    ingredients.add(drink.ingredient7 ?? "");
    ingredients.add(drink.ingredient8 ?? "");
    ingredients.add(drink.ingredient9 ?? "");
    ingredients.add(drink.ingredient10 ?? "");
    ingredients.add(drink.ingredient11 ?? "");
    ingredients.add(drink.ingredient12 ?? "");
    ingredients.add(drink.ingredient13 ?? "");
    ingredients.add(drink.ingredient14 ?? "");
    ingredients.add(drink.ingredient15 ?? "");
    ingredients.removeWhere((element) => element == "");
  }

  @override
  void initState() {
    getDrinkDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: null,
        body: FutureBuilder<Drink>(
          future: getDrinkDetail(),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? ScrollConfiguration(
                    behavior: ScrollBehavior(),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20)),
                              child: CachedNetworkImage(
                                imageUrl: drink.thumb,
                                width: double.infinity,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Padding(
                                padding:
                                    const EdgeInsets.only(top: 25, left: 10),
                                child: GestureDetector(
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: DecoratedBox(
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.black
                                                    .withOpacity(0.3))),
                                      ),
                                      const Image(
                                        image: AssetImage(
                                            "assets/images/img_back.png"),
                                        width: 25,
                                        height: 25,
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ))
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, top: 20),
                            child: Text(
                              drink.name,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 23),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, top: 10),
                            child: Text(
                              "${drink.category} - ${drink.alcoholic} - ${drink.glass}",
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 16),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 20, top: 10, right: 10),
                            child: Text(
                              drink.instruction ?? "",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 19,
                                  fontFamily: 'Trajan Pro'),
                            ),
                          ),
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(top: 20, left: 20),
                            child: Text(
                              INGREDIENT_LIST,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Expanded(
                            child: ListView.builder(
                              itemCount: ingredients.length,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.only(bottom: 10, left: 20),
                                  child: Text(ingredients[index],
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 19)),
                                );
                              },
                            ))
                      ],
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ));
  }
}

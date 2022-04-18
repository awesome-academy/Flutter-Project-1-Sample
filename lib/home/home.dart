import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_workout/category/filterCategory.dart';
import 'package:flutter_workout/detail/cocktaildetail.dart';
import 'package:http/http.dart' as http;

import '../constant.dart';
import '../model/drink.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class ScrollListBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class _HomeScreenState extends State<HomeScreen> {
  List<Drink> drinks = [];

  Future<List<Drink>> fetchDrinks() async {
    for (var i = 0; i < RANDOM_DRINK_NUMBER; i++) {
      final response = await http.get(Uri.parse(URL_RANDOM_DRINK));
      if (response.statusCode == 200) {
        var drinkResponse = json.decode(response.body)[DRINK_RESPONSE] as List;
        drinks.add(Drink(
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
            drinkResponse.first["strIngredient15"]));
      } else {
        throw Exception(ERROR_CANNOT_FETCH_DATA);
      }
    }
    return drinks;
  }

  late Future<List<Drink>> drinkFuture;

  @override
  void initState() {
    drinkFuture = fetchDrinks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: null,
      body: Column(
        children: [
          Stack(
            children: [
              const SizedBox(
                width: double.infinity,
                height: 250,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40))),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 100, left: 20),
                child: Text(
                  SOME_DRINK,
                  style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 160),
                child: FutureBuilder<List<Drink>>(
                    future: drinkFuture,
                    builder: (context, snapshot) {
                      return snapshot.hasData
                          ? ScrollConfiguration(
                              behavior: ScrollListBehavior(),
                              child: SizedBox(
                                height: 160,
                                child: ListView.builder(
                                    itemCount: drinks.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        child: Container(
                                          padding: const EdgeInsets.only(
                                              left: 20, right: 10),
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: <Widget>[
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: CachedNetworkImage(
                                                  fit: BoxFit.fill,
                                                  imageUrl: drinks[index].thumb,
                                                  width: 180,
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.bottomLeft,
                                                child: SizedBox(
                                                  width: 180,
                                                  height: 60,
                                                  child: DecoratedBox(
                                                      decoration: BoxDecoration(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                15)),
                                                    color: Colors.black
                                                        .withOpacity(0.6),
                                                  )),
                                                ),
                                              ),
                                              Positioned(
                                                  bottom: 12,
                                                  width: 180,
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        drinks[index].name,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 1,
                                                        style: const TextStyle(
                                                            fontSize: 16,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        drinks[index]
                                                                .alcoholic ??
                                                            "",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 1,
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.grey),
                                                      ),
                                                    ],
                                                  ))
                                            ],
                                          ),
                                        ),
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CocktailDetailScreen(
                                                          drinkId: drinks[index]
                                                              .id)));
                                        },
                                      );
                                    }),
                              ))
                          : const Center(child: CircularProgressIndicator());
                    }),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Padding(
                padding: EdgeInsets.only(left: 20, top: 40),
                child: Text(
                  CATEGORIES,
                  style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 20, top: 40),
                child: Text(
                  SEE_ALL,
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
            child: Row(
              children: [
                Expanded(
                    child: GestureDetector(
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Stack(
                              children: [
                                const ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  child: Image(
                                    image: AssetImage(
                                        "assets/images/img_original_drink.jpg"),
                                    width: 160,
                                    height: 110,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                SizedBox(
                                  width: 160,
                                  height: 110,
                                  child: DecoratedBox(
                                      decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15)),
                                    color: Colors.black.withOpacity(0.5),
                                  )),
                                ),
                                const Positioned.fill(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      ORDINARY_CATEGORY,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                          color: Colors.white),
                                    ),
                                  ),
                                )
                              ],
                            )),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const FilterCategoryScreen(
                                        categoryPath: ORDINARY_PATH,
                                      )));
                        })),
                Expanded(
                    child: GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        const ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          child: Image(
                            image: AssetImage("assets/images/img_cocktail.jpg"),
                            height: 110,
                            fit: BoxFit.fill,
                          ),
                        ),
                        SizedBox(
                          width: 160,
                          height: 110,
                          child: DecoratedBox(
                              decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            color: Colors.black.withOpacity(0.5),
                          )),
                        ),
                        const Positioned.fill(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              COCKTAIL_CATEGORY,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FilterCategoryScreen(
                                  categoryPath: COCKTAIL_PATH,
                                )));
                  },
                )),
                Expanded(
                    child: GestureDetector(
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          const ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            child: Image(
                              image: AssetImage("assets/images/img_cocoa.jpg"),
                              height: 110,
                              fit: BoxFit.fill,
                            ),
                          ),
                          SizedBox(
                            width: 160,
                            height: 110,
                            child: DecoratedBox(
                                decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
                              color: Colors.black.withOpacity(0.5),
                            )),
                          ),
                          const Positioned.fill(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                COCOA_CATEGORY,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      )),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FilterCategoryScreen(
                                  categoryPath: COCOA_PATH,
                                )));
                  },
                ))
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Padding(
                padding: EdgeInsets.only(top: 40, left: 20),
                child: Text(
                  INGREDIENTS,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 23,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 20, top: 40),
                child: Text(
                  SEE_ALL,
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              children: [
                Expanded(
                    child: Column(
                  children: const [
                    Image(
                      image: AssetImage("assets/images/img_vodka.png"),
                      height: 110,
                      fit: BoxFit.fill,
                    ),
                    Text(
                      VODKA,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    )
                  ],
                )),
                Expanded(
                    child: Column(
                  children: const [
                    Image(
                      image: AssetImage("assets/images/img_gin.jpg"),
                      height: 110,
                      fit: BoxFit.fill,
                    ),
                    Text(
                      GIN,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    )
                  ],
                )),
                Expanded(
                    child: Column(
                  children: const [
                    Image(
                      image: AssetImage("assets/images/img_tequila.png"),
                      height: 110,
                      fit: BoxFit.fill,
                    ),
                    Text(
                      TEQUILA,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    )
                  ],
                )),
                Expanded(
                    child: Column(
                  children: const [
                    Image(
                      image: AssetImage("assets/images/img_rum.jpg"),
                      height: 110,
                      fit: BoxFit.fill,
                    ),
                    Text(
                      RUM,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    )
                  ],
                ))
              ],
            ),
          )
        ],
      ),
    );
  }
}

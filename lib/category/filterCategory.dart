import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_workout/constant.dart';
import 'package:flutter_workout/detail/cocktaildetail.dart';
import 'package:flutter_workout/home/home.dart';
import 'package:flutter_workout/model/drinkFilter.dart';
import 'package:http/http.dart' as http;

class FilterCategoryScreen extends StatefulWidget {
  final String categoryPath;

  const FilterCategoryScreen({Key? key, required this.categoryPath})
      : super(key: key);

  @override
  _FilterCategoryScreenState createState() =>
      _FilterCategoryScreenState(this.categoryPath);
}

class _FilterCategoryScreenState extends State<FilterCategoryScreen> {
  final String categoryPath;
  List<DrinkFilter> drinks = [];

  _FilterCategoryScreenState(this.categoryPath);

  Future<List<DrinkFilter>> filterDrinks() async {
    final response =
        await http.get(Uri.parse(URL_FILTER_CATEGORY + categoryPath));
    if (response.statusCode == 200) {
      var drinksResponse = json.decode(response.body)[DRINK_RESPONSE] as List;
      for (int i = 0; i < drinksResponse.length; i++) {
        drinks.add(DrinkFilter(drinksResponse[i]['idDrink'],
            drinksResponse[i]['strDrink'], drinksResponse[i]['strDrinkThumb']));
      }
    } else {
      throw Exception(ERROR_CANNOT_FETCH_DATA);
    }
    return drinks;
  }

  @override
  void initState() {
    filterDrinks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: Align(
            alignment: Alignment.center,
            child: Text(
              categoryPath.replaceAll("_", " "),
              style: const TextStyle(fontSize: 23),
            ),
          )),
      body: Padding(
          padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
          child: FutureBuilder<List<DrinkFilter>>(
            future: filterDrinks(),
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? ScrollConfiguration(
                      behavior: ScrollListBehavior(),
                      child: ListView.builder(
                        itemCount: drinks.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: GestureDetector(
                              child: SizedBox(
                                  width: double.infinity,
                                  child: Card(
                                      elevation: 2,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: CachedNetworkImage(
                                                  imageUrl: drinks[index].thumb,
                                                  width: 80,
                                                  height: 80,
                                                ),
                                              )),
                                          Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15, right: 15),
                                                child: Text(
                                                  drinks[index].name,
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 17),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ))),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CocktailDetailScreen(
                                                drinkId: drinks[index].id)));
                              },
                            ),
                          );
                        },
                      ),
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    );
            },
          )),
    );
  }
}

class DrinkFilter {
  final String id;
  final String name;
  final String thumb;

  DrinkFilter(this.id, this.name, this.thumb);

  factory DrinkFilter.fromJson(dynamic json) {
    return DrinkFilter(
        json["idDrink"], json["strDrink"], json["strDrinkThumb"]);
  }
}

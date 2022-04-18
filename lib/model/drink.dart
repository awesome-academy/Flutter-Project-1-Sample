class Drink {
  final String id;
  final String name;
  final String? category;
  final String? alcoholic;
  final String? glass;
  final String? instruction;
  final String thumb;
  final String? ingredient1;
  final String? ingredient2;
  final String? ingredient3;
  final String? ingredient4;
  final String? ingredient5;
  final String? ingredient6;
  final String? ingredient7;
  final String? ingredient8;
  final String? ingredient9;
  final String? ingredient10;
  final String? ingredient11;
  final String? ingredient12;
  final String? ingredient13;
  final String? ingredient14;
  final String? ingredient15;

  Drink(
      this.id,
      this.name,
      this.category,
      this.alcoholic,
      this.glass,
      this.instruction,
      this.thumb,
      this.ingredient1,
      this.ingredient2,
      this.ingredient3,
      this.ingredient4,
      this.ingredient5,
      this.ingredient6,
      this.ingredient7,
      this.ingredient8,
      this.ingredient9,
      this.ingredient10,
      this.ingredient11,
      this.ingredient12,
      this.ingredient13,
      this.ingredient14,
      this.ingredient15);

  factory Drink.fromJson(dynamic json) {
    return Drink(
        json["idDrink"],
        json["strDrink"],
        json["strCategory"],
        json["strAlcoholic"],
        json["strGlass"],
        json["strInstructions"],
        json["strDrinkThumb"],
        json["strIngredient1"],
        json["strIngredient2"],
        json["strIngredient3"],
        json["strIngredient4"],
        json["strIngredient5"],
        json["strIngredient6"],
        json["strIngredient7"],
        json["strIngredient8"],
        json["strIngredient9"],
        json["strIngredient10"],
        json["strIngredient11"],
        json["strIngredient12"],
        json["strIngredient13"],
        json["strIngredient14"],
        json["strIngredient15"]);
  }
}

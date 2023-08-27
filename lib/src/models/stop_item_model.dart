import 'dart:convert';

class StopsItemModel {
  final String? type;
  final String id;
  final String? name;
  final Map<String, dynamic>? products;
  // define bool isFavorite
  bool isFavorite;

  StopsItemModel({
    this.type,
    required this.id,
    this.name,
    this.products,
    this.isFavorite = false,
  });

  factory StopsItemModel.fromRawJson(String str) =>
      StopsItemModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StopsItemModel.fromJson(Map<String, dynamic> json) => StopsItemModel(
        type: json["type"],
        id: json["id"],
        name: json["name"],
        products: json["products"] == null
            ? null
            : json["products"] as Map<String, dynamic>,


      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "id": id,
        "name": name,

      };
}



class Products {
  final bool? suburban;
  final bool? subway;
  final bool? tram;
  final bool? bus;
  final bool? ferry;
  final bool? express;
  final bool? regional;

  Products({
    this.suburban,
    this.subway,
    this.tram,
    this.bus,
    this.ferry,
    this.express,
    this.regional,
  });

  factory Products.fromRawJson(String str) =>
      Products.fromJson(json.decode(str));


  factory Products.fromJson(Map<String, dynamic> json) => Products(
        suburban: json["suburban"],
        subway: json["subway"],
        tram: json["tram"],
        bus: json["bus"],
        ferry: json["ferry"],
        express: json["express"],
        regional: json["regional"],
      );

  Map<String, dynamic> toJson() => {
        "suburban": suburban,
        "subway": subway,
        "tram": tram,
        "bus": bus,
        "ferry": ferry,
        "express": express,
        "regional": regional,
      };
}

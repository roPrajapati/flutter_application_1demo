// To parse this JSON data, do
//
//     final pokeModel = pokeModelFromJson(jsonString);

import 'dart:convert';

PokeModel pokeModelFromJson(String str) => PokeModel.fromJson(json.decode(str));

String pokeModelToJson(PokeModel data) => json.encode(data.toJson());

class PokeModel {
    Firmness firmness;
    List<Flavor> flavors;
    int growthTime;
    int id;
    Firmness item;
    int maxHarvest;
    String name;
    int naturalGiftPower;
    Firmness naturalGiftType;
    int size;
    int smoothness;
    int soilDryness;

    PokeModel({
        required this.firmness,
        required this.flavors,
        required this.growthTime,
        required this.id,
        required this.item,
        required this.maxHarvest,
        required this.name,
        required this.naturalGiftPower,
        required this.naturalGiftType,
        required this.size,
        required this.smoothness,
        required this.soilDryness,
    });

    PokeModel copyWith({
        Firmness? firmness,
        List<Flavor>? flavors,
        int? growthTime,
        int? id,
        Firmness? item,
        int? maxHarvest,
        String? name,
        int? naturalGiftPower,
        Firmness? naturalGiftType,
        int? size,
        int? smoothness,
        int? soilDryness,
    }) => 
        PokeModel(
            firmness: firmness ?? this.firmness,
            flavors: flavors ?? this.flavors,
            growthTime: growthTime ?? this.growthTime,
            id: id ?? this.id,
            item: item ?? this.item,
            maxHarvest: maxHarvest ?? this.maxHarvest,
            name: name ?? this.name,
            naturalGiftPower: naturalGiftPower ?? this.naturalGiftPower,
            naturalGiftType: naturalGiftType ?? this.naturalGiftType,
            size: size ?? this.size,
            smoothness: smoothness ?? this.smoothness,
            soilDryness: soilDryness ?? this.soilDryness,
        );

    factory PokeModel.fromJson(Map<String, dynamic> json) => PokeModel(
        firmness: Firmness.fromJson(json["firmness"]),
        flavors: List<Flavor>.from(json["flavors"].map((x) => Flavor.fromJson(x))),
        growthTime: json["growth_time"],
        id: json["id"],
        item: Firmness.fromJson(json["item"]),
        maxHarvest: json["max_harvest"],
        name: json["name"],
        naturalGiftPower: json["natural_gift_power"],
        naturalGiftType: Firmness.fromJson(json["natural_gift_type"]),
        size: json["size"],
        smoothness: json["smoothness"],
        soilDryness: json["soil_dryness"],
    );

    Map<String, dynamic> toJson() => {
        "firmness": firmness.toJson(),
        "flavors": List<dynamic>.from(flavors.map((x) => x.toJson())),
        "growth_time": growthTime,
        "id": id,
        "item": item.toJson(),
        "max_harvest": maxHarvest,
        "name": name,
        "natural_gift_power": naturalGiftPower,
        "natural_gift_type": naturalGiftType.toJson(),
        "size": size,
        "smoothness": smoothness,
        "soil_dryness": soilDryness,
    };
}

class Firmness {
    String name;
    String url;

    Firmness({
        required this.name,
        required this.url,
    });

    Firmness copyWith({
        String? name,
        String? url,
    }) => 
        Firmness(
            name: name ?? this.name,
            url: url ?? this.url,
        );

    factory Firmness.fromJson(Map<String, dynamic> json) => Firmness(
        name: json["name"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
    };
}

class Flavor {
    Firmness flavor;
    int potency;

    Flavor({
        required this.flavor,
        required this.potency,
    });

    Flavor copyWith({
        Firmness? flavor,
        int? potency,
    }) => 
        Flavor(
            flavor: flavor ?? this.flavor,
            potency: potency ?? this.potency,
        );

    factory Flavor.fromJson(Map<String, dynamic> json) => Flavor(
        flavor: Firmness.fromJson(json["flavor"]),
        potency: json["potency"],
    );

    Map<String, dynamic> toJson() => {
        "flavor": flavor.toJson(),
        "potency": potency,
    };
}

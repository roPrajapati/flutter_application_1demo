import 'dart:convert';
import 'dart:core';

import 'package:flutter_application_1demo/models/poke_model.dart';
import 'package:flutter_application_1demo/services/api_service.dart';


import 'package:dartz/dartz.dart';

class PokemoServices {
  Future<Either<String, List<Flavor>>> getListData() async {
    try {
     final response = await RESTService.performAPIRequest(
        httpUrl: "https://pokeapi.co/api/v2/berry/3/",
        apiType: APIType.GET,
      );

      final result = jsonDecode(response.body);

      var falovor = result['flavors'];
      var modelData = (falovor as List).map((e) => Flavor.fromJson(e)).toList();
      print("modelData==>>> ${modelData.length}");
      return right(modelData);
    } catch (ex) {
      print("Error: $ex");
      return left("some thing wrong");
    }
  }
}

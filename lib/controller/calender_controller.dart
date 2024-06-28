import 'dart:convert';


import 'package:flutter_application_1demo/models/poke_model.dart';
import 'package:flutter_application_1demo/utils/extensions.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

class CalenderController extends GetxController {
  late DateTime selectedMonth;

  DateTime? selectedDate;
  
   List<Flavor>? modelData;
  



  @override
  Future<void> onInit() async {
    super.onInit();
    selectedMonth = DateTime.now().monthStart;
    
    await fetchData();

    update();
  }

  void selectMonthDay(DateTime value) {
    selectedDate = value;
    
    update();
  }

  void selectMonth(DateTime value) {
    
    selectedMonth = value;
    update();
  }

 

  Future<void> fetchData() async {
    try {
      http.Response response = await http.get(Uri.tryParse(
          'https://pokeapi.co/api/v2/berry/3/')!);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        var falovor = result['flavors'];
       
      modelData =
          (falovor as List).map((e) => Flavor.fromJson(e)).toList();
          print("modelData==>>> ${modelData?.length}");
          
      }
    } catch (ex) {
      print("error:  $ex");
    }
    update();
  }
}

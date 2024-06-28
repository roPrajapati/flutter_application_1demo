import 'dart:convert';

import 'package:flutter_application_1demo/models/poke_model.dart';
import 'package:flutter_application_1demo/services/pokemo_services.dart';
import 'package:flutter_application_1demo/utils/extensions.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

class CalenderController extends GetxController {
  late DateTime selectedMonth;
  final isLoading = false.obs;


  DateTime? selectedDate;

  List<Flavor>? modelData;
  RxList<Flavor> listFlavor = <Flavor>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    selectedMonth = DateTime.now().monthStart;

    await fetchData();
    await fromRestServices();

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
       isLoading.value = true;
      http.Response response =
          await http.get(Uri.tryParse('https://pokeapi.co/api/v2/berry/3/')!);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        var falovor = result['flavors'];

        modelData = (falovor as List).map((e) => Flavor.fromJson(e)).toList();
       
      }
       isLoading.value = false;
    } catch (ex) {
      print("error:  $ex");
    }
    update();
  }

  Future<void> fromRestServices({bool isLoadingValue = true}) async {
    isLoading.value = isLoadingValue;
    final result = await PokemoServices().getListData();
    result.fold(
      (l) => l,
      (r) {
        listFlavor.value = r;
        
      },
    );
    isLoading.value = false;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_application_1demo/models/poke_model.dart';
import 'package:flutter_application_1demo/services/pokemo_services.dart';
import 'package:get/get.dart';

class PokeController extends GetxController{
  final isLoading = false.obs;
  RxList<Flavor> listFlavor = <Flavor>[].obs;
  var items = <Flavor>[].obs;

  final ScrollController scrollController = ScrollController();
  int limit = 10;
   int offset = 0;


  @override
  Future<void> onInit() async {
    super.onInit();
    await getDataPagination();
    scrollController.addListener(
      () async {
        if (scrollController.position.pixels == scrollController.position.maxScrollExtent && !isLoading.value) {
        await getDataPagination();
      }
        
      },
    );
  }

  Future<void> getDataPagination() async {
    isLoading.value = true;

    final result = await PokemoServices().getListPagination(limit: limit, offset: offset,);
    result.fold( (l) => l, (r) {
      listFlavor.value =r;
       if (listFlavor.isNotEmpty) {
        items.addAll(r);
        offset ++;
        update();
      }
    },);
    isLoading.value = false;
    update();
  }

}
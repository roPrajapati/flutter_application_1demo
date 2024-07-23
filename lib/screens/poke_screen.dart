import 'package:flutter/material.dart';
import 'package:flutter_application_1demo/controller/calender_controller.dart';
import 'package:flutter_application_1demo/screens/poke_pagination.dart';
import 'package:get/get.dart';

class PokeScreen extends StatelessWidget {
  const PokeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pagination API"),
        actions: [
          IconButton(onPressed: () {
            Get.to(() => PokePaginationScreen());
            
          }, icon: Icon(Icons.menu),)
        ],
      ),
      body: GetBuilder(
        init: CalenderController(),
        builder: (controller) => 
         ListView.builder(
           shrinkWrap: true,
           itemCount: controller.modelData?.length,
           itemBuilder:  (context, index) {
             return  ListTile(
               leading:  Image.network("https://commondatastorage.googleapis.com/codeskulptor-assets/lathrop/asteroid_blue.png"),
                title: Text(controller.modelData?[index].flavor.name ?? ''),
                subtitle: Text(controller.modelData?[index].flavor.url ?? ''),
             );
           },
         ),
      ),
    );
  }
}
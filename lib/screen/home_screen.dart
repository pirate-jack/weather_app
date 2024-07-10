import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:weather_app/contoller/global_contoller.dart';
import 'package:weather_app/widgets/header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalContoller globalContoller =
      Get.put(GlobalContoller(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      body: Obx(
        () => globalContoller.checkLoding().isTrue
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
          scrollDirection: Axis.vertical,
          children: [
            HeaderWidget(),
          ],
        )
      ),
    );
  }
}

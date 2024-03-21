import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../Controller/homescreen_controller.dart';
import 'favourite.dart';
import 'homecontent.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    HomeScreenController homeScreenController = Get.put(
      HomeScreenController(),
    );

    return Scaffold(
      body: Obx(
        () {
          switch (homeScreenController.currentIndex.value) {
            case 0:
              return const HomeContent();
            default:
              return const Favourite();
          }
        },
      ),
      bottomNavigationBar: Obx(
        () => SalomonBottomBar(
          curve: Curves.easeInCirc,
          margin: const EdgeInsets.all(15),
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.black12,
          currentIndex: homeScreenController.currentIndex.value,
          onTap: (index) {
            homeScreenController.updateIndex(index);
          },
          items: [
            SalomonBottomBarItem(
              title: const Text("Home"),
              icon: const Icon(CupertinoIcons.home),
              selectedColor: homeScreenController.isDark.value == false
                  ? Colors.white
                  : Colors.black,
            ),
            SalomonBottomBarItem(
                title: const Text("Favourite"),
                icon: const Icon(Icons.favorite),
                selectedColor: homeScreenController.isDark.value == false
                    ? Colors.white
                    : Colors.black),
          ],
        ),
      ),
    );
  }
}

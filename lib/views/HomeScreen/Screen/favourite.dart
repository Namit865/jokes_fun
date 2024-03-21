import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Splash Screen/splash Controller/splash_controller.dart';
import '../Controller/homescreen_controller.dart';

class Favourite extends StatefulWidget {
  const Favourite({super.key});

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  HomeScreenController controller = Get.find<HomeScreenController>();
  ControllerSplash spash = Get.find<ControllerSplash>();

  @override
  void initState() {
    super.initState();
    controller.favouriteQuotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            backgroundColor: Colors.red,
            title: Text(
              "Favourite",
              style: TextStyle(color: Colors.white),
            ),
            collapsedHeight: 100,
            toolbarHeight: 100,
            expandedHeight: 100,
            floating: true,
            snap: true,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final quotes = controller.favouriteQuotes[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  elevation: 10,
                  color: Colors.white,
                  child: ListTile(
                    onLongPress: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return removeAlertBox(
                              controller: controller, quote: quotes);
                        },
                      );
                    },
                    title: Text(
                      quotes['content'],
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      quotes['author'],
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                );
              },
              childCount: controller.favouriteQuotes.length,
            ),
          ),
        ],
      ),
    );
  }

  removeAlertBox(
      {required HomeScreenController controller,
      required Map<String, dynamic> quote}) {
    return IntrinsicHeight(
      child: AlertDialog(
        title: const Text("Remove Quote"),
        content: const Text("Do You Want to Remove this Quote ?"),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              controller.removeFromFavoriteQuotes(quote);
              setState(() {});
              Get.back();
            },
            child: const Text("Remove"),
          ),
        ],
      ),
    );
  }
}

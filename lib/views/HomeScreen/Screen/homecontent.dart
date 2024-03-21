// ignore_for_file: unrelated_type_equality_checks, duplicate_ignore
import 'dart:ui';

import 'package:flutter/rendering.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../Splash Screen/splash Controller/splash_controller.dart';
import '../Controller/homescreen_controller.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  late HomeScreenController controller;
  late ControllerSplash splash;

  @override
  void initState() {
    super.initState();
    controller = Get.find<HomeScreenController>();
    splash = Get.find<ControllerSplash>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Quotes",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
        ),
        actions: [
          Obx(
            () => InkWell(
              onTap: () {
                controller.dayNightChange();
              },
              child: controller.isDark.value
                  ? const Icon(Icons.light_mode_sharp)
                  : const Icon(Icons.dark_mode_rounded),
            ),
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.refresh),
        onPressed: () {
          splash.refreshQuotes();
        },
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Obx(
            () => GestureDetector(
              onDoubleTap: () {
                controller.toggleFavoriteQuote(
                  splash.Quotes.toJson(),
                );
              },
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          filterQuality: FilterQuality.high,
                          opacity: controller.isDark.value == true ? 1 : 0.5,
                          image: AssetImage(splash.currentPhoto['path']),
                          fit: BoxFit.cover),
                    ),
                    height: MediaQuery.of(context).size.height * 0.8,
                    width: MediaQuery.of(context).size.width,
                    child: splash.Quotes.isNotEmpty
                        ? SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(
                                  height: 50,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Obx(
                                    () => Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(20),
                                          width: 300,
                                          decoration: BoxDecoration(
                                            color: Colors.black54,
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          child: Column(
                                            children: [
                                              Text(
                                                splash.Quotes['content'],
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 30,
                                              ),
                                              RichText(
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: splash
                                                          .Quotes['author'],
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: controller
                                                                .isDark.value
                                                            ? Colors.black54
                                                            : Colors.white54,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                controller.toggleFavoriteQuote(
                                                    splash.Quotes.toJson());
                                              },
                                              icon: controller.isQuoteLiked(
                                                      splash.Quotes.toJson())
                                                  ? const Icon(Icons.favorite,
                                                      size: 35,
                                                      color: Colors.red)
                                                  : Icon(Icons.favorite_border,
                                                      size: 35,
                                                      color:
                                                          controller.isDark ==
                                                                  false
                                                              ? Colors.white
                                                              : Colors.black),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                controller.shareQuote();
                                              },
                                              icon: const Icon(
                                                CupertinoIcons.share,
                                                size: 35,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const Center(
                            child: CircularProgressIndicator(),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/drawerImage.avif"),
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
                opacity: 0.4,
              ),
            ),
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    "Quotes App",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "Find Some Of Your Best Quotes here",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.favorite_border),
            title: const Text(
              'My Favourite',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

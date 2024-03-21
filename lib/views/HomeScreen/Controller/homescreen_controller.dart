// ignore_for_file: unused_local_variable
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Splash Screen/splash Controller/splash_controller.dart';
import '../Screen/homecontent.dart';

class HomeScreenController extends GetxController {
  ControllerSplash splash = Get.find<ControllerSplash>();
  final RxList<Map<String, dynamic>> favouriteQuotes =
      <Map<String, dynamic>>[].obs;
  RxInt currentIndex = 0.obs;
  RxBool isDark = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadFavouriteQuotes();
  }

  void updateIndex(int index) {
    currentIndex.value = index;
  }

  void dayNightChange() async {
    await saveFavouriteQuotes();
    isDark.value = !isDark.value;
    Get.changeThemeMode(isDark.value ? ThemeMode.light : ThemeMode.dark);
  }

  void addToFavoriteQuotes(Map<String, dynamic> quote) {
    favouriteQuotes.add(quote);
    saveFavouriteQuotes();
  }

  void toggleFavoriteQuote(Map<String, dynamic> quote) {
    if (isQuoteLiked(quote)) {
      removeFromFavoriteQuotes(quote);
    } else {
      addToFavoriteQuotes(quote);
    }
  }

  void removeFromFavoriteQuotes(Map<String, dynamic> quote) async {
    favouriteQuotes.removeWhere((item) => item['content'] == quote['content']);
    await saveFavouriteQuotes();
  }

  loadFavouriteQuotes() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? JsonData = prefs.getString('favourite_quotes');
      if (JsonData != null) {
        final List<dynamic> jsonList = json.decode(JsonData);
        favouriteQuotes.assignAll(jsonList.cast<Map<String, dynamic>>());
      }
    } catch (e) {
      print(e);
    }
  }

  saveFavouriteQuotes() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String JsonData = json.encode(favouriteQuotes);
      await prefs.setString('favourite_quotes', JsonData);
    } catch (e) {
      print(e);
    }
  }

  isQuoteLiked(Map<String, dynamic> quote) {
    return favouriteQuotes.contains(quote);
  }

  shareQuote() {
    if (splash.Quotes.isNotEmpty) {
      final String quoteContent = splash.Quotes['content'];
      final String quoteAuthor = splash.Quotes['author'];
      final String quoteImage = splash.currentPhoto['path'];
      String quoteToShare = '$quoteContent - $quoteAuthor';
      Share.share(quoteToShare);
    } else {
      return null;
    }
  }
}

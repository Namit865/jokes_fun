// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:get/get.dart';

import '../../../Helper/api_helper.dart';
import '../../../utils/backGroundmages.dart';
import '../../HomeScreen/Screen/homescreen.dart';

class ControllerSplash extends GetxController {
  RxMap currentPhoto = {}.obs;
  RxMap Quotes = {}.obs;

  @override
  onInit() async {
    super.onInit();
    await fetchQuotes();
    await refreshQuotes();
    Timer(const Duration(seconds: 1), () {
      Get.offAll(() => const HomeScreen());
    });
  }

  Future<void> fetchQuotes() async {
    try {
      final data = await ApiService.fetchQuotes();
      Quotes.value = data;
    } catch (e) {
      return print('error fetching Quotes Api ===================== $e');
    }
  }

  Future<void> refreshQuotes() async {
    await fetchQuotes();
    changePhoto();
    update();
  }

  void changePhoto() async {
    List<Map<String, dynamic>> shuffledList = List.from(PhotoData.photos);
    shuffledList.shuffle();
    currentPhoto.value = shuffledList.first;
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingController extends GetxController{
  PageController controller = PageController();
  RxInt pageIndex = 0.obs;

  changeIndex(int i){
    pageIndex.value = i;
    update();
  }
}
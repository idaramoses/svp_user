import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PackageDetailController extends GetxController{
  TextEditingController searchController = TextEditingController();
  RxInt selectData = 0.obs;
  RxInt selected = 0.obs;
}
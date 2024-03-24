import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sharkhub/data/app_data.dart';
import 'package:sharkhub/view/home/model/categoires_model.dart';
import 'package:sharkhub/view/home/model/popular_model.dart';
import 'package:sharkhub/view/home/model/transactions_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/service_api.dart';
import '../../../main.dart';




class ReadMeterController extends GetxController {



@override
void onClose() {
  super.onClose();
  print("Controller closed");
  // Add your logic when the widget is removed from the widget tree
}

  RxList<Map<String, dynamic>> tableData = <Map<String, dynamic>>[].obs;
  var meterData = <Map<String, dynamic>>[].obs;
  final transaction = [].obs;
  final recenttransaction = [].obs;
  final meters = [].obs;
  RxBool isLoading = true.obs;
  ScrollController categoriesScrollController = ScrollController();
  @override
  void onInit() {
    super.onInit();
    fetchMeterData();
    print('testing -----------------------------------------------------------------------------');
  }

  Future<void> fetchData() async {
    try {
      isLoading(true);
      // Get the currently authenticated user
      // User? currentUser = supabase.auth.currentUser;
      // if (currentUser == null) {
      //   // No authenticated user, handle appropriately
      //   return;
      // }
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String id = '${prefs.getString('id')}';
      // Query the user table for data associated with the authenticated user
      final response = await supabase
          .from('transactions')
          .select()
          .eq('user_id', id)
          .order('created_at', ascending: false)
          .execute();
      // Update user data
      transaction.assignAll(response.data);
      isLoading(false);
    } catch (e) {
      // Handle errors
      print('Error fetching user data: $e');
      isLoading(false);
    }
  }
  Future<void> fetchrecentData() async {
    try {
      isLoading(true);
      // Get the currently authenticated user
      // User? currentUser = supabase.auth.currentUser;
      // if (currentUser == null) {
      //   // No authenticated user, handle appropriately
      //   return;
      // }
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String id = '${prefs.getString('id')}';
      // Query the user table for data associated with the authenticated user
      final response = await supabase
          .from('transactions')
          .select()
          .eq('user_id', id)
          .limit(4)
          .order('created_at', ascending: false)
          .execute();
      // Update user data
      recenttransaction.assignAll(response.data);
      isLoading(false);
    } catch (e) {
      // Handle errors
      print('Error fetching user data: $e');
      isLoading(false);
    }
  }

  Future<void> fetchMeterData() async {
    try {
      isLoading(true);
      // Get the currently authenticated user
      // User? currentUser = supabase.auth.currentUser;
      // if (currentUser == null) {
      //   // No authenticated user, handle appropriately
      //   return;
      // }
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String id = '${prefs.getString('id')}';
      // Query the user table for data associated with the authenticated user
      final response = await supabase
          .from('meters')
          .select()
          .eq('user_id', id)
          .order('created_at', ascending: false)
          .limit(4)
          .execute();
      // Update user data
      meters.assignAll(response.data);
      isLoading(false);
    } catch (e) {
      // Handle errors
      print('Error fetching user data: $e');
      isLoading(false);
    }
  }

  List<String> daysOfWeek = [
    'assets/svg/aedc.jpg',
    'assets/svg/eedc.png',
    'assets/svg/ekedc.png',
    'assets/svg/ibedc.png',
    'assets/svg/ikeja.png',
    'assets/svg/jedc.jpg',
  ];

  RxList<TransactionModel> transdetail = [
    TransactionModel(
      price: '1000',
      title: 'Ngolo Kante',
      des: '1200456445',
      image: 'assets/svg/aedc.jpg',
    ),
    TransactionModel(
      price: '2500',
      title: 'Messi Tunde',
      des: '9257625345',
      image: 'assets/svg/eedc.png',
    ),
    TransactionModel(
      price: '3000',
      title: 'Ibrahim Ronaldo',
      des: '8735728484',
      image: 'assets/svg/ibedc.png',
    ),
    TransactionModel(
      price: '12000',
      title: 'Mbappe Chibike',
      des: '934764563',
      image: 'assets/svg/aedc.jpg',
    ),
    TransactionModel(
      price: '5000',
      title: 'Chiwel Mike',
      des: '9273645473',
      image: 'assets/svg/ekedc.png',
    ),
  ].obs;
  CarouselController? carouselController = CarouselController();
  PageController pageController = PageController();
  RxInt i = 0.obs;

  List<CategoriesModel> categoriesList = categoriesDataList;
  List<TransactionModel> transactionList = transactionDataList;
  List<TransactionModel> recenttransactionList = transactionDataList;
  List<PopularTransModel> popularList = popularTransDataList;
}

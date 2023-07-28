import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../utils/services.dart';


class Messageservice with Services {

  Future<Map<String, dynamic>> getPMnotification() async {

    try {
      final response = await apiGetRequests("user/messages");
      return response;
    } catch (e) {
      print(e);
    }
    return {};
  }

}

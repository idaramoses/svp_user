import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../utils/services.dart';


class ReportService with Services {

  Future<Map<String, dynamic>> getPMProject() async {

    try {
      final response = await apiGetRequests("user/reports");
      return response;
    } catch (e) {
      print(e);
    }
    return {};
  }

}

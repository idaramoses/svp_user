import '../../models/new_users.dart';
import '../../models/project.dart';
import '../../utils/services.dart';
import 'package:http/http.dart' as http;


class TasksService with Services {
  Future<Map<String, dynamic>> getPosts() async {
    try {
      final response = await apiGetRequests("user/tasks");
      return response;
    } catch (e) {
      print(e);
    }
    return {};
  }
  Future<List<UserModel>> getUsers() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.usersEndpoint);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<UserModel> _model = userModelFromJson(response.body);
        return _model;
      }
    } catch (e) {
    }
  }
}

class ApiConstants {
  static String baseUrl = 'https://jsonplaceholder.typicode.com';
  static String usersEndpoint = '/users';
}
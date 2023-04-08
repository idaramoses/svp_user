import '../../utils/services.dart';

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
}

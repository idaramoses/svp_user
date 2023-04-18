import '../../../utils/services.dart';

class WaitlistService with PServices {
  Future<Map<String, dynamic>> Join_waitlist(
      Map<String, dynamic> credentials) async {
    try {
      // var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.usersEndpoint);
      // var response = await http.post(url);
      final response = await apiPostRequests("waitlist/new", credentials);
      return response;
    } catch (e) {
      print(e);
    }
    return {};
  }
}

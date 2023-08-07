import 'package:dio/dio.dart';

import '../../../utils/services.dart';

class SignInService with Services {
  Future<Map<String, dynamic>> signIn(Map<String, dynamic> credentials) async {
    try {
      final response = await apiPostRequests("auth/login", credentials);
      return response;
    } catch (e) {
      print(e);
    }
    return {};
  }

  Future<Map<String, dynamic>> delete(Map<String, dynamic> credentials) async {
    try {
      final response =
          await apiPostRequests("user/delete/account", credentials);
      return response;
    } catch (e) {
      print(e);
    }
    return {};
  }

  Future<Map<String, dynamic>> signup(Map<String, dynamic> credentials) async {
    try {
      final response = await apiPostRequests("auth/signup", credentials);
      return response;
    } catch (e) {
      print(e);
    }
    return {};
  }

  Future<Map<String, dynamic>> Reset(Map<String, dynamic> credentials) async {
    try {
      final response = await apiPostRequests("password/email", credentials);
      return response;
    } catch (e) {
      print(e);
    }
    return {};
  }

  Future<Map<String, dynamic>> pmprofiles() async {
    try {
      final response = await apiGetRequests("user/profile");
      return response;
    } catch (e) {
      print(e);
    }
    return {};
  }

  Future<Map<String, dynamic>> Password(
      Map<String, dynamic> credentials) async {
    try {
      final response = await apiPostRequests("change-password", credentials);
      return response;
    } catch (e) {
      print(e);
    }
    return {};
  }

  Future<Map<String, dynamic>> patchUserData(
      String id, Map<String, dynamic> credentials) async {
    try {
      final response = await apiPatchWithDataRequests("users/$id", credentials);
      return response;
    } catch (e) {
      print(e);
    }
    return {};
  }

  Future<Map<String, dynamic>> patchEditProfile(
      String id, FormData formdata) async {
    try {
      final response = await apiPatchWithFormdata("users/$id", formdata);
      return response;
    } catch (e) {
      print(e);
    }
    return {};
  }

  Future<Map<String, dynamic>> getPeerUser(String id) async {
    try {
      final response = await apiGetRequests("users/$id");
      return response;
    } catch (e) {
      print(e);
    }
    return {};
  }
}

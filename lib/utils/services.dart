import 'dart:convert' as convert;

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:svp_admin_pm/utils/nav_service.dart';

import 'app_local_storage.dart';

mixin Services {
  static final Map<String, String> _requestHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application.json'
  };

  static final options = BaseOptions(
    // baseUrl: "https://api.alumates.com/",
    baseUrl: "https://svp.hypen.blog/",
    headers: _requestHeaders,
    connectTimeout: 50000,
    receiveTimeout: 50000,
  );

  Dio dio = Dio(options)
    ..interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
    ));

  Dio dioCache = Dio(options)
    ..interceptors.add(DioCacheManager(CacheConfig(
      baseUrl: "https://svp.hypen.blog/",
    )).interceptor);

  Future<Map<String, dynamic>> apiPostRequests(
      String endpoint, Map<String, dynamic> credentials) async {
    try {
      Response response = await dio.post(
        endpoint,
        data: credentials,
        options:
            Options(headers: {"Authorization": "Bearer ${await getToken()}"}),
      );
      return responseNormalizer(response);
    } on DioError catch (e) {
      return _catchError(e);
    }
  }

  Future<dynamic> newapiPostRequest(String endpoint) async {
    try {
      Response response = await dio.post(
        endpoint,
        options:
            Options(headers: {"Authorization": "Bearer " + await getToken()}),
      );
      return responseNormalizer(response);
    } on DioError catch (e) {
      return _catchError(e);
    }
  }

  Future<Map<String, dynamic>> newapiPostRequests(
      String endpoint, Map<String, dynamic> credentials) async {
    try {
      Response response = await dio.post(
        endpoint,
        options:
            Options(headers: {"Authorization": "Bearer ${await getToken()}"}),
      );
      return responseNormalizer(response);
    } on DioError catch (e) {
      return _catchError(e);
    }
  }

  Future<Map<String, dynamic>> apiGetWithTokenRequests(
      String endpoint, String token) async {
    try {
      Response response = await dio.get(
        endpoint,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      return responseNormalizer(response);
    } on DioError catch (e) {
      return _catchError(e);
    }
  }

  Future<Map<String, dynamic>> apiPostWithTokenRequests(
      String endpoint, Map<String, dynamic> credentials, String token) async {
    try {
      Response response = await dio.post(
        endpoint,
        data: credentials,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      return responseNormalizer(response);
    } on DioError catch (e) {
      return _catchError(e);
    }
  }

  Future<Map<String, dynamic>> apiPostWithoutDataRequests(
      String endpoint) async {
    try {
      Response response = await dio.post(
        endpoint,
        options:
            Options(headers: {"Authorization": "Bearer ${await getToken()}"}),
      );
      return responseNormalizer(response);
    } on DioError catch (e) {
      return _catchError(e);
    }
  }

  Future<Map<String, dynamic>> apiUploadPostRequests(
      String endPoint, Map<String, dynamic> credentials) async {
    try {
      final response = await dio.post(endPoint,
          data: credentials,
          options: Options(headers: {
            "Authorization": "Bearer ${await getToken()}",
            "Content-Type": "multipart/form-data"
          }));
      return convert.json.decode(response.toString());
    } on DioError catch (e) {
      return _catchError(e);
    }
  }

  Future<dynamic> apiGetRequests(String endpoint) async {
    try {
      Response response = await dio.get(
        endpoint,
        options:
            Options(headers: {"Authorization": "Bearer " + await getToken()}),
      );
      return responseNormalizer(response);
    } on DioError catch (e) {
      return _catchError(e);
    }
  }

  Future<dynamic> apiGetRequestsWithFullUrl(String url) async {
    try {
      Response response = await Dio().get(
        url,
        options:
            Options(headers: {"Authorization": "Bearer " + await getToken()}),
      );
      return responseNormalizer(response);
    } on DioError catch (e) {
      return _catchError(e);
    }
  }

  Future<dynamic> apiGetCacheRequests(String endpoint) async {
    try {
      Response response = await dioCache.get(endpoint,
          options: buildCacheOptions(
            Duration(hours: 1),
            forceRefresh: true,
            options: Options(
                headers: {"Authorization": "Bearer " + await getToken()}),
          ));
      return responseNormalizer(response);
    } on DioError catch (e) {
      return _catchError(e);
    }
  }

  Future<dynamic> apiGetLongCacheRequests(String endpoint) async {
    try {
      Response response = await dioCache.get(endpoint,
          options: buildCacheOptions(
            Duration(days: 7),
            options: Options(
                headers: {"Authorization": "Bearer " + await getToken()}),
          ));
      return responseNormalizer(response);
    } on DioError catch (e) {
      return _catchError(e);
    }
  }

  Future<Map<String, dynamic>> apiDeleteRequests(String endPoint) async {
    try {
      Response response = await dio.delete(endPoint,
          options: Options(
              headers: {"Authorization": "Bearer " + await getToken()}));
      return responseNormalizer(response);
    } on DioError catch (e) {
      return _catchError(e);
    }
  }

  Future<dynamic> apiDeleteRequestsWithFullResponse(String endPoint) async {
    try {
      return await dio.delete(endPoint,
          options: Options(
              headers: {"Authorization": "Bearer " + await getToken()}));
    } on DioError catch (e) {
      return _catchError(e);
    }
  }

  Future<Map<String, dynamic>> apiPatchRequests(String endPoint) async {
    try {
      final response = await dio.patch(endPoint,
          options: Options(
              headers: {"Authorization": "Bearer " + await getToken()}));
      return responseNormalizer(response);
    } on DioError catch (e) {
      return _catchError(e);
    }
  }

  Future<Map<String, dynamic>> apiPatchWithDataRequests(
      String endPoint, Map<String, dynamic> credentials) async {
    try {
      final response = await dio.patch(endPoint,
          data: credentials,
          options: Options(
              headers: {"Authorization": "Bearer " + await getToken()}));
      return responseNormalizer(response);
    } on DioError catch (e) {
      return _catchError(e);
    }
  }

  Future<Map<String, dynamic>> apiPutRequests(
      String endPoint, Map<String, dynamic> credentials) async {
    try {
      final response = await dio.put(endPoint,
          data: credentials,
          options: Options(
              headers: {"Authorization": "Bearer " + await getToken()}));
      return responseNormalizer(response);
    } on DioError catch (e) {
      print(e);
      return _catchError(e);
    }
  }

  Future<Map<String, dynamic>> apiUploadPutRequests(
      String endPoint, FormData credentials) async {
    try {
      // print(credentials.files);
      final response = await dio.post(endPoint,
          data: credentials,
          options: Options(
              headers: {"Authorization": "Bearer " + await getToken()}));
      return responseNormalizer(response);
    } on DioError catch (e) {
      print(e);
      return _catchError(e);
    }
  }

  Future<Map<String, dynamic>> apiPatchRequestsWithCredentials(
      String endPoint, Map<String, dynamic> credentials) async {
    try {
      final response = await dio.patch(endPoint,
          data: credentials,
          options: Options(
              headers: {"Authorization": "Bearer " + await getToken()}));
      return responseNormalizer(response);
    } on DioError catch (e) {
      return _catchError(e);
    }
  }

  Future<Map<String, dynamic>> apiImageUpload(
      String endPoint, FormData formdata) async {
    try {
      final response = await dio.post(endPoint,
          data: formdata,
          options: Options(
              headers: {"Authorization": "Bearer " + await getToken()}));
      //
      return responseNormalizer(response);
    } on DioError catch (e) {
      return _catchError(e);
    }
  }

  Future<Map<String, dynamic>> apiPatchWithFormdata(
      String endPoint, FormData formdata) async {
    try {
      final response = await dio.post(endPoint,
          queryParameters: {"_method": "PATCH"},
          data: (formdata),
          options: Options(headers: {
            "Authorization": "Bearer " + await getToken(),
          }));

      return responseNormalizer(response);
    } on DioError catch (e) {
      return _catchError(e);
    }
  }

  // Future<Map<String, dynamic>> apiPatchWithMultiPart(
  //   String endPoint,
  //   File file,
  //   Map<String,dynamic> credentials,
  //   String fileField,
  // ) async {
  //   try {
  //     Uri uri = Uri.https(
  //         "www.api.alumates.com", "/api/v1/$endPoint", {"_method": "PATCH"});
  //     http.MultipartRequest request = http.MultipartRequest("POST", uri);
  //     request.headers.addAll({
  //       "Authorization": "Bearer " + await getToken(),
  //       'Content-Type': 'multipart/form-data',
  //       'Accept': 'application.json',
  //     });
  //     request.fields["name"] = "COMMAND SEC SCHOOL";
  //     request.files.add(await http.MultipartFile.fromPath(fileField, file.path));
  //     http.Response response =
  //         await http.Response.fromStream(await request.send());
  //     print(convert.jsonDecode(response.body));
  //     return _httpResponseNormalizer(response);
  //
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  _catchError(dynamic e) {
    if (e.response != null) {
      if (e.response.data["message"]
          .toString()
          .toLowerCase()
          .contains("unauthenticated")) {
        GetIt locator = GetIt.instance;
        final NavigationService _navigationService =
            locator<NavigationService>();
        _navigationService.logOut();
      }
      print(e.response.data);
      print(e.response.headers);
      print(e.response.request);

      return e.response.data;
    } else {
      print(e.request);
      print(e.message);

      return {};
    }
  }

  getToken() async {
    String token = await AppLocalStorage().fetch("token");
    if (token != null) return token;
    return "";
  }

  static responseNormalizer(Response res) {
    if (res.statusCode == 200)
      return {"status": "success", "body": res.data};
    else
      return {"status": "error", "body": res.data};
  }

  _httpResponseNormalizer(http.Response res) {
    if (res.statusCode == 200)
      return {"status": "success", "body": res.body};
    else
      return {"status": "error", "body": res.body};
  }
}

mixin PServices {
  static final Map<String, String> _requestHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application.json'
  };

  static final optionss = BaseOptions(
    // baseUrl: "https://api.alumates.com/",
    baseUrl: "https://api.saharaviewpoint.com/",
    headers: _requestHeaders,
    connectTimeout: 50000,
    receiveTimeout: 50000,
  );
  static final options = BaseOptions(
    // baseUrl: "https://api.alumates.com/",
    baseUrl: "https://svp.hypen.blog/",
    headers: _requestHeaders,
    connectTimeout: 50000,
    receiveTimeout: 50000,
  );

  Dio dio = Dio(options)
    ..interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
    ));

  Dio dioCache = Dio(options)
    ..interceptors.add(DioCacheManager(CacheConfig(
      baseUrl: "https://svp.hypen.blog/",
    )).interceptor);

  Future<Map<String, dynamic>> apiPostRequests(
      String endpoint, Map<String, dynamic> credentials) async {
    try {
      Response response = await dio.post(
        endpoint,
        data: credentials,
        options:
            Options(headers: {"Authorization": "Bearer ${await getToken()}"}),
      );
      return responseNormalizer(response);
    } on DioError catch (e) {
      return _catchError(e);
    }
  }

  Future<dynamic> newapiPostRequest(String endpoint) async {
    try {
      Response response = await dio.post(
        endpoint,
        options:
            Options(headers: {"Authorization": "Bearer " + await getToken()}),
      );
      return responseNormalizer(response);
    } on DioError catch (e) {
      return _catchError(e);
    }
  }

  Future<Map<String, dynamic>> newapiPostRequests(
      String endpoint, Map<String, dynamic> credentials) async {
    try {
      Response response = await dio.post(
        endpoint,
        options:
            Options(headers: {"Authorization": "Bearer ${await getToken()}"}),
      );
      return responseNormalizer(response);
    } on DioError catch (e) {
      return _catchError(e);
    }
  }

  Future<Map<String, dynamic>> apiGetWithTokenRequests(
      String endpoint, String token) async {
    try {
      Response response = await dio.get(
        endpoint,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      return responseNormalizer(response);
    } on DioError catch (e) {
      return _catchError(e);
    }
  }

  Future<Map<String, dynamic>> apiPostWithTokenRequests(
      String endpoint, Map<String, dynamic> credentials, String token) async {
    try {
      Response response = await dio.post(
        endpoint,
        data: credentials,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      return responseNormalizer(response);
    } on DioError catch (e) {
      return _catchError(e);
    }
  }

  Future<Map<String, dynamic>> apiPostWithoutDataRequests(
      String endpoint) async {
    try {
      Response response = await dio.post(
        endpoint,
        options:
            Options(headers: {"Authorization": "Bearer ${await getToken()}"}),
      );
      return responseNormalizer(response);
    } on DioError catch (e) {
      return _catchError(e);
    }
  }

  Future<Map<String, dynamic>> apiUploadPostRequests(
      String endPoint, Map<String, dynamic> credentials) async {
    try {
      final response = await dio.post(endPoint,
          data: credentials,
          options: Options(headers: {
            "Authorization": "Bearer ${await getToken()}",
            "Content-Type": "multipart/form-data"
          }));
      return convert.json.decode(response.toString());
    } on DioError catch (e) {
      return _catchError(e);
    }
  }

  Future<dynamic> apiGetRequests(String endpoint) async {
    try {
      Response response = await dio.get(
        endpoint,
        options:
            Options(headers: {"Authorization": "Bearer " + await getToken()}),
      );
      return responseNormalizer(response);
    } on DioError catch (e) {
      return _catchError(e);
    }
  }

  Future<dynamic> apiGetRequestsWithFullUrl(String url) async {
    try {
      Response response = await Dio().get(
        url,
        options:
            Options(headers: {"Authorization": "Bearer " + await getToken()}),
      );
      return responseNormalizer(response);
    } on DioError catch (e) {
      return _catchError(e);
    }
  }

  Future<dynamic> apiGetCacheRequests(String endpoint) async {
    try {
      Response response = await dioCache.get(endpoint,
          options: buildCacheOptions(
            Duration(hours: 1),
            forceRefresh: true,
            options: Options(
                headers: {"Authorization": "Bearer " + await getToken()}),
          ));
      return responseNormalizer(response);
    } on DioError catch (e) {
      return _catchError(e);
    }
  }

  Future<dynamic> apiGetLongCacheRequests(String endpoint) async {
    try {
      Response response = await dioCache.get(endpoint,
          options: buildCacheOptions(
            Duration(days: 7),
            options: Options(
                headers: {"Authorization": "Bearer " + await getToken()}),
          ));
      return responseNormalizer(response);
    } on DioError catch (e) {
      return _catchError(e);
    }
  }

  Future<Map<String, dynamic>> apiDeleteRequests(String endPoint) async {
    try {
      Response response = await dio.delete(endPoint,
          options: Options(
              headers: {"Authorization": "Bearer " + await getToken()}));
      return responseNormalizer(response);
    } on DioError catch (e) {
      return _catchError(e);
    }
  }

  Future<dynamic> apiDeleteRequestsWithFullResponse(String endPoint) async {
    try {
      return await dio.delete(endPoint,
          options: Options(
              headers: {"Authorization": "Bearer " + await getToken()}));
    } on DioError catch (e) {
      return _catchError(e);
    }
  }

  Future<Map<String, dynamic>> apiPatchRequests(String endPoint) async {
    try {
      final response = await dio.patch(endPoint,
          options: Options(
              headers: {"Authorization": "Bearer " + await getToken()}));
      return responseNormalizer(response);
    } on DioError catch (e) {
      return _catchError(e);
    }
  }

  Future<Map<String, dynamic>> apiPatchWithDataRequests(
      String endPoint, Map<String, dynamic> credentials) async {
    try {
      final response = await dio.patch(endPoint,
          data: credentials,
          options: Options(
              headers: {"Authorization": "Bearer " + await getToken()}));
      return responseNormalizer(response);
    } on DioError catch (e) {
      return _catchError(e);
    }
  }

  Future<Map<String, dynamic>> apiPutRequests(
      String endPoint, Map<String, dynamic> credentials) async {
    try {
      final response = await dio.put(endPoint,
          data: credentials,
          options: Options(
              headers: {"Authorization": "Bearer " + await getToken()}));
      return responseNormalizer(response);
    } on DioError catch (e) {
      print(e);
      return _catchError(e);
    }
  }

  Future<Map<String, dynamic>> apiUploadPutRequests(
      String endPoint, FormData credentials) async {
    try {
      // print(credentials.files);
      final response = await dio.post(endPoint,
          data: credentials,
          options: Options(
              headers: {"Authorization": "Bearer " + await getToken()}));
      return responseNormalizer(response);
    } on DioError catch (e) {
      print(e);
      return _catchError(e);
    }
  }

  Future<Map<String, dynamic>> apiPatchRequestsWithCredentials(
      String endPoint, Map<String, dynamic> credentials) async {
    try {
      final response = await dio.patch(endPoint,
          data: credentials,
          options: Options(
              headers: {"Authorization": "Bearer " + await getToken()}));
      return responseNormalizer(response);
    } on DioError catch (e) {
      return _catchError(e);
    }
  }

  Future<Map<String, dynamic>> apiImageUpload(
      String endPoint, FormData formdata) async {
    try {
      final response = await dio.post(endPoint,
          data: formdata,
          options: Options(
              headers: {"Authorization": "Bearer " + await getToken()}));
      //
      return responseNormalizer(response);
    } on DioError catch (e) {
      return _catchError(e);
    }
  }

  Future<Map<String, dynamic>> apiPatchWithFormdata(
      String endPoint, FormData formdata) async {
    try {
      final response = await dio.post(endPoint,
          queryParameters: {"_method": "PATCH"},
          data: (formdata),
          options: Options(headers: {
            "Authorization": "Bearer " + await getToken(),
          }));

      return responseNormalizer(response);
    } on DioError catch (e) {
      return _catchError(e);
    }
  }

  // Future<Map<String, dynamic>> apiPatchWithMultiPart(
  //   String endPoint,
  //   File file,
  //   Map<String,dynamic> credentials,
  //   String fileField,
  // ) async {
  //   try {
  //     Uri uri = Uri.https(
  //         "www.api.alumates.com", "/api/v1/$endPoint", {"_method": "PATCH"});
  //     http.MultipartRequest request = http.MultipartRequest("POST", uri);
  //     request.headers.addAll({
  //       "Authorization": "Bearer " + await getToken(),
  //       'Content-Type': 'multipart/form-data',
  //       'Accept': 'application.json',
  //     });
  //     request.fields["name"] = "COMMAND SEC SCHOOL";
  //     request.files.add(await http.MultipartFile.fromPath(fileField, file.path));
  //     http.Response response =
  //         await http.Response.fromStream(await request.send());
  //     print(convert.jsonDecode(response.body));
  //     return _httpResponseNormalizer(response);
  //
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  _catchError(dynamic e) {
    if (e.response != null) {
      if (e.response.data["message"]
          .toString()
          .toLowerCase()
          .contains("unauthenticated")) {
        GetIt locator = GetIt.instance;
        final NavigationService _navigationService =
            locator<NavigationService>();
        _navigationService.logOut();
      }
      print(e.response.data);
      print(e.response.headers);
      print(e.response.request);

      return e.response.data;
    } else {
      print(e.request);
      print(e.message);

      return {};
    }
  }

  getToken() async {
    String token = await AppLocalStorage().fetch("token");
    if (token != null) return token;
    return "";
  }

  static responseNormalizer(Response res) {
    if (res.statusCode == 200)
      return {"status": "success", "body": res.data};
    else
      return {"status": "error", "body": res.data};
  }

  _httpResponseNormalizer(http.Response res) {
    if (res.statusCode == 200)
      return {"status": "success", "body": res.body};
    else
      return {"status": "error", "body": res.body};
  }
}

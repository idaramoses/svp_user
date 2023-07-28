import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
// import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:svp_admin_pm/presentation/auth/signin/sign_in_service.dart';
import 'package:svp_admin_pm/presentation/auth/signin/state/auth_provider.dart';

import '../../../routes/app_routes.dart';
import '../../../utils/app_local_storage.dart';
import '../../../utils/flushbar_mixin.dart';
import '../../../utils/store_manager.dart';
import '../../main_dashboard/user_dashboard.dart';
import '../../profile_screen/state/profile_provider.dart';

class SignInController with FlushBarMixin {
  String usertoken;
  BuildContext context;
  AuthProvider authProvider;
  ProfileProvider profileProvider;
  SignInService signInService = SignInService();
  AppLocalStorage storage = AppLocalStorage();
  GoogleSignIn googleSignIn = GoogleSignIn();
  SignInController({@required this.context});

  Future<void> signIn(Map<String, dynamic> credentials) async {
    authProvider = Provider.of<AuthProvider>(context, listen: false);

    try {
      if (credentials["email"] == null) {
        showErrorNotification(
            context, "Email is required to sign in, enable email to continue!");
        return;
      }

      Map<String, dynamic> response =
          await signInService.signIn({...credentials});

      if (response["status"] == "success") {
        //get api token and user info from response

        String api_token = response["body"]["token"];
        //store token to state and local database
        authProvider.token = api_token;
        await storage.store("token", api_token);
        //save user to state and local database
        authProvider.userInfo = await response["body"];
        await storage.store("user", await response["body"]);
        getuserprofile();
        showSuccessNotification(context, "Sign in successful");
        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>MainDashboardScreen(id: 0)));
      } else if (response["status"] == "error" &&
          response["message"] == "Invalid Credentials.") {
        showErrorNotification(context, "Wrong Email or Password");
      } else if (response["error"]["message"] ==
          "Your credentials does not match our record.") {
        showErrorNotification(
            context, "Your credentials does not match our record.");
      } else {
        showErrorNotification(context, response["error"]["message"]);
      }
    } catch (error) {
      print(error);
      showErrorNotification(
          context, "Network Error, Check your internet connection.!");
    }
  }

  Future<void> patchEditProfilenew(String id, FormData formData) async {
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    DefaultCacheManager manager = DefaultCacheManager();

    try {
      Map<String, dynamic> response =
          await signInService.patchEditProfile(id, formData);

      if (response["status"] == "success") {
        await storage.store("user", await response["body"]["data"]);
        authProvider.userInfo = await response["body"]["data"];
        showSuccessNotification(context, "Profile updated successfully");
        await manager.emptyCache();
      } else {
        print(response["status"]);
        showErrorNotification(context, "couldn't update info");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> Reset(Map<String, dynamic> credentials) async {
    authProvider = Provider.of<AuthProvider>(context, listen: false);

    try {
      if (credentials["email"] == null) {
        showErrorNotification(
            context, "Email is required to sign in, enable email to continue!");
        return;
      }

      Map<String, dynamic> response = await signInService.Reset(
          {...credentials, "player_id": await _getDevicePlayerId()});

      if (response["status"] == "success") {
        //get api token and user info from response
        String api_token = response["body"]["api_token"];

        //store token to state and local database
        authProvider.token = api_token;
        await storage.store("token", api_token);

        //save user to state and local database
        authProvider.userInfo = await response["body"];
        await storage.store("user", await response["body"]);
        userOnline(context);
        showSuccessNotification(
            context, "Please check your mail to reset password");
      } else if (response["status"] == "error" &&
          response["message"] == "Invalid Credentials.") {
        showErrorNotification(context, "Wrong Email");
      } else if (response["error"]["message"] ==
          "Your credentials does not match our record.") {
        showErrorNotification(
            context, "Email not registered, Sign up to continue");
      } else {
        showErrorNotification(context, response["error"]["message"]);
      }
    } catch (error) {
      print(error);
      showErrorNotification(
          context, "Network Error, Check your internet connection.!");
    }
  }

  Future<void> Changepassword(Map<String, dynamic> credentials) async {
    authProvider = Provider.of<AuthProvider>(context, listen: false);

    try {
      Map<String, dynamic> response = await signInService.Password(
          {...credentials, "player_id": await _getDevicePlayerId()});

      if (response["status"] == "success") {
        //get api token and user info from response
        String api_token = response["body"]["token"];

        //store token to state and local database
        authProvider.token = api_token;
        await storage.store("token", api_token);

        //save user to state and local database
        authProvider.userInfo = await response["body"];
        await storage.store("user", await response["body"]);
        userOnline(context);
        showSuccessNotification(context, "Password changed correctly");
        Navigator.of(context)
            .pushNamedAndRemoveUntil("/auth_home", (Route r) => r == null);
      } else if (response["status"] == "error" &&
          response["message"] == "Invalid Credentials.") {
        showErrorNotification(context, "Wrong Email");
      } else if (response["error"]["message"] ==
          "Your credentials does not match our record.") {
        showErrorNotification(
            context, "Email not registered, Sign up to continue");
      } else {
        showErrorNotification(context, response["error"]["message"]);
      }
    } catch (error) {
      print(error);
      showErrorNotification(
          context, "Network Error, Check your internet connection.!");
    }
  }

  void fetchUsers() async {
    const url = 'https://randomuser.me/api/?results=20';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    print('fetch user completed');
  }

  Future getuserprofile() async {
    String role =
        Provider.of<AuthProvider>(context, listen: false).userInfo.role;
    try {
        Map<String, dynamic> response = await signInService.pmprofiles();
        if (response["status"] == "success") {
          authProvider.userInfo = await response["body"];
          await storage.store("user", await response["body"]);
        } else {}
    } catch (e) {
      print(e);
    }
  }

  Future signOut() async {
    // googleSignIn.signOut();
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.token = "";
    await storage.store("token", "");
    authProvider.userInfo = null;
    profileProvider.userInfo = null;
    await storage.store("user", null);
    showSuccessNotification(context, "Log out successful");
  }

  Future<void> patchUserData(
      String id, Map<String, dynamic> credentials) async {
    authProvider = Provider.of<AuthProvider>(context, listen: false);

    try {
      Map<String, dynamic> response =
          await signInService.patchUserData(id, credentials);

      if (response["status"] == "success") {
        print(response["body"]["data"]);
        await storage.store("user", await response["body"]["data"]);
        authProvider.userInfo = await response["body"]["data"];
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> ProfileEditProfile(String id, FormData formData) async {
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    DefaultCacheManager manager = DefaultCacheManager();

    try {
      Map<String, dynamic> response =
          await signInService.patchEditProfile(id, formData);

      if (response["status"] == "success") {
        await storage.store("user", await response["body"]["data"]);
        authProvider.userInfo = await response["body"]["data"];
        await manager.emptyCache();
        Navigator.of(context).pushReplacementNamed("/home");
        showSuccessNotification(context, "Business added successfully");
      } else {
        print(response["status"]);
        showErrorNotification(
            context, "couldn't change school,check your network connection");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> changeEditProfile(String id, FormData formData) async {
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    DefaultCacheManager manager = DefaultCacheManager();

    try {
      Map<String, dynamic> response =
          await signInService.patchEditProfile(id, formData);

      if (response["status"] == "success") {
        await storage.store("user", await response["body"]["data"]);
        authProvider.userInfo = await response["body"]["data"];
        await manager.emptyCache();
        Navigator.of(context).pushReplacementNamed("/homesplash");
        showSuccessNotification(context, "school change successfully");
      } else {
        print(response["status"]);
        showErrorNotification(context, "couldn't update info");
      }
    } catch (e) {
      print(e);
    }
  }

  userOnline(context) async {
    await SignInController(context: context).patchUserData(
        Provider.of<AuthProvider>(context, listen: false)
            .userInfo
            .id
            .toString(),
        {"status": "online"});
  }

  Future<void> patchEditProfile(String id, FormData formData) async {
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    DefaultCacheManager manager = DefaultCacheManager();

    try {
      Map<String, dynamic> response =
          await signInService.patchEditProfile(id, formData);

      if (response["status"] == "success") {
        await storage.store("user", await response["body"]["data"]);
        authProvider.userInfo = await response["body"]["data"];
        await manager.emptyCache();
        Navigator.of(context).pushReplacementNamed("/homesplash");
      } else {
        print(response["status"]);
        showErrorNotification(context, "couldn't update info");
      }
    } catch (e) {
      print(e);
    }
  }

  userOffline(context) async {
    await SignInController(context: context).patchUserData(
        Provider.of<AuthProvider>(context, listen: false)
            .userInfo
            .id
            .toString(),
        {"status": "offline", "player_id": null});
  }

  _getDevicePlayerId() async {
    // Get the player id for this device
    // var status = await OneSignal.shared.getPermissionSubscriptionState();

    StorageManager.readData('user_token').then((value) {
      usertoken = value ?? "empty";
    });
    print(usertoken);
    var playerId = usertoken;
    // print(usertoken);
    return playerId;
  }
}

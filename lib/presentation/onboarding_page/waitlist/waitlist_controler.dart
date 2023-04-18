import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:svp_admin_pm/presentation/onboarding_page/waitlist/waitlist_service.dart';
import 'package:svp_admin_pm/presentation/onboarding_page/waitlist/waitlist_success.dart';

import '../../../utils/flushbar_mixin.dart';

class WaitlistController with FlushBarMixin {
  BuildContext context;
  WaitlistService waitlistService = WaitlistService();

  WaitlistController({@required this.context});

  Future<void> Waitlist(Map<String, dynamic> credentials) async {
    try {
      if (credentials["email"] == null) {
        showErrorNotification(
            context, "Email is required to sign in, enable email to continue!");
        return;
      }

      Map<String, dynamic> response = await waitlistService.Join_waitlist({
        ...credentials,
      });

      if (response["status"] == "success") {
        //get api token and user info from response
        showSuccessNotification(context, "Email Added to Waitlist");
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => WaitlistSucessScreen()));
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

  // Future<void> Waitlistt(Map<String, dynamic> credentials) async {
  //   try {
  //     var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.usersEndpoint);
  //     var response = await http.post(url);
  //     if (response.statusCode == 200) {
  //       showSuccessNotification(context, "Successful");
  //       // Navigator.pushReplacementNamed(
  //       //     context, AppRoutes.maindashboardOneScreen);
  //     }
  //     return response;
  //   } catch (e) {
  //     showErrorNotification(
  //         context, "Network Error, Check your internet connection.!");
  //   }
  // }
}

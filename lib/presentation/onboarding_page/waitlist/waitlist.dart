import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:svp_admin_pm/core/app_export.dart';
import 'package:svp_admin_pm/presentation/onboarding_page/waitlist/waitlist_controler.dart';
import 'package:svp_admin_pm/widgets/custom_button.dart';

class Waitlist extends StatefulWidget {
  @override
  State<Waitlist> createState() => _WaitlistState();
}

class _WaitlistState extends State<Waitlist> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  bool isEmailValid = false;
  bool ispasswordValid = false;

  bool issec = true;
  Future<bool> _willPopCallback() {
    Future.delayed(const Duration(milliseconds: 1000), () {
      if (Platform.isIOS) {
        try {
          exit(0);
        } catch (e) {
          SystemNavigator
              .pop(); // for IOS, not true this, you can make comment this :)
        }
      } else {
        try {
          SystemNavigator.pop(); // sometimes it cant exit app
        } catch (e) {
          exit(0); // so i am giving crash to app ... sad :(
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget emailTextField = Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: TextFormField(
            onChanged: (value) {
              if (RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(value)) {
                setState(() {
                  isEmailValid = true;
                });
              } else {
                setState(() {
                  isEmailValid = false;
                });
              }
            },
            validator: validateEmail,
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
                fontSize: getFontSize(15), color: ColorConstant.black900),
            cursorColor: ColorConstant.orangeA200,
            decoration: InputDecoration(
              labelText: "Enter your email",
              labelStyle: TextStyle(color: ColorConstant.black900),
              suffixIcon: Padding(
                  padding: const EdgeInsetsDirectional.only(start: 30),
                  child: isEmailValid
                      ? Icon(
                          Icons.check_circle,
                          color: Colors.green,
                        )
                      : SizedBox()),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
          ),
        ));
    Widget passwordTextField = Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: TextFormField(
            onChanged: (value) {
              if (RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])')
                  .hasMatch(value)) {
                setState(() {
                  ispasswordValid = true;
                });
              } else {
                setState(() {
                  ispasswordValid = false;
                });
              }
            },
            validator: validatepassword,
            // textInputType: TextInputType.emailAddress,
            controller: passwordController,
            keyboardType: TextInputType.visiblePassword,
            style: TextStyle(
                fontSize: getFontSize(15), color: ColorConstant.black900),
            cursorColor: ColorConstant.orangeA200,
            decoration: InputDecoration(
                labelText: "Password",
                labelStyle: TextStyle(color: ColorConstant.black900),
                suffixIcon: Container(
                  margin: getMargin(
                    left: 30,
                    top: 8,
                    right: 16,
                    bottom: 8,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      if (issec == false) {
                        setState(() {
                          issec = true;
                        });
                      } else {
                        setState(() {
                          issec = false;
                        });
                      }
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          issec ? Icons.visibility_off : Icons.visibility,
                          size: 30,
                          color: Colors.grey,
                        ),
                        ispasswordValid
                            ? Icon(
                                Icons.check_circle,
                                color: Colors.green,
                              )
                            : SizedBox()
                      ],
                    ),
                  ),
                ),
                suffixIconConstraints: BoxConstraints(
                  maxHeight: getVerticalSize(
                    40,
                  ),
                ),
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none),
            obscureText: issec ? true : false,
          ),
        ));

    return Scaffold(
      backgroundColor: ColorConstant.gray200,
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              isLoading ? LinearProgressIndicator() : SizedBox(),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: getPadding(
                      left: 15,
                      top: 58,
                      right: 15,
                      bottom: 48,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgSvplogoprimary,
                          height: getVerticalSize(
                            32,
                          ),
                          width: getHorizontalSize(
                            128,
                          ),
                          margin: getMargin(
                            left: 1,
                          ),
                        ),
                        Padding(
                          padding: getPadding(
                            left: 1,
                            top: 32,
                          ),
                          child: Text(
                            "Join our waitlist,",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtSFProTextSemibold18OrangeA200,
                          ),
                        ),
                        Padding(
                          padding: getPadding(
                            left: 1,
                            top: 21,
                          ),
                          child: Text(
                            "Enter your mail and stay updated",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtInterSemiBold16,
                          ),
                        ),
                        Padding(
                          padding: getPadding(
                            left: 1,
                            top: 23,
                          ),
                          child: Text(
                            "Email",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtSFProTextSemibold16Gray800,
                          ),
                        ),
                        emailTextField,
                        isLoading
                            ? Center(
                                child: Container(
                                  height: getVerticalSize(
                                    51,
                                  ),
                                  width: getVerticalSize(
                                    51,
                                  ),
                                  margin: getMargin(
                                    left: 1,
                                    top: 51,
                                  ),
                                  child: CircularProgressIndicator(
                                    color: Colors.orange,
                                  ),
                                ),
                              )
                            : CustomButton(
                                height: getVerticalSize(
                                  51,
                                ),
                                text: "Join waitlist",
                                margin: getMargin(
                                  left: 1,
                                  top: 32,
                                ),
                                onTap: () async {
                                  validateAndSubmit();
                                },
                                variant: ButtonVariant.FillOrangeA200,
                                padding: ButtonPadding.PaddingAll11,
                                fontStyle:
                                    ButtonFontStyle.SFProTextBold16WhiteA700,
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String validateEmail(String value) {
    if (value.trim().length < 1) return "Email can't be empty";
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value.trim())) return "Invalid email address";
    return null;
  }

  String validatepassword(String value) {
    if (value.trim().length < 6)
      return "Password must be more than 6 characters";
    if (!RegExp(r'^(?=.*?[a-z])').hasMatch(value.trim()))
      return "Password must contain capital,small letters and numbers";
    return null;
  }

  void validateAndSubmit() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        try {
          Map<String, dynamic> credentials = {
            "email": emailController.text,
          };

          await WaitlistController(context: context).Waitlist(credentials);
        } catch (e) {
          print(e);
        }
      }
      setState(() {
        isLoading = false;
      });
    }
  }
}

class ApiConstants {
  static String baseUrl = 'https://api.saharaviewpoint.com';
  static String usersEndpoint = '/waitlist/new';
}

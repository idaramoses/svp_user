import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:svp_admin_pm/core/app_export.dart';
import 'package:svp_admin_pm/presentation/auth/signin/sign_in_controller.dart';
import 'package:svp_admin_pm/widgets/custom_button.dart';

import '../../../utils/app_local_storage.dart';

class signin extends StatefulWidget {
  @override
  State<signin> createState() => _signinState();
}

class _signinState extends State<signin> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AppLocalStorage storage = AppLocalStorage();

  bool isLoading = false;
  bool isEmailValid = false;
  bool ispasswordValid = false;

  bool issec = true;

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
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              isLoading ? LinearProgressIndicator() : SizedBox(),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: getPadding(
                      left: 15,
                      top: 48,
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
                            "Welcome to Sahara Viewpoint,",
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
                            "Login to continue.",
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
                        Padding(
                          padding: getPadding(
                            left: 1,
                            top: 23,
                          ),
                          child: Text(
                            "Password",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtSFProTextSemibold16Gray800,
                          ),
                        ),
                        passwordTextField,
                        Padding(
                          padding: getPadding(
                            left: 1,
                            top: 16,
                            right: 1,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomImageView(
                                svgPath: ImageConstant.imgComputerGray50024x24,
                                height: getSize(
                                  24,
                                ),
                                width: getSize(
                                  24,
                                ),
                              ),
                              Padding(
                                padding: getPadding(
                                  left: 8,
                                  top: 2,
                                  bottom: 4,
                                ),
                                child: Text(
                                  "Remember me",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: AppStyle.txtSFProTextRegular14,
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding: getPadding(
                                  top: 4,
                                  bottom: 2,
                                ),
                                child: Text(
                                  "Forgot Password?",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style:
                                      AppStyle.txtSFProTextRegular14OrangeA200,
                                ),
                              ),
                            ],
                          ),
                        ),
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
                                text: "Login",
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
                        Container(
                          height: getVerticalSize(
                            56,
                          ),
                          width: getHorizontalSize(
                            344,
                          ),
                          margin: getMargin(
                            left: 1,
                            top: 51,
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: Padding(
                                  padding: getPadding(
                                    top: 5,
                                    bottom: 30,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: getPadding(
                                          top: 8,
                                          bottom: 10,
                                        ),
                                        child: SizedBox(
                                          width: getHorizontalSize(
                                            144,
                                          ),
                                          child: Divider(
                                            height: getVerticalSize(
                                              1,
                                            ),
                                            thickness: getVerticalSize(
                                              1,
                                            ),
                                            color: ColorConstant.gray300,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "or",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle
                                            .txtSFProTextMedium14Gray600,
                                      ),
                                      Padding(
                                        padding: getPadding(
                                          top: 8,
                                          bottom: 10,
                                        ),
                                        child: SizedBox(
                                          width: getHorizontalSize(
                                            144,
                                          ),
                                          child: Divider(
                                            height: getVerticalSize(
                                              1,
                                            ),
                                            thickness: getVerticalSize(
                                              1,
                                            ),
                                            color: ColorConstant.gray300,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // CustomButton(
                              //   onTap: () {
                              //     signInWithApple();
                              //   },
                              //   height: getVerticalSize(
                              //     56,
                              //   ),
                              //   width: getHorizontalSize(
                              //     336,
                              //   ),
                              //   text: "Sign up with Apple",
                              //   variant: ButtonVariant.OutlineGray100,
                              //   padding: ButtonPadding.PaddingAll7,
                              //   fontStyle:
                              //       ButtonFontStyle.SFProTextMedium12Gray800,
                              //   prefixWidget: Container(
                              //     margin: getMargin(
                              //       right: 16,
                              //     ),
                              //     child: Icon(
                              //       Icons.apple_outlined,
                              //       color: Colors.black54,
                              //     ),
                              //   ),
                              //   alignment: Alignment.center,
                              // ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: getPadding(
                              top: 32,
                              right: 2,
                              bottom: 189,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, AppRoutes.signupScreen);
                              },
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Don't have an account?",
                                      style: TextStyle(
                                        color: ColorConstant.gray800,
                                        fontSize: getFontSize(
                                          16,
                                        ),
                                        fontFamily: 'SF Pro Text',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "  Create Account.",
                                      style: TextStyle(
                                        color: ColorConstant.orangeA200,
                                        fontSize: getFontSize(
                                          16,
                                        ),
                                        fontFamily: 'SF Pro Text',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
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
            "password": passwordController.text,
          };
          await SignInController(context: context).signIn(credentials);
        } catch (e) {
          print(e);
        }
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  Future signInWithApple() async {
    if (await AppleSignIn.isAvailable()) {
      if (await storage.fetch("appleEmail") != null) {
        if (!isLoading) {
          setState(() {
            isLoading = true;
          });

          try {
            // await SignInController(
            //   context: context,
            // ).signIn({
            //   "email": await storage.fetch("appleEmail"),
            //   "password": "123456",
            // });
          } catch (e) {
            print(e);
          }
          setState(() {
            isLoading = false;
          });
        }
        return;
      }
      final AuthorizationResult result = await AppleSignIn.performRequests([
        AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
      ]);
      switch (result.status) {
        case AuthorizationStatus.authorized:
          await storage.store("appleEmail", result.credential.email);
          await storage.store(
              "appleFirstName", result.credential.fullName.givenName);
          await storage.store(
              "appleLastName", result.credential.fullName.familyName);

          //All the required credential

          Map<String, dynamic> alumatesUserCredentials = {
            "firstname": "${result.credential.fullName.givenName} ",
            "lastname": "${result.credential.fullName.familyName}",
            "avatar":
                "https://avataaars.io/?avatarStyle=Circle&topType=ShortHairDreads01&accessoriesType=Round&hairColor=BrownDark&facialHairType=Blank&clotheType=BlazerShirt&eyeType=Default&eyebrowType=Default&mouthType=Default&skinColor=Light",
            "email": result.credential.email,
            "password": "123456"
          };
          print(alumatesUserCredentials);
          print(result.credential.email ?? "no result");
          if (!isLoading) {
            setState(() {
              isLoading = true;
            });
            try {
              await SignInController(
                context: context,
              ).signUp(alumatesUserCredentials);
            } catch (e) {
              print(e);
            }
            setState(() {
              isLoading = false;
            });
          }

          break;
        case AuthorizationStatus.error:
          Fluttertoast.showToast(msg: "Sign in failed");
          break;
        case AuthorizationStatus.cancelled:
          Fluttertoast.showToast(msg: "User cancelled");
          break;
      }
    } else {
      Fluttertoast.showToast(
          msg: 'Apple SignIn is not available for your device');
    }
  }
}

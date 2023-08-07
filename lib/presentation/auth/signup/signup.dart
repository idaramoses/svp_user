import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:svp_admin_pm/core/app_export.dart';
import 'package:svp_admin_pm/widgets/custom_button.dart';
import 'package:svp_admin_pm/widgets/custom_text_form_field.dart';

import '../signin/sign_in_controller.dart';

class signup extends StatefulWidget {
  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  TextEditingController emailController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool issec = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
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
                            "Create account to continue.",
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
                            "Firstname",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtSFProTextSemibold16Gray800,
                          ),
                        ),
                        CustomTextFormField(
                          controller: firstnameController,
                          hintText: "Enter your first name",
                          margin: getMargin(
                            left: 1,
                            top: 15,
                          ),
                          textInputType: TextInputType.emailAddress,
                        ),
                        Padding(
                          padding: getPadding(
                            left: 1,
                            top: 23,
                          ),
                          child: Text(
                            "Lastname",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtSFProTextSemibold16Gray800,
                          ),
                        ),
                        CustomTextFormField(
                          focusNode: FocusNode(),
                          controller: lastnameController,
                          hintText: "Enter your lastname",
                          margin: getMargin(
                            left: 1,
                            top: 15,
                          ),
                          textInputType: TextInputType.emailAddress,
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
                        CustomTextFormField(
                          focusNode: FocusNode(),
                          controller: emailController,
                          validator: validateEmail,
                          hintText: "Enter your email",
                          margin: getMargin(
                            left: 1,
                            top: 15,
                          ),
                          textInputType: TextInputType.emailAddress,
                        ),
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
                        CustomTextFormField(
                          focusNode: FocusNode(),
                          controller: passwordController,
                          validator: validatepassword,
                          margin: getMargin(
                            left: 1,
                            top: 15,
                          ),
                          textInputAction: TextInputAction.done,
                          suffix: Container(
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
                              child: Icon(
                                issec ? Icons.visibility_off : Icons.visibility,
                                size: 20,
                              ),
                            ),
                          ),
                          suffixConstraints: BoxConstraints(
                            maxHeight: getVerticalSize(
                              40,
                            ),
                          ),
                          isObscureText: issec ? true : false,
                        ),
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
                                text: "Create Account",
                                margin: getMargin(
                                  left: 1,
                                  top: 32,
                                ),
                                onTap: () async {
                                  Map<String, dynamic> alumatesUserCredentials =
                                      {
                                    "firstname": firstnameController.text,
                                    "lastname": lastnameController.text,
                                    "avatar":
                                        "https://avataaars.io/?avatarStyle=Circle&topType=ShortHairDreads01&accessoriesType=Round&hairColor=BrownDark&facialHairType=Blank&clotheType=BlazerShirt&eyeType=Default&eyebrowType=Default&mouthType=Default&skinColor=Light",
                                    "email": emailController.text,
                                    "password": passwordController.text
                                  };
                                  print(alumatesUserCredentials);
                                  if (!isLoading) {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    if (_formKey.currentState.validate()) {
                                      _formKey.currentState.save();
                                      try {
                                        await SignInController(
                                          context: context,
                                        ).signUp(alumatesUserCredentials);
                                      } catch (e) {
                                        print(e);
                                      }
                                    }
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
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
                                    context, AppRoutes.signinScreen);
                              },
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Already have an account?",
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
                                      text: "  Login.",
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
}

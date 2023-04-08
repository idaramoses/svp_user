import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:svp_admin_pm/core/app_export.dart';

import '../../utils/flushbar_mixin.dart';
import '../../widgets/custom_button.dart';
import '../auth/signin/sign_in_controller.dart';
import '../auth/signin/state/auth_provider.dart';

class Profile_Screen extends StatefulWidget {
  @override
  State<Profile_Screen> createState() => _Profile_ScreenState();
}

class _Profile_ScreenState extends State<Profile_Screen> with FlushBarMixin {
  TextEditingController mymembershipController = TextEditingController();

  TextEditingController notificationsController = TextEditingController();

  TextEditingController frame1686560721Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<AuthProvider>(
        builder: (context, value, child) => Scaffold(
          backgroundColor: ColorConstant.gray200,
          resizeToAvoidBottomInset: false,
          body: Container(
            width: double.maxFinite,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: getVerticalSize(
                    70,
                  ),
                  width: double.maxFinite,
                  child: Container(
                    width: double.maxFinite,
                    padding: getPadding(
                      all: 16,
                    ),
                    decoration: AppDecoration.outlineGray300,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                margin: getMargin(
                                  top: 10,
                                ),
                                child: Icon(
                                  Icons.arrow_back,
                                  color: ColorConstant.orangeA200,
                                ),
                              ),
                            ),
                            Spacer(),
                            CustomImageView(
                              svgPath: ImageConstant.imgOverflowmenu,
                              height: getSize(
                                24,
                              ),
                              width: getSize(
                                24,
                              ),
                              margin: getMargin(
                                top: 10,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                CustomImageView(
                  url: value.userInfo.avatar ?? '...',
                  height: getSize(
                    72,
                  ),
                  width: getSize(
                    72,
                  ),
                  radius: BorderRadius.circular(
                    getHorizontalSize(
                      36,
                    ),
                  ),
                  margin: getMargin(
                    top: 24,
                  ),
                ),
                Padding(
                  padding: getPadding(
                    top: 7,
                  ),
                  child: Text(
                    value.userInfo.firstName ?? '...',
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtSFProTextBold12Gray500,
                  ),
                ),
                Padding(
                  padding: getPadding(
                    top: 4,
                  ),
                  child: Text(
                    value.userInfo.email ?? '...',
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtSFProTextRegular14,
                  ),
                ),
                CustomButton(
                  height: getVerticalSize(
                    33,
                  ),
                  width: getHorizontalSize(
                    103,
                  ),
                  text: "Edit Profile",
                  margin: getMargin(
                    top: 15,
                  ),
                  variant: ButtonVariant.OutlineGray400,
                  fontStyle: ButtonFontStyle.SFProTextMedium12Gray800,
                ),
                Container(
                  margin: getMargin(
                    left: 16,
                    top: 24,
                    right: 16,
                  ),
                  padding: getPadding(
                    left: 15,
                    top: 10,
                    right: 15,
                    bottom: 10,
                  ),
                  decoration: AppDecoration.outlineGray3005,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: getPadding(
                          top: 1,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "02",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtSFProTextSemibold18Gray800,
                            ),
                            Padding(
                              padding: getPadding(
                                top: 9,
                              ),
                              child: Text(
                                "In progress",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: AppStyle.txtInterRegular16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: getPadding(
                          top: 1,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "05",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtSFProTextSemibold18Gray800,
                            ),
                            Padding(
                              padding: getPadding(
                                top: 9,
                              ),
                              child: Text(
                                "Completed",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: AppStyle.txtInterRegular16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: getPadding(
                          top: 1,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "01",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtSFProTextSemibold18Gray800,
                            ),
                            Padding(
                              padding: getPadding(
                                top: 9,
                              ),
                              child: Text(
                                "Upcoming",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: AppStyle.txtInterRegular16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: getPadding(left: 10, right: 10),
                  child: Column(
                    children: [
                      ListTile(
                        leading: CustomImageView(
                          imagePath: ImageConstant.imgmembership,
                        ),
                        title: Text(
                          "My Membership",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtInterRegular16,
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 12,
                        ),
                      ),
                      Divider(),
                      ListTile(
                        leading: CustomImageView(
                          svgPath: ImageConstant.imgNotification,
                        ),
                        title: Text(
                          "Notification",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtInterRegular16,
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 12,
                        ),
                      ),
                      Divider(),
                      ListTile(
                        leading: CustomImageView(
                          imagePath: ImageConstant.imgsetting,
                        ),
                        title: Text(
                          "Account Settings",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtInterRegular16,
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 12,
                        ),
                      ),
                      Divider(),
                      SizedBox(
                        height: getVerticalSize(30),
                      ),
                      Row(
                        children: [
                          Container(
                            width: getHorizontalSize(150),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  onTap: () async {
                                    SignInController(context: context)
                                        .signOut()
                                        .whenComplete(() {
                                      Navigator.pushReplacementNamed(
                                          context, AppRoutes.signinScreen);
                                      showSuccessNotification(
                                          context, "Log out successful");
                                    });
                                  },
                                  leading: CustomImageView(
                                    svgPath: ImageConstant.imgArrowright,
                                  ),
                                  title: Text(
                                    "Log out",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: AppStyle.txtInterRegular16,
                                  ),
                                ),
                                Divider(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

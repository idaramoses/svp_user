import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:svp_admin_pm/core/app_export.dart';

import '../../widgets/custom_button.dart';
import '../auth/signin/state/auth_provider.dart';
import '../dashboard_page/widgets/dashboard1_item_widget.dart';

// ignore_for_file: must_be_immutable
class DashboardPage extends StatelessWidget {
  List<String> dropdownItemList = [
    "Item One",
    "Item Two",
    "Item Three",
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<AuthProvider>(
        builder: (context, value, child) => Scaffold(
          backgroundColor: ColorConstant.gray200,
          body: SizedBox(
            width: size.width,
            child: SingleChildScrollView(
              child: Padding(
                padding: getPadding(
                  left: 16,
                  top: 23,
                  right: 15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "DASHBOARD",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtSFProTextBold16,
                            ),
                            Padding(
                              padding: getPadding(
                                top: 7,
                              ),
                              child: Text(
                                'Hello ' + value.userInfo.firstName + "!" ??
                                    '...',
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: AppStyle.txtSFProTextSemibold14,
                              ),
                            ),
                          ],
                        ),
                        CustomButton(
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRoutes.newProjectFormScreen);
                          },
                          height: getVerticalSize(
                            37,
                          ),
                          width: getHorizontalSize(
                            150,
                          ),
                          text: "Add New Project",
                          margin: getMargin(
                            top: 11,
                            bottom: 8,
                          ),
                          variant: ButtonVariant.FillOrangeA200,
                          padding: ButtonPadding.PaddingT9,
                          fontStyle: ButtonFontStyle.SFProTextBold14,
                          suffixWidget: Container(
                            margin: getMargin(
                              left: 6,
                            ),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: getPadding(
                        top: 24,
                      ),
                      child: GridView.count(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        crossAxisCount: 2,
                        children: <Widget>[
                          GestureDetector(
                            onTap: (){
                              Navigator.pushNamed(context, AppRoutes.projectsOneScreen);
                            },
                            child: Container(
                              padding: getPadding(
                                left: 16,
                                top: 14,
                                right: 16,
                                bottom: 14,
                              ),
                              decoration:
                                  AppDecoration.outlineOrangeA200.copyWith(
                                borderRadius: BorderRadiusStyle.circleBorder16,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: getPadding(
                                      top: 1,
                                    ),
                                    child: Row(
                                      children: [
                                        CustomImageView(
                                          svgPath:
                                              ImageConstant.imgComputerGray500,
                                          color: ColorConstant.orangeA200,
                                          height: getSize(
                                            32,
                                          ),
                                          width: getSize(
                                            32,
                                          ),
                                        ),
                                        CustomImageView(
                                          svgPath: ImageConstant.imgArrowright,
                                          height: getSize(
                                            24,
                                          ),
                                          width: getSize(
                                            24,
                                          ),
                                          margin: getMargin(
                                            left: 80,
                                            top: 4,
                                            bottom: 4,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: getPadding(
                                      top: 12,
                                    ),
                                    child: Text(
                                      "Projects",
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: AppStyle.txtSFProTextBold16,
                                    ),
                                  ),
                                  Padding(
                                    padding: getPadding(
                                      top: 10,
                                    ),
                                    child: Text(
                                      "7",
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: AppStyle.txtInterSemiBold24,
                                    ),
                                  ),
                                  Container(
                                    width: getHorizontalSize(
                                      113,
                                    ),
                                    margin: getMargin(
                                      top: 11,
                                    ),
                                    child: Text(
                                      "You have 7 ongoing Projects.",
                                      maxLines: null,
                                      textAlign: TextAlign.left,
                                      style:
                                          AppStyle.txtSFProTextMedium12.copyWith(
                                        letterSpacing: getHorizontalSize(
                                          0.06,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.pushNamed(context, AppRoutes.projectsOneScreen);
                            },
                            child: Container(
                              padding: getPadding(
                                left: 16,
                                top: 14,
                                right: 16,
                                bottom: 14,
                              ),
                              decoration:
                                  AppDecoration.outlineOrangeA200.copyWith(
                                borderRadius: BorderRadiusStyle.circleBorder16,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: getPadding(
                                      top: 1,
                                    ),
                                    child: Row(
                                      children: [
                                        CustomImageView(
                                          svgPath: ImageConstant.imgMailGray500,
                                          color: ColorConstant.orangeA200,
                                          height: getSize(
                                            32,
                                          ),
                                          width: getSize(
                                            32,
                                          ),
                                        ),
                                        CustomImageView(
                                          svgPath: ImageConstant.imgArrowright,
                                          height: getSize(
                                            24,
                                          ),
                                          width: getSize(
                                            24,
                                          ),
                                          margin: getMargin(
                                            left: 80,
                                            top: 4,
                                            bottom: 4,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: getPadding(
                                      top: 12,
                                    ),
                                    child: Text(
                                      "Report",
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: AppStyle.txtSFProTextBold16,
                                    ),
                                  ),
                                  Padding(
                                    padding: getPadding(
                                      top: 10,
                                    ),
                                    child: Text(
                                      "7",
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: AppStyle.txtInterSemiBold24,
                                    ),
                                  ),
                                  Container(
                                    width: getHorizontalSize(
                                      113,
                                    ),
                                    margin: getMargin(
                                      top: 11,
                                    ),
                                    child: Text(
                                      "You have 7 new report.",
                                      maxLines: null,
                                      textAlign: TextAlign.left,
                                      style:
                                          AppStyle.txtSFProTextMedium12.copyWith(
                                        letterSpacing: getHorizontalSize(
                                          0.06,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.pushNamed(context, AppRoutes.messagesFivePage);
                            },
                            child: Container(
                              padding: getPadding(
                                left: 16,
                                top: 14,
                                right: 16,
                                bottom: 14,
                              ),
                              decoration:
                                  AppDecoration.outlineOrangeA200.copyWith(
                                borderRadius: BorderRadiusStyle.circleBorder16,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: getPadding(
                                      top: 1,
                                    ),
                                    child: Row(
                                      children: [
                                        CustomImageView(
                                          svgPath:
                                              ImageConstant.imgMailGray50024x24,
                                          color: ColorConstant.orangeA200,
                                          height: getSize(
                                            32,
                                          ),
                                          width: getSize(
                                            32,
                                          ),
                                        ),
                                        CustomImageView(
                                          svgPath: ImageConstant.imgArrowright,
                                          height: getSize(
                                            24,
                                          ),
                                          width: getSize(
                                            24,
                                          ),
                                          margin: getMargin(
                                            left: 80,
                                            top: 4,
                                            bottom: 4,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: getPadding(
                                      top: 12,
                                    ),
                                    child: Text(
                                      "Messages",
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: AppStyle.txtSFProTextBold16,
                                    ),
                                  ),
                                  Padding(
                                    padding: getPadding(
                                      top: 10,
                                    ),
                                    child: Text(
                                      "4",
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: AppStyle.txtInterSemiBold24,
                                    ),
                                  ),
                                  Container(
                                    width: getHorizontalSize(
                                      113,
                                    ),
                                    margin: getMargin(
                                      top: 11,
                                    ),
                                    child: Text(
                                      "You have 4 new messages.",
                                      maxLines: null,
                                      textAlign: TextAlign.left,
                                      style:
                                          AppStyle.txtSFProTextMedium12.copyWith(
                                        letterSpacing: getHorizontalSize(
                                          0.06,
                                        ),
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
                    Padding(
                      padding: getPadding(top: 10),
                      child: Row(
                        children: [
                          Text(
                            "In Progress",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtSFProTextBold16,
                          ),
                          Spacer(),
                          Padding(
                            padding: getPadding(
                              left: 25,
                              top: 12,
                              bottom: 10,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  "View all",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: AppStyle.txtSFProTextBold16,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down_sharp,
                                  color: ColorConstant.orangeA200,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: getPadding(
                        top: 16,
                        right: 1,
                      ),
                      child: ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: getVerticalSize(
                              16,
                            ),
                          );
                        },
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return index == 1
                              ? Dashboard1ItemWidgecompete()
                              : index == 3
                                  ? Dashboard1ItemWidgecompete()
                                  : index == 4
                                      ? Dashboard1ItemWidgepending()
                                      : Dashboard1ItemWidget();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

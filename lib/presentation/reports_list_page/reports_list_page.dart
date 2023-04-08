import 'package:flutter/material.dart';
import 'package:svp_admin_pm/core/app_export.dart';

import '../../widgets/custom_button.dart';
import '../reports_grid_one_screen/reports_grid_one_screen.dart';
import '../reports_list_page/widgets/reports_list_item_widget.dart';

// ignore_for_file: must_be_immutable
class ReportsListNewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.gray200,
        body: SizedBox(
          width: size.width,
          child: SingleChildScrollView(
            child: Padding(
              padding: getPadding(
                left: 16,
                top: 25,
                right: 14,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: getPadding(
                      top: 24,
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
                      itemCount: 8,
                      itemBuilder: (context, index) {
                        return ReportsListItemWidget();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ReportsListPage extends StatefulWidget {
  @override
  State<ReportsListPage> createState() => _ReportsListPageState();
}

class _ReportsListPageState extends State<ReportsListPage>
    with TickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 2, vsync: this, initialIndex: 0);
    tabController.addListener(_getActiveTabIndex);
  }

  void _getActiveTabIndex() {
    setState(() {
      _selectedIndex = tabController.index;
    });
    debugPrint('CURRENT_PAGE $_selectedIndex');
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: NestedScrollView(
        scrollDirection: Axis.vertical,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverToBoxAdapter(
            //headerSilverBuilder only accepts slivers
            child: Container(
              color: ColorConstant.gray200,
              child: Column(
                children: [
                  Padding(
                    padding: getPadding(
                      top: 20,
                      right: 10,
                      left: 16,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: getPadding(
                            top: 8,
                            bottom: 8,
                          ),
                          child: Text(
                            "ALL REPORTS",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtSFProTextBold16,
                          ),
                        ),
                        CustomButton(
                          height: getVerticalSize(
                            37,
                          ),
                          width: getHorizontalSize(
                            108,
                          ),
                          text: "Upload",
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRoutes.uploadReportsOneScreen);
                          },
                          variant: ButtonVariant.FillOrangeA200,
                          padding: ButtonPadding.PaddingT9,
                          fontStyle: ButtonFontStyle.SFProTextBold14,
                          suffixWidget: Container(
                            margin: getMargin(
                              left: 6,
                            ),
                            child: CustomImageView(
                              svgPath: ImageConstant.imgUpload,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: getPadding(right: 28, top: 20),
                    child: Row(
                      children: [
                        Container(
                          height: getVerticalSize(
                            40,
                          ),
                          width: getHorizontalSize(
                            120,
                          ),
                          margin: getMargin(
                            left: 16,
                          ),
                          decoration: BoxDecoration(
                            color: ColorConstant.whiteA700,
                            borderRadius: BorderRadius.circular(
                              getHorizontalSize(
                                8,
                              ),
                            ),
                            border: Border.all(
                              color: ColorConstant.gray300,
                              width: getHorizontalSize(
                                1,
                              ),
                            ),
                          ),
                          child: TabBar(
                            //TODO: Please add tab controller
                            controller: tabController,
                            labelPadding: EdgeInsets.all(7),
                            indicator: BoxDecoration(
                              color: ColorConstant.orangeA200A2,
                              borderRadius: BorderRadius.circular(
                                getHorizontalSize(
                                  8,
                                ),
                              ),
                              border: Border.all(
                                color: ColorConstant.orangeA200A2,
                                width: getHorizontalSize(
                                  1,
                                ),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: ColorConstant.gray80026,
                                  spreadRadius: getHorizontalSize(
                                    2,
                                  ),
                                  blurRadius: getHorizontalSize(
                                    2,
                                  ),
                                  offset: Offset(
                                    2,
                                    0,
                                  ),
                                ),
                              ],
                            ),
                            tabs: [
                              Tab(
                                child: CustomImageView(
                                  color: _selectedIndex == 0
                                      ? Colors.white
                                      : ColorConstant.orangeA200A2,
                                  svgPath: ImageConstant.imgMenuWhiteA700,
                                  height: getSize(
                                    34,
                                  ),
                                  width: getSize(
                                    34,
                                  ),
                                ),
                              ),
                              Tab(
                                child: CustomImageView(
                                  color: _selectedIndex == 1
                                      ? Colors.white
                                      : ColorConstant.orangeA200A2,
                                  svgPath: ImageConstant.imgGridOrangeA200,
                                  height: getSize(
                                    24,
                                  ),
                                  width: getSize(
                                    24,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: getPadding(
                            top: 10,
                            bottom: 12,
                          ),
                          child: Row(
                            children: [
                              Text(
                                "Filter: ",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: AppStyle.txtSFProTextMedium14Gray500,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.keyboard_arrow_down_sharp,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: getPadding(
                            left: 25,
                            top: 12,
                            bottom: 10,
                          ),
                          child: Row(
                            children: [
                              Text(
                                "Sort by:",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: AppStyle.txtSFProTextMedium14Gray500,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.keyboard_arrow_down_sharp,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        body: TabBarView(
          controller: tabController,
          //TODO: Please add tab controller
          children: [
            ReportsListNewPage(),
            ReportsGridOneScreen(),
          ],
        ),
      ),
    );
  }
}

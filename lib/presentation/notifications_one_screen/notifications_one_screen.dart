import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:svp_admin_pm/core/app_export.dart';

import '../notifications_one_screen/widgets/sectionlisttoday2_item_widget.dart';

class NotificationsOneScreen extends StatelessWidget {
  List sectionlisttoday2ItemList = [
    {'id': 1, 'groupBy': "Today"},
    {'id': 2, 'groupBy': "Today"},
    {'id': 3, 'groupBy': "This Week"},
    {'id': 4, 'groupBy': "This Week"}
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.gray200,
        body: Container(
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    // all: 16,
                    bottom: 8,
                    left: 10,
                    right: 16,
                  ),
                  decoration: AppDecoration.outlineGray300,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              padding: const EdgeInsets.all(2.0),
                              icon: Icon(
                                Icons.arrow_back,
                                color: ColorConstant.orangeA200,
                              )),
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
              Padding(
                padding: getPadding(
                  left: 16,
                  top: 25,
                ),
                child: Text(
                  "ALL NOTIFICATIONS",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: AppStyle.txtSFProTextBold16,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: getPadding(
                    top: 18,
                    bottom: 5,
                  ),
                  child: GroupedListView<dynamic, String>(
                    shrinkWrap: true,
                    useStickyGroupSeparators: true,
                    stickyHeaderBackgroundColor: Colors.transparent,
                    elements: sectionlisttoday2ItemList,
                    groupBy: (element) => element['groupBy'],
                    groupSeparatorBuilder: (String value) {
                      return Padding(
                        padding: getPadding(
                          right: 296,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              value,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtSFProTextBold16.copyWith(
                                color: ColorConstant.orangeA200,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    itemBuilder: (context, model) {
                      return Sectionlisttoday2ItemWidget();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

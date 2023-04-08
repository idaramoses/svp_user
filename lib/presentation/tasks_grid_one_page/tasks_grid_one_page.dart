import '../tasks_grid_one_page/widgets/tasks_grid_one_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:svp_admin_pm/core/app_export.dart';

// ignore_for_file: must_be_immutable
class TasksGridOnePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SizedBox(
          width: size.width,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: getPadding(
                    left: 16,
                    right: 14,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: getPadding(
                          right: 128,
                        ),
                        child: Text(
                          "Filter:",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtSFProTextMedium14Gray500,
                        ),
                      ),
                      Padding(
                        padding: getPadding(
                          right: 30,
                        ),
                        child: Text(
                          "Sort by:",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtSFProTextMedium14Gray500,
                        ),
                      ),
                      Padding(
                        padding: getPadding(
                          top: 34,
                        ),
                        child: GridView.builder(
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisExtent: getVerticalSize(
                              236,
                            ),
                            crossAxisCount: 2,
                            mainAxisSpacing: getHorizontalSize(
                              8,
                            ),
                            crossAxisSpacing: getHorizontalSize(
                              8,
                            ),
                          ),
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return TasksGridOneItemWidget();
                          },
                        ),
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

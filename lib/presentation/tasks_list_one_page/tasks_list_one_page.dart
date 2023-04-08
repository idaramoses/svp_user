import '../tasks_list_one_page/widgets/tasks_list_one_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:svp_admin_pm/core/app_export.dart';

// ignore_for_file: must_be_immutable
class TasksListOnePage extends StatelessWidget {
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
                    right: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: getPadding(
                          right: 126,
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
                          right: 28,
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
                          top: 26,
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
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return TasksListOneItemWidget();
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

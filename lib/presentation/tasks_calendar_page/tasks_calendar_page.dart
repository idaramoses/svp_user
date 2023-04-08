import 'package:animated_horizontal_calendar/animated_horizontal_calendar.dart';
import 'package:flutter/material.dart';
import 'package:svp_admin_pm/core/app_export.dart';

import '../tasks_calendar_page/widgets/tasks_calendar_item_widget.dart';

// ignore_for_file: must_be_immutable
class TasksCalendarPage extends StatelessWidget {
  var selectedDate;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.gray200,
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
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: getPadding(
                            top: 35,
                          ),
                          child: Text(
                            "February, 2023",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtSFProTextBold16,
                          ),
                        ),
                      ),
                      Container(
                        margin: getMargin(
                          top: 14,
                        ),
                        padding: getPadding(
                          top: 8,
                          bottom: 8,
                        ),
                        decoration: AppDecoration.outlineGray3005,
                        child: Container(
                          height: 100,
                          child: AnimatedHorizontalCalendar(
                              tableCalenderIcon: Icon(
                                Icons.calendar_today,
                                color: Colors.white,
                              ),
                              date: DateTime.now(),
                              textColor: Colors.black45,
                              backgroundColor: Colors.white,
                              tableCalenderThemeData:
                                  ThemeData.light().copyWith(
                                primaryColor: Colors.green,
                                accentColor: Colors.red,
                                colorScheme:
                                    ColorScheme.light(primary: Colors.green),
                                buttonTheme: ButtonThemeData(
                                    textTheme: ButtonTextTheme.primary),
                              ),
                              selectedColor: ColorConstant.orangeA200,
                              onDateSelected: (date) {
                                selectedDate = date;
                              }),
                        ),
                      ),
                      Padding(
                        padding: getPadding(
                          top: 16,
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
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return TasksCalendarItemWidget();
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

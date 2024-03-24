import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sharkhub/res/constant/app_routes_path.dart';
import '../../../../data/app_data.dart';
import '../../../../res/common/app_methods.dart';
import '../../../../utils/themes.dart';
import '../../controller/package_detail_controller.dart';

class AllPlansPage extends StatefulWidget {
  const AllPlansPage({super.key});

  @override
  State<AllPlansPage> createState() => _AllPlansPageState();
}

class _AllPlansPageState extends State<AllPlansPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (packageDetailController) {
        return Expanded(
          child: ListView.separated(
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return animationFunction(
                index,
                GestureDetector(
                  onTap: () {
                    packageDetailController.selected.value = index;
                    CommonMethods.sendToNextScreen(context, RoutesPath.paymentPage);
                    packageDetailController.update();
                  },
                  child: Container(
                    margin: CommonMethods.appPadding(),
                    decoration: CommonMethods.getBoxDecoration(
                      cornerRadius: 12.r,
                      color: Themes.getCardColor(context),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
                          child: Row(
                            children: [
                              CommonMethods.appTexts(
                                context,
                                planDetailDataList[index].price!,
                                color: Themes.getTextColor(context),
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700,
                              ),
                              CommonMethods.sizedBox(width: 12.w),
                              Expanded(
                                child: CommonMethods.appTexts(
                                  context,
                                  planDetailDataList[index].validity!,
                                  color: Themes.getTextColor(context),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Container(
                                height: 24.h,
                                width: 24.h,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color:
                                          packageDetailController.selected.value ==
                                                  index
                                              ? Themes.getPrimaryColor(context)
                                              : const Color(0x33ACAFB5),
                                      width: 1.5,
                                    )),
                                child: packageDetailController.selected.value ==
                                        index
                                    ? Container(
                                        height: 10.h,
                                        width: 10.h,
                                        margin: EdgeInsets.all(3.5.w),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: packageDetailController
                                                      .selected.value ==
                                                  index
                                              ? Themes.getPrimaryColor(context)
                                              : const Color(0x33ACAFB5),
                                        ),
                                      )
                                    : const SizedBox(),
                              ),
                            ],
                          ),
                        ),
                        CommonMethods.sizedBox(height: 10.h),
                        Divider(
                          color: Themes.getDividerColor(context),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 16.w, right: 16.w, bottom: 16.h),
                          child: ExpandableText(
                            planDetailDataList[index].des!,
                            style: TextStyle(
                              color: Themes.getTextColor(context),
                              fontSize: 13.sp,
                              height: 1.5,
                              fontWeight: FontWeight.w400,
                            ),
                            expandText: 'View more...',
                            collapseText: 'View less',
                            linkColor: Themes.getPrimaryColor(context),
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) =>
                CommonMethods.sizedBox(height: 16.h),
            itemCount: 5,
          ),
        );
      },
      init: PackageDetailController(),
    );
  }
}

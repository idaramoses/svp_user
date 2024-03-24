import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../data/app_data.dart';
import '../../../../res/common/app_methods.dart';
import '../../../../utils/themes.dart';
import '../../controller/package_detail_controller.dart';
import '../../model/package_category_model.dart';

class PlansCategoryPage extends StatelessWidget {
  const PlansCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(builder: (packageDetailController) {
      return Container(
        height: 33.h,
        padding: EdgeInsets.only(left: 16.w),
        child: GetBuilder(
          builder: (controller) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: packageCategoryDataList.length,
              itemBuilder: (context, index) {
                PackageCategoryModel categoriesModel =
                packageCategoryDataList[index];
                return animationFunction(
                  index,
                  GestureDetector(
                    onTap: () {
                      packageDetailController.selectData.value = index;
                      packageDetailController.update();
                    },
                    child: Container(
                      height: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      decoration: CommonMethods.getBoxDecoration(
                        color:
                        packageDetailController.selectData.value ==
                            index
                            ? Themes.getPrimaryColor(context)
                            : Colors.transparent,
                        cornerRadius: 17.r,
                      ),
                      child: Center(
                        child: CommonMethods.appTexts(
                          context,
                          categoriesModel.text!,
                          color: packageDetailController
                              .selectData.value ==
                              index
                              ? Colors.white
                              : const Color(0xFF808080),
                          fontSize: 16.sp,
                          fontWeight: packageDetailController
                              .selectData.value ==
                              index
                              ? FontWeight.w600
                              : FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
          init: PackageDetailController(),
        ),
      );
    },
    init: PackageDetailController(),
    );
  }
}

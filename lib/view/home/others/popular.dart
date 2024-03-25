import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:sharkhub/view/home/controller/home_controller.dart';
import '../../../res/common/app_methods.dart';
import '../../../res/constant/app_routes_path.dart';
import '../../../res/constant/app_strings.dart';
import '../../../utils/themes.dart';
import '../common/popular_trans_common.dart';

class PopularTransaction extends StatelessWidget {
  const PopularTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (homeController) {
        return Column(
          children: [
            Padding(
              padding: CommonMethods.appPadding(),
              child: Row(
                children: [
                  Expanded(
                    child: CommonMethods.appTexts(
                      context,
                      AppText.popularTransaction,
                      color: Themes.getTextColor(context),
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      CommonMethods.sendToNextScreen(
                          context, RoutesPath.popularTransactionPage);
                    },
                    child: CommonMethods.appTexts(
                      context,
                      AppText.viewAll,
                      color: Themes.getTextColor(context),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            CommonMethods.sizedBox(height: 16.h),
            SizedBox(
              height: 200.h,
              child: GridView.builder(
                primary: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: homeController.popularList.length,
                padding: CommonMethods.appPadding(),
                itemBuilder: (context, index) {
                  return animationFunction(
                    index,
                    // ignore: prefer_const_constructors
                    slideDuration: Duration(seconds: 1),
                    PopularTransCommon(
                      image: homeController.popularList[index].image,
                      title: homeController.popularList[index].title,
                      status: homeController.popularList[index].status,
                      price: homeController.popularList[index].price,
                    ),
                  );
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  crossAxisSpacing: 16.w,
                ),
              ),
            ),
            CommonMethods.sizedBox(height: 20.h),
          ],
        );
      },
      init: HomeController(),
    );
  }
}

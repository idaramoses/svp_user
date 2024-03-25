import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sharkhub/res/constant/app_strings.dart';
import 'package:sharkhub/view/home/controller/home_controller.dart';

import '../../../res/common/app_methods.dart';
import '../../../res/constant/app_routes_path.dart';
import '../../../utils/themes.dart';

class OffersList extends StatelessWidget {
  const OffersList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (homeController) {
        return Padding(
          padding: CommonMethods.appPadding(),
          child: Column(
            children: [
              CommonMethods.sizedBox(height: 16.h),
              Container(
                height: 210.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.r)),
                  color: Themes.getPrimaryColor(context),
                ),
                child:   Stack(
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Container(),
                        ),
                        Expanded(
                          flex: 5,
                          child: CommonMethods.imagesOfApp(AppImages.eletricity_meter,
                              fit: BoxFit.fitHeight, height: 210.h),
                        ),

                      ],
                    ),
                    Container(
                      height: 210.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8.r)),
                        color: Colors.black.withOpacity(0.2),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 6,
                          child: Padding(
                            padding: EdgeInsets.only(top:15.h, bottom: 20.h, left: 24.h),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: CommonMethods.appTexts(
                                    context,
                                    'Simplifying Your Electricity Bill Payments',
                                    color: Colors.white,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                CommonMethods.sizedBox(height: 8.h),
                                Container(

                                  child: CommonMethods.appTexts(
                                    context,
                                    'Enjoy a smooth experience when paying your electricity bills.',
                                    color: Colors.white,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                CommonMethods.sizedBox(height: 10.h),
                                GestureDetector(
                                  onTap: () {
                                    // Get.off(PinCodeScreen());
                                    CommonMethods.sendToNextScreen(
                                        context, RoutesPath.electricityBillPage);
                                  },
                                  child: Container(
                                    height: 35.h,
                                    width: 130.w,
                                    decoration: CommonMethods.getBoxDecoration(
                                      cornerRadius: 10.r,
                                      color: Colors.white,
                                    ),
                                    child: Center(
                                      child: CommonMethods.appTexts(
                                        context,
                                        'Buy Electricity',
                                        color: Colors.black,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Container()
                        ),

                      ],
                    ),
                  ],
                ),
              ),
              // CarouselSlider(
              //   items: List.generate(
              //     3,
              //     (index) => Stack(
              //       children: [
              //         CommonMethods.imagesOfApp(homeController.list[index].image!),
              //         Padding(
              //           padding: EdgeInsets.only(left: 24.w, top: 16.h),
              //           child: Column(
              //             mainAxisSize: MainAxisSize.min,
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               CommonMethods.appTexts(
              //                 context,
              //                 homeController.list[index].title!,
              //                 color: Colors.white,
              //                 fontSize: 20.sp,
              //                 fontWeight: FontWeight.w700,
              //               ),
              //               CommonMethods.sizedBox(height: 26.h),
              //               Container(
              //                 height: 34.h,
              //                 width: 122.w,
              //                 decoration: CommonMethods.getBoxDecoration(
              //                   cornerRadius: 18.r,
              //                   color: Colors.white,
              //                 ),
              //                 child: Center(
              //                   child: CommonMethods.appTexts(
              //                     context,
              //                     AppText.bookNow,
              //                     color: Colors.black,
              //                     fontSize: 15.sp,
              //                     fontWeight: FontWeight.w700,
              //                   ),
              //                 ),
              //               )
              //             ],
              //           ),
              //         )
              //       ],
              //     ),
              //   ),
              //   carouselController: homeController.carouselController,
              //   options: CarouselOptions(
              //     height: 150,
              //     viewportFraction: 0.85,
              //     aspectRatio: 1.5,
              //     padEnds: false,
              //     enableInfiniteScroll: false,
              //     autoPlay: true,
              //     autoPlayAnimationDuration: const Duration(milliseconds: 500),
              //     autoPlayCurve: Curves.fastOutSlowIn,
              //     scrollDirection: Axis.horizontal,
              //     onPageChanged: (index, reason) {
              //       homeController.i.value = index;
              //       homeController.update();
              //     },
              //   ),
              // ),
              CommonMethods.sizedBox(height: 15.h),
              // Obx(() {
              //   return Center(
              //     child: DotsIndicator(
              //       dotsCount: 3,
              //       position: homeController.i.value,
              //       decorator: DotsDecorator(
              //         color: const Color(0xFFA7AEC1),
              //         activeColor: Themes.getPrimaryColor(context),
              //         activeShape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(20.0),
              //         ),
              //         shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(20.0)),
              //         size: Size(8.w, 8.h),
              //         activeSize: Size(21.33.w, 8.h),
              //         spacing: EdgeInsets.only(right: 5.w),
              //       ),
              //     ),
              //   );
              // }),
            ],
          ),
        );
      },
      init: HomeController(),
    );
  }
}

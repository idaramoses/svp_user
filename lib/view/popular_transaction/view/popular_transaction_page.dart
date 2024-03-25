import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/app_data.dart';
import '../../../res/common/app_methods.dart';
import '../../../res/constant/app_routes_path.dart';
import '../../../res/constant/app_strings.dart';
import '../../../utils/themes.dart';
import '../../home/common/popular_trans_common.dart';

class PopularTransactionPage extends StatefulWidget {
  const PopularTransactionPage({super.key});

  @override
  State<PopularTransactionPage> createState() => _PopularTransactionPageState();
}

class _PopularTransactionPageState extends State<PopularTransactionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonMethods.appBar(
        onTap: () {
          CommonMethods.jumpOutFromScreen(context);
        },
        backgroundColor: Themes.getScaffoldColor(context),
        title: CommonMethods.appTexts(
          context,
          AppText.popularTransaction,
          color: Themes.getTextColor(context),
          fontSize: 28.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Divider(
              color: Themes.getDividerColor(context),
            ),
            CommonMethods.sizedBox(height: 16.h),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  CommonMethods.sendToNextScreen(
                      context, RoutesPath.transactionDetailPage);
                },
                child: GridView.builder(
                  primary: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: allPopularTransDataList.length,
                  padding: CommonMethods.appPadding(),
                  itemBuilder: (context, index) {
                    return animationFunction(
                      index,
                      PopularTransCommon(
                        image: allPopularTransDataList[index].image,
                        title: allPopularTransDataList[index].title,
                        status: allPopularTransDataList[index].status,
                        price: allPopularTransDataList[index].price,
                      ),
                    );
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.w,
                    childAspectRatio: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

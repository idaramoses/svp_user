import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../res/common/app_methods.dart';
import '../../../res/constant/app_strings.dart';
import '../../../utils/themes.dart';
import 'other/all_plans.dart';
import 'other/plans_category.dart';
import 'other/search_plan.dart';

class PackageDetailPage extends StatefulWidget {
  const PackageDetailPage({super.key});

  @override
  State<PackageDetailPage> createState() => _PackageDetailPageState();
}

class _PackageDetailPageState extends State<PackageDetailPage> {
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
          AppText.browsePlans,
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
            CommonMethods.sizedBox(height: 10.h),
            const SearchPlanPage(),
            CommonMethods.sizedBox(height: 16.h),
            const PlansCategoryPage(),
            CommonMethods.sizedBox(height: 24.h),
            const AllPlansPage(),
          ],
        ),
      ),
    );
  }
}

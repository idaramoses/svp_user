import 'package:flutter/material.dart';
import 'package:svp_admin_pm/core/app_export.dart';
import 'package:svp_admin_pm/models/project.dart';
import 'package:svp_admin_pm/presentation/projects_list_one_page/project_controller.dart';

import '../../widgets/custom_button.dart';
import '../dashboard_page/widgets/dashboard1_item_widget.dart';
import '../projects_grid_screen/projects_grid_screen.dart';

// ignore_for_file: must_be_immutable

class ProjectsListOnePage extends StatefulWidget {
  @override
  State<ProjectsListOnePage> createState() => _ProjectsListOnePageState();
}

class _ProjectsListOnePageState extends State<ProjectsListOnePage>
    with TickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 2, vsync: this, initialIndex: 0);
    tabController.addListener(_getActiveTabIndex);
  }

  void _getActiveTabIndex() {
    setState(() {
      _selectedIndex = tabController.index;
    });
    debugPrint('CURRENT_PAGE $_selectedIndex');
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: NestedScrollView(
        scrollDirection: Axis.vertical,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverToBoxAdapter(
            //headerSilverBuilder only accepts slivers
            child: Container(
              color: ColorConstant.gray200,
              child: Column(
                children: [
                  Padding(
                    padding: getPadding(
                      left: 16,
                      right: 16,
                      top: 25,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "ALL PROJECTS",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtSFProTextBold16,
                        ),
                        CustomButton(
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRoutes.newProjectFormScreen);
                          },
                          height: getVerticalSize(
                            37,
                          ),
                          width: getHorizontalSize(
                            150,
                          ),
                          text: "Add New Project",
                          margin: getMargin(
                            top: 11,
                            bottom: 8,
                          ),
                          variant: ButtonVariant.FillOrangeA200,
                          padding: ButtonPadding.PaddingT9,
                          fontStyle: ButtonFontStyle.SFProTextBold14,
                          suffixWidget: Container(
                            margin: getMargin(
                              left: 6,
                            ),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: getPadding(right: 28, top: 10),
                    child: Row(
                      children: [
                        Container(
                          height: getVerticalSize(
                            40,
                          ),
                          width: getHorizontalSize(
                            120,
                          ),
                          margin: getMargin(
                            left: 16,
                          ),
                          decoration: BoxDecoration(
                            color: ColorConstant.whiteA700,
                            borderRadius: BorderRadius.circular(
                              getHorizontalSize(
                                8,
                              ),
                            ),
                            border: Border.all(
                              color: ColorConstant.gray300,
                              width: getHorizontalSize(
                                1,
                              ),
                            ),
                          ),
                          child: TabBar(
                            //TODO: Please add tab controller
                            controller: tabController,
                            labelPadding: EdgeInsets.all(7),
                            indicator: BoxDecoration(
                              color: ColorConstant.orangeA200A2,
                              borderRadius: BorderRadius.circular(
                                getHorizontalSize(
                                  8,
                                ),
                              ),
                              border: Border.all(
                                color: ColorConstant.orangeA200A2,
                                width: getHorizontalSize(
                                  1,
                                ),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: ColorConstant.gray80026,
                                  spreadRadius: getHorizontalSize(
                                    2,
                                  ),
                                  blurRadius: getHorizontalSize(
                                    2,
                                  ),
                                  offset: Offset(
                                    2,
                                    0,
                                  ),
                                ),
                              ],
                            ),
                            tabs: [
                              Tab(
                                child: CustomImageView(
                                  color: _selectedIndex == 0
                                      ? Colors.white
                                      : ColorConstant.orangeA200A2,
                                  svgPath: ImageConstant.imgMenuWhiteA700,
                                  height: getSize(
                                    34,
                                  ),
                                  width: getSize(
                                    34,
                                  ),
                                ),
                              ),
                              Tab(
                                child: CustomImageView(
                                  color: _selectedIndex == 1
                                      ? Colors.white
                                      : ColorConstant.orangeA200A2,
                                  svgPath: ImageConstant.imgGridOrangeA200,
                                  height: getSize(
                                    24,
                                  ),
                                  width: getSize(
                                    24,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: getPadding(
                            top: 10,
                            bottom: 12,
                          ),
                          child: Row(
                            children: [
                              Text(
                                "Filter: ",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: AppStyle.txtSFProTextMedium14Gray500,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.keyboard_arrow_down_sharp,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: getPadding(
                            left: 25,
                            top: 12,
                            bottom: 10,
                          ),
                          child: Row(
                            children: [
                              Text(
                                "Sort by:",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: AppStyle.txtSFProTextMedium14Gray500,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.keyboard_arrow_down_sharp,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        body: TabBarView(
          controller: tabController,
          //TODO: Please add tab controller
          children: [
            ProjectsListOneNewPage(),
            ProjectsGridScreen(),
          ],
        ),
      ),
    );
  }
}

class ProjectsListOneNewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.gray200,
        body: SizedBox(
          width: size.width,
          child: SingleChildScrollView(
            child: Padding(
              padding: getPadding(
                left: 16,
                top: 25,
                right: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
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
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return index == 1
                            ? Dashboard1ItemWidgecompete()
                            : index == 3
                                ? Dashboard1ItemWidgecompete()
                                : index == 4
                                    ? Dashboard1ItemWidgepending()
                                    : Dashboard1ItemWidget();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({Key key}) : super(key: key);

  @override
  _ProjectScreenState createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  List<ProjectModel> _userModel = [];
  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    _userModel = (await ProjectController().getuserprofile());
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _userModel == null || _userModel.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _userModel.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(_userModel[index].id.toString()),
                          // Text(_userModel[index].details),
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Text(_userModel[index].user_status),
                          // Text(_userModel[index].admin_Status),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

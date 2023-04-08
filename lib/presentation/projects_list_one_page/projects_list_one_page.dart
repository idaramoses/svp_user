import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pk_skeleton/pk_skeleton.dart';
import 'package:svp_admin_pm/core/app_export.dart';
import 'package:svp_admin_pm/models/project.dart';
import 'package:svp_admin_pm/presentation/projects_list_one_page/widgets/listskylinebuilding_one_item_widget.dart';

import '../../widgets/custom_button.dart';
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
      child: Scaffold(
        backgroundColor: ColorConstant.gray200,
        body: Container(
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
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
              Container(
                height: getVerticalSize(
                  520,
                ),
                child: TabBarView(
                  controller: tabController,
                  //TODO: Please add tab controller
                  children: [
                    ProjectsListOneNewPage(),
                    ProjectsGridScreen(),
                  ],
                ),
              ),
            ],
          ),
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
                        return ListskylinebuildingOneItemWidget();
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

class ProjectsListTwoNewPage extends StatefulWidget {
  @override
  State<ProjectsListTwoNewPage> createState() => _ProjectsListTwoNewPageState();
}

class _ProjectsListTwoNewPageState extends State<ProjectsListTwoNewPage> {
  Future<List<Projects>> getRequest() async {
    //replace your restFull API here.
    String url = "https://jsonplaceholder.typicode.com/posts";
    final response = await http.get(Uri.parse(url));

    var responseData = json.decode(response.body);

    //Creating a list to store input data;
    List<Projects> users = [];
    for (var singleUser in responseData) {
      Projects user = Projects(
          id: singleUser["id"],
          ProjectsId: singleUser["userId"],
          title: singleUser["title"],
          body: singleUser["body"]);

      //Adding user to the list.
      users.add(user);
    }
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
        future: getRequest(),
        builder: (BuildContext ctx, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return loader();
          } else {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (ctx, index) => ListTile(
                title: Text(snapshot.data[index].title),
                subtitle: Text(snapshot.data[index].body),
                contentPadding: EdgeInsets.only(
                  bottom: 20.0,
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget loader() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return PKCardSkeleton();
      },
    );
  }
}

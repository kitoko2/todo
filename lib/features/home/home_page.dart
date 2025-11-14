import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:todo/commons/buttons/custom_button.dart';
import 'package:todo/core/theme/app_colors.dart';
import 'package:todo/utils/extension.dart';

class NotesSize {
  NotesSize._();
  static double cardSize = 200.0;
  static double newBtnSize = 250.0;
}

class HomePage extends StatefulWidget {
  static String routeName = "home";
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: DefaultTabController(
          length: 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Scaffold(
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButton(
                  text: "Nouvelle note",
                  width: NotesSize.newBtnSize,
                  prefix: Icon(Icons.add_box_rounded, color: Colors.white),
                ),
              ),
              // second scaffold pour les tabs views
              backgroundColor: AppColors.background,
              appBar: AppBar(
                backgroundColor: AppColors.background,
                centerTitle: false,
                leading: CircleAvatar(
                  backgroundColor: AppColors.primary500,
                  child: CircleAvatar(
                    radius: 25.0,
                    child: ClipOval(
                      child: Image.network(
                        "https://images.pexels.com/photos/3785079/pexels-photo-3785079.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                        width: 90,
                        height: 90,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                title: Text(
                  "Johny Johny ",
                  style: TextStyle(color: AppColors.black, fontSize: 18.0),
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(CupertinoIcons.search),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(CupertinoIcons.ellipsis),
                  ),
                ],
              ),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: Column(
                    children: [
                      4.verticalSpace,
                      Divider(color: AppColors.divider, thickness: 2),
                      TabBar(
                        controller: _tabController,
                        dividerColor: Colors.transparent,
                        indicatorColor: AppColors.primary600,
                        unselectedLabelColor: AppColors.neutral500,
                        tabs: const [
                          Tab(text: "Mes Notes"),
                          Tab(text: "Groupes"),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          physics: const BouncingScrollPhysics(),
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 22.0),
                              child: MasonryGridView.count(
                                crossAxisCount: 2,
                                mainAxisSpacing: 12,
                                crossAxisSpacing: 12,
                                physics: BouncingScrollPhysics(),
                                itemCount: 19,
                                itemBuilder: (context, index) {
                                  return Container(
                                    height: index.isEven
                                        ? NotesSize.cardSize
                                        : NotesSize.cardSize + 50,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: AppColors.card,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Center(child: Text("Groupes")),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

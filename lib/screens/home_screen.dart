import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

import 'package:taskmanagementapiapp/res/user_data.dart';
import 'package:taskmanagementapiapp/screens/taskscreen/cancelled_task.dart';
import 'package:taskmanagementapiapp/screens/taskscreen/complited_task_screen.dart';
import 'package:taskmanagementapiapp/screens/taskscreen/create_task_screen.dart';
import 'package:taskmanagementapiapp/screens/taskscreen/inprogress_task_screen.dart';
import 'package:taskmanagementapiapp/screens/taskscreen/new_task_screen.dart';
import 'package:taskmanagementapiapp/utils/colors.dart';

import '../utils/theme.dart';
import '../view_model/drawer_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  int _selectedIndex = 0;
  List taskscreen = [
    NewTaskScreen(),
    CancelledTaskScreen(),
    InProgressTaskScreen(),
    CompletedTaskScreen(),
  ];



  @override
  Widget build(BuildContext context) {
    final drawerViewModel = Provider.of<DrawerViewModel>(context,listen: false);
    Size size = MediaQuery.of(context).size;
    print("object");
    return Consumer<DrawerViewModel>(
        builder: (context,value,child) {
          return Stack(
            children: [
              AnimatedContainer(
                transform: Matrix4.translationValues(
                    drawerViewModel.xOffset2, drawerViewModel.yOffset2, 0)
                  ..scale(drawerViewModel.scaleFactor2),
                duration: const Duration(milliseconds: 250),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        drawerViewModel.drawerOpen ? 20 : 0),
                    color: Theme
                        .of(context)
                        .scaffoldBackgroundColor
                        .withOpacity(.6)
                ),
              ),
              AnimatedContainer(
                transform: Matrix4.translationValues(
                    drawerViewModel.xOffset, drawerViewModel.yOffset, 0)
                  ..scale(drawerViewModel.scaleFactor),
                duration: const Duration(milliseconds: 250),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        drawerViewModel.drawerOpen ? 20 : 0),
                    color: Theme
                        .of(context)
                        .scaffoldBackgroundColor
                ),
                padding: EdgeInsets.all(drawerViewModel.drawerOpen ? 20 : 0),
                child: Scaffold(
                    appBar: AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      leading: drawerViewModel.drawerOpen ?
                      InkWell(
                        child: Icon(Icons.arrow_back_ios_new, size: 35,),
                        onTap: () {
                          drawerViewModel.setCloseDrawer();
                        },
                      ) : InkWell(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: RotatedBox(
                              quarterTurns: 1,
                              child: Icon(Icons.bar_chart_rounded, size: 30,)
                          ),
                        ),
                        onTap: () {
                          drawerViewModel.setOpenDrawer(size);
                        },
                      ),
                      title: Text(
                        "${UserData.firstName ?? ''} ${UserData.lastName ??
                            ''}",),
                      centerTitle: true,
                    ),
                    body: taskscreen[_selectedIndex],
                    bottomNavigationBar: Container(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 10, top: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Theme
                                      .of(context)
                                      .bottomAppBarColor,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 20,
                                      color: Colors.black.withOpacity(.1),
                                    )
                                  ],
                                ),
                                child: SafeArea(
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: GNav(
                                      hoverColor: Colors.grey[100]!,
                                      gap: 3,
                                      activeColor: Colors.white,
                                      iconSize: 24,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 10),
                                      duration: const Duration(milliseconds: 400),
                                      tabBackgroundColor: Theme
                                          .of(context)
                                          .cardColor
                                          .withOpacity(.2),
                                      color: Theme
                                          .of(context)
                                          .focusColor,
                                      tabs: const [
                                        GButton(
                                          icon: Icons.paste_rounded,
                                          text: 'New',
                                        ),
                                        GButton(
                                          icon: Icons.ac_unit,
                                          text: 'In Progress',
                                        ),
                                        GButton(
                                          icon: Icons.cancel_outlined,
                                          text: 'Cancelled',
                                        ),
                                        GButton(
                                          icon: Icons.task_outlined,
                                          text: 'Completed',
                                        ),
                                      ],
                                      selectedIndex: _selectedIndex,
                                      onTabChange: (index) {
                                        setState(() {
                                          _selectedIndex = index;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => CreateTaskScreen()));
                              },
                              child: Container(
                                height: 55,
                                width: 50,
                                decoration: BoxDecoration(
                                    color: appPrimaryColor,
                                    borderRadius: BorderRadius.circular(15)
                                ),
                                child: Icon(Icons.add, color: Colors.white,),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                ),
              )
            ],
          );
        }
     );
  }
}

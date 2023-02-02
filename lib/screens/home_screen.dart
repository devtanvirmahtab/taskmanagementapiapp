import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:taskmanagementapiapp/screens/taskscreen/cancelled_task.dart';
import 'package:taskmanagementapiapp/screens/taskscreen/complited_task_screen.dart';
import 'package:taskmanagementapiapp/screens/taskscreen/create_task_screen.dart';
import 'package:taskmanagementapiapp/screens/taskscreen/inprogress_task_screen.dart';
import 'package:taskmanagementapiapp/screens/taskscreen/new_task_screen.dart';
import 'package:taskmanagementapiapp/utils/colors.dart';

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
    return Scaffold(
      body: taskscreen[_selectedIndex],
      bottomNavigationBar: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10,top: 10),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 20,
                        color: Colors.black.withOpacity(.1),
                      )
                    ],
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GNav(
                        hoverColor: Colors.grey[100]!,
                        gap:3,
                        activeColor: appPrimaryColor,
                        iconSize: 24,
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        duration: Duration(milliseconds: 400),
                        tabBackgroundColor: appPrimaryColor.withOpacity(.2),
                        color: appPrimaryColor,
                        tabs: const[
                          GButton(
                            icon: Icons.home,
                            text: 'Home',
                          ),
                          GButton(
                            icon: Icons.favorite,
                            text: 'In Progress',
                          ),
                          GButton(
                            icon: Icons.person,
                            text: 'Cancelled',
                          ),
                          GButton(
                            icon: Icons.search,
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
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> CreateTaskScreen()));
                },
                child: Container(
                  height: 55,
                  width: 50,
                  decoration: BoxDecoration(
                      color: appPrimaryColor,
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: Icon(Icons.add,color: Colors.white,),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}

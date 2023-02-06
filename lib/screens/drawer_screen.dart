import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:taskmanagementapiapp/res/user_data.dart';
import 'package:taskmanagementapiapp/screens/favorite_screen.dart';
import 'package:taskmanagementapiapp/screens/profile_screen.dart';
import 'package:taskmanagementapiapp/screens/taskscreen/inprogress_task_screen.dart';
import 'package:taskmanagementapiapp/screens/taskscreen/new_task_screen.dart';
import 'package:taskmanagementapiapp/utils/colors.dart';
import 'package:taskmanagementapiapp/utils/routes/routes_name.dart';
import 'package:taskmanagementapiapp/view_model/drawer_view_model.dart';

import '../view_model/drawer_view_model.dart';
import '../view_model/theme_changer_view_model.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {

  List drawerItem = [
    {"icon": Icons.home, "drawerTitle": "Home"},
    {"icon": Icons.home, "drawerTitle": "New Task"},
    {"icon": Icons.favorite, "drawerTitle": "Favorite"},
    {"icon": Icons.person, "drawerTitle": "Profile"}
  ];

  @override
  Widget build(BuildContext context) {
    final themeChanger = Provider.of<ThemeChanger>(context,listen: false);
    final drawerViewModel = Provider.of<DrawerViewModel>(context,listen: false);
    // print("rebuild");
    return Container(
      padding: EdgeInsets.all(30),
      color: Theme.of(context).bottomAppBarColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.all(0),
            leading: CircleAvatar(),
            title: Text(
              (UserData.firstName ?? "") + (" ") + (UserData.lastName ?? ""),
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            subtitle: Text(
              (UserData.email ?? ""),
              style: TextStyle(color: Colors.white54, fontSize: 15),
            ),
            trailing: Consumer(
              builder: (context,value,child){
                return IconButton(
                    icon: themeChanger.isLight
                        ? Icon(Icons.dark_mode)
                        : Icon(
                      Icons.sunny,
                      color: appPrimaryLightColor,
                    ),
                    onPressed: () {
                      themeChanger.iconPressed();
                      // setState(() {});
                    });
              }
            ),
          ),
          ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: drawerItem.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: ()async{
                  if(index == 0){
                    drawerViewModel.setCloseDrawer();
                  }else if(index == 1){
                    drawerViewModel.setCloseDrawer();
                  }else if(index == 2){
                    drawerViewModel.setCloseDrawer();
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>FavoriteScreen()));
                  }else if(index == 3){
                    drawerViewModel.setCloseDrawer();
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreen()));
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Icon(
                        drawerItem[index]["icon"],
                        size: 25,
                        color: appPrimaryLightColor,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        drawerItem[index]["drawerTitle"],
                        style: TextStyle(
                            color: appPrimaryLightColor.withOpacity(.8),
                            fontSize: 17,
                            fontWeight: FontWeight.w600
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
          TextButton(
            child:
              const Text(
                "Log out",
                style: TextStyle(color: appPrimaryLightColor, fontSize: 20),
              ),
              onPressed: () async{
                final sharePf = await SharedPreferences.getInstance();
                sharePf.clear();
                Navigator.pushNamedAndRemoveUntil(context, RoutesName.login, (route) => false);
              },
          )
        ],
      ),
    );
  }
}

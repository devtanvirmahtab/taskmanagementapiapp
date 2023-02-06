import 'package:flutter/material.dart';
import 'package:taskmanagementapiapp/utils/colors.dart';
import 'package:taskmanagementapiapp/utils/routes/routes.dart';
import 'package:taskmanagementapiapp/utils/routes/routes_name.dart';
import 'package:provider/provider.dart';
import 'package:taskmanagementapiapp/utils/theme.dart';
import 'package:taskmanagementapiapp/view_model/auth_view_model.dart';
import 'package:taskmanagementapiapp/view_model/drawer_view_model.dart';
import 'package:taskmanagementapiapp/view_model/get_taskdata_view_model.dart';
import 'package:taskmanagementapiapp/view_model/profile_update_view_model.dart';

import 'view_model/theme_changer_view_model.dart';


final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => GetTaskDataModel()),
        ChangeNotifierProvider(create: (_) => ThemeChanger()),
        ChangeNotifierProvider(create: (_) => DrawerViewModel()),
        ChangeNotifierProvider(create: (_) => ProfileUpdateViewModel()),
      ],
      child: Builder(
        builder: (BuildContext context) {
          final themeChanger = Provider.of<ThemeChanger>(context);
          return MaterialApp(
            navigatorKey: navigatorKey,
            title: 'Flutter Demo',
            themeMode: themeChanger.themeMode,
            theme: MyTheme.lightTheme(context),
            darkTheme: MyTheme.darkTheme(context),
            initialRoute: RoutesName.splash,
            onGenerateRoute: Routes.generateRoute,
          );
        }
      ),
    );
  }
}


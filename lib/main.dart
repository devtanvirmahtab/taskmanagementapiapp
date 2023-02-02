import 'package:flutter/material.dart';
import 'package:taskmanagementapiapp/utils/colors.dart';
import 'package:taskmanagementapiapp/utils/routes/routes.dart';
import 'package:taskmanagementapiapp/utils/routes/routes_name.dart';
import 'package:provider/provider.dart';
import 'package:taskmanagementapiapp/utils/theme.dart';
import 'package:taskmanagementapiapp/view_model/auth_view_model.dart';
import 'package:taskmanagementapiapp/view_model/get_taskdata_model.dart';


final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {



    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => GetTaskDataModel())
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Flutter Demo',
        themeMode: ThemeMode.dark,
        theme: MyTheme.lightTheme(context),
        darkTheme: MyTheme.darkTheme(context),
        initialRoute: RoutesName.splash,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}


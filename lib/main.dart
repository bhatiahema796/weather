import 'package:clemency/darktheme/darktheme_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:clemency/darktheme/darktheme_style.dart';
import 'package:clemency/screens/loading_screen.dart';
import 'screens/locations_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  darkthemeprovider themechangeprovider = darkthemeprovider();

  @override
  void initState() {
    super.initState();
    getcurrenttheme();
  }

  void getcurrenttheme() async {
    themechangeprovider.darktheme = await themechangeprovider.theme.gettheme();
    //TODO: GET THE AWAIT HERE
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => themechangeprovider,
      child: Consumer<darkthemeprovider>(
        builder: (BuildContext context, value, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: Styles.themeData(themechangeprovider.darktheme, context),
            home: loadingScreen(),
          );
        },
      ),
    );
  }
}

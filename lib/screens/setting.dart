import 'package:clemency/darktheme/darktheme_provider.dart';
import 'package:clemency/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'locations_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  bool isDarkModeEnabled = false;
    @override
    Widget build(BuildContext context) {
      final themeChange = Provider.of<darkthemeprovider>(context);
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            'Settings',
            style:TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return loadingScreen();
                },
              ));
            },
            child: Icon(
              Icons.arrow_back,
              color:Colors.white,
            ),
          ),
        ),
        body: SafeArea(
          child: SwitchListTile(
              value: themeChange.darktheme,
              activeColor: Color(0xFFc41a43),
              title: Text(
                'Dark Mode',
                style:TextStyle(
                    fontSize: 20.0, color: Color(0xFFc41a43)),
              ),
              onChanged: (value) {
                setState(() {
                  themeChange.darktheme = value;
                });
              }),
        ),
      );
    }
  }


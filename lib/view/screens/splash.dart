import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quotes_app/controller/theme_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
      Duration(seconds: 2),
      () {
        Navigator.pushReplacementNamed(context, "home");
      },
    );
    super.initState();
  }

  // @override
  // void didChangeDependencies() {
  //   SharedPreferences.getInstance().then((value) {
  //     var themeMode = value.getInt("themeMode");
  //     print("My Save Val $themeMode");
  //     Provider.of<ThemeProvider>(context, listen: false).changeTheme(themeMode ?? 0);
  //   });
  //   super.didChangeDependencies();
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Quotgram",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Awosome quotes for you",
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
                Image.asset(
                  "assets/images/1.png",
                  height: 350,
                  fit: BoxFit.cover,
                ),
                Text(
                  "Hang on..",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "We are fetching quotes for you",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

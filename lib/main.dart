import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quotes_app/controller/home_provider.dart';
import 'package:quotes_app/controller/theme_provider.dart';
import 'package:quotes_app/view/screens/detail.dart';
import 'package:quotes_app/view/screens/home.dart';
import 'package:quotes_app/view/screens/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeProvider(),
        )
      ],
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          // theme: ThemeData.light(),
          // darkTheme: ThemeData.dark(),
          // themeMode: Provider.of<ThemeProvider>(context).getThemeMode(),
          initialRoute: "/",
          routes: {
            "/": (context) => SplashScreen(),
            "home": (context) => HomePage(),
            "detail": (context) => DetailPage(),
          },
        );
      },
    );
  }
}

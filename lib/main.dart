import 'package:calender_event_app/pages/main_page.dart';
import 'package:calender_event_app/provider/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>EventProvider(),
      child: MaterialApp(
        title: 'Google Calender',
       debugShowCheckedModeBanner: false,
       themeMode: ThemeMode.dark,
       darkTheme: ThemeData.dark().copyWith(
         scaffoldBackgroundColor: Colors.black,
         accentColor: Colors.white,
         primaryColor: Colors.red,
       ),
       home: const MainPage(),
      ),
    );
  }
}



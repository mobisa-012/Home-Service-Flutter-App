import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:homeservice_app_ui/core/color.dart';
import 'package:homeservice_app_ui/screens/onboarding/pages/onboarding_page.dart';
import 'package:homeservice_app_ui/screens/tab_bar/pages/tab_bar_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized;
  await Firebase.initializeApp();
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final isLoggedIn = FirebaseAuth.instance.currentUser != null;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tasky',
      theme: ThemeData(
        textTheme: TextTheme(bodyText1: TextStyle(color: AppColors.textColor)),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.white
      ),
      home: isLoggedIn ? const TabBarPage() : const OnboardingPage()
    );
  }
}

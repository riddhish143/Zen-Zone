import 'package:final2/Screens/Login.dart';
import 'package:final2/Screens/LoginScreen.dart';
import 'package:final2/Screens/Splash.dart';
import 'package:final2/Screens/Supplier.dart';
import 'package:final2/Screens/Welcome.dart';
import 'package:final2/Screens/onBoarding.dart';
import 'package:final2/Screens/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Screens/CustomerHomeScreen.dart';
import 'Screens/OnBoarding1.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async
{
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  WidgetsFlutterBinding.ensureInitialized(
  );
  await Firebase.initializeApp(
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/Login_screen',
      routes: {
        '/Splash_screen': (context) => const SplashScreen(),
        '/OnBoarding_screen': (context) => onBoarding(),
        '/Welcome_screen': (context) => const WelcomeScreen(),
        '/Customer_screen': (context) => const CustomerHomeScreen(),
        '/Supplier_screen': (context) => const SupplierScreen(),
        '/Customer_register_screen' : (context) => const SignUpScreen(),
        '/Login_screen' : (context) => const loginScreen(),
      },
    );
  }
}

import 'dart:ui';
import 'package:final2/Minor_screen/ChangePassword.dart';
import 'package:final2/Screens/Explore.dart';
import 'package:final2/Screens/LoginScreen.dart';
import 'package:final2/Screens/Musicplayer.dart';
import 'package:final2/Screens/Profile.dart';
import 'package:final2/Screens/Splash.dart';
import 'package:final2/Screens/Supplier.dart';
import 'package:final2/Screens/Upload/Upload.dart';
import 'package:final2/Screens/Upload/Upload_pdf.dart';
import 'package:final2/Screens/Upload/Upload_product.dart';
import 'package:final2/Screens/Welcome.dart';
import 'package:final2/Screens/onBoarding.dart';
import 'package:final2/Screens/sign_up_page.dart';
import 'package:final2/auth/supplier_login.dart';
import 'package:final2/auth/supplier_signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'Minor_screen/ForgetEmail.dart';
import 'Provider/FavouriteProvider.dart';
import 'Screens/CustomerHomeScreen.dart';
import 'Screens/OnBoarding1.dart';
import 'package:firebase_core/firebase_core.dart';

import 'Screens/Upload/UploadPdf1.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((value) => runApp(const MyApp()));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Wish()),
      ],
      child: MaterialApp(
        title: 'Zen-Zone',
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
          // home: ChangePasswordScreen(),
        initialRoute: '/Welcome_screen',
        routes: {
          '/Splash_screen': (context) => const SplashScreen(),
          '/OnBoarding_screen': (context) => onBoarding(),
          '/Welcome_screen': (context) => const WelcomeScreen(),
          '/Customer_screen': (context) => const CustomerHomeScreen(),
          '/Supplier_screen': (context) => const SupplierScreen(),
          ProfileScreen.id : (context) =>  ProfileScreen(documentId: FirebaseAuth.instance.currentUser!.uid),
          SignUpScreen.id : (context) => const SignUpScreen(),
          loginScreen.id : (context) => const loginScreen(),
          SupplierSignUpScreen.id : (context) => const SupplierSignUpScreen(),
          SupplierloginScreen.id : (context) => const SupplierloginScreen(),
        },
      ),
    );
  }
}

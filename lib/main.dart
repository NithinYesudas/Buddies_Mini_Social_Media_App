import 'package:buddies/screens/splashScreen.dart';
import 'package:buddies/utils/custom_colors.dart';
import 'package:buddies/screens/auth_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const BuddiesApp());
}
class BuddiesApp extends StatelessWidget {
  const BuddiesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(

      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
          primaryColor: CustomColors.darkPrimary,accentColor: CustomColors.darkAccent),
      home: FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context,snapshot) {
          if(snapshot.connectionState == ConnectionState.done){
            return AuthScreen();

          }
          else{
            return
            SplashScreen();

          }

        }
      ),
    );
  }
}



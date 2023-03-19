import 'package:buddies/provider/post_provider.dart';
import 'package:buddies/provider/profile_provider.dart';
import 'package:buddies/provider/story_provider.dart';
import 'package:buddies/screens/auth/auth_pages.dart';
import 'package:buddies/screens/auth/login_screen.dart';
import 'package:buddies/screens/auth/signup_screen.dart';
import 'package:buddies/screens/chat_screens/chat_list_screen.dart';
import 'package:buddies/screens/home_tab_screens/home_screen.dart';
import 'package:buddies/screens/main_screen.dart';
import 'package:buddies/screens/splashScreen.dart';
import 'package:buddies/utils/custom_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const BuddiesApp());
}

class BuddiesApp extends StatelessWidget {
  const BuddiesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PostProvider>(create: (ctx) => PostProvider()),
        ChangeNotifierProvider<ProfileProvider>(
            create: (ctx) => ProfileProvider()),
        ChangeNotifierProvider<StoryProvider>(create: (ctx)=>StoryProvider())
      ],
      child: MaterialApp(
        routes: {
          "SignUpScreen": (ctx) => const SignUpScreen(),
          "LoginScreen": (ctx) => const LoginScreen(),
          "HomeScreen": (ctx) => const HomeScreen(),
          "MainScreen": (ctx) => const MainScreen(),
          "ChatScreen":(ctx)=> ChatScreen()
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            useMaterial3: true,
            primaryColor: CustomColors.darkPrimary,
            accentColor: CustomColors.darkAccent),
        home: FutureBuilder(
            future: Firebase.initializeApp(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return StreamBuilder(
                    stream: FirebaseAuth.instance.authStateChanges(),
                    builder: (ctx, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SplashScreen();
                      } else if (snapshot.hasData) {
                        return const MainScreen();
                      } else {
                        return const AuthPages();
                      }
                    });
              } else {
                return const SplashScreen();
              }
            }),
      ),
    );
  }
}

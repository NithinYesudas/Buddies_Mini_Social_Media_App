import 'dart:io';

import 'package:buddies/screens/home_screen.dart';
import 'package:buddies/screens/post_edit_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';

import '../utils/custom_colors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<AppBar> appbars = [
    AppBar(
      backgroundColor: Colors.white,
      title: Text(
        "Buddies",
        style: GoogleFonts.nunito(
            fontWeight: FontWeight.w900,
            color: CustomColors.lightAccent,
            fontSize: 20),
      ),
      actions: [
        IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon:  Icon(Ionicons.chatbox_ellipses,color: CustomColors.lightAccent,))
      ],
    ),
    AppBar(),
    AppBar(),
    AppBar(),
    AppBar(),
  ];

  List<Widget> screen = [
    HomeScreen(),
    Center(child: Text("hello")),
    SizedBox(),
    SizedBox(),
    SizedBox()
  ];

  int index = 0;
  XFile? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen[index],
      appBar: appbars[index],
      bottomNavigationBar: BottomNavigationBar(
        unselectedIconTheme: const IconThemeData(color: Colors.black),
        selectedIconTheme: IconThemeData(color: CustomColors.lightAccent),
        elevation: 10,
        currentIndex: index,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        type: BottomNavigationBarType.shifting,
        onTap: (val) {
          setState(() => index = val);
        },
        items: [
           BottomNavigationBarItem(
              icon: Icon( index == 0?Ionicons.home_sharp:
                Ionicons.home_outline,
              ),
              label: " "),
           BottomNavigationBarItem(
              icon: Icon(
                index == 1?Ionicons.search_sharp:
                Ionicons.search_outline,
              ),
              label: " "),
          BottomNavigationBarItem(
              icon: IconButton(
                  onPressed: () async {
                    try {
                      image = await ImagePicker()
                          .pickImage(source: ImageSource.gallery,imageQuality: 40);
                      if(image!=null) {
                        newPage();
                      }

                    } catch (e) {
                      print(e.toString());
                    }
                  },
                  icon: const Icon(
                    Ionicons.add_circle_outline,
                    size: 30,
                  )),
              label: " "),
          const BottomNavigationBarItem(
              icon: Icon(
                Ionicons.person_circle_outline,
              ),
              label: " "),
          const BottomNavigationBarItem(
              icon: Icon(
                Ionicons.settings_outline,
              ),
              label: " ")
        ],
      ),
    );
  }
  void newPage(){
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>PostEditScreen(image: File(image!.path))));
  }
}

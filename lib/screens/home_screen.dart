import 'package:buddies/component_widgets/homescreen_widgets/post.dart';
import 'package:buddies/utils/custom_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

import '../models/post_model.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  List<Post> posts = [
    Post(
        userId: "kSn4XZCDQLas2F6WtoTJMihh3Kf1",
        caption: "An amazing car",
        id: " aha",
        postTime: DateTime.now(),
        imageUrl:
            "https://stimg.cardekho.com/images/carexteriorimages/930x620/Lamborghini/Urus/4418/Lamborghini-Urus-V8/1621927166506/front-left-side-47.jpg",
        likes: [
          "kSn4XZCDQLas2F6WtoTJMihh3Kf1"
        ],
        comments: [
          Comment(userId: "kSn4XZCDQLas2F6WtoTJMihh3Kf1", comment: "comment")
        ]),
    Post(
        userId: "kSn4XZCDQLas2F6WtoTJMihh3Kf1",
        caption: "An amazing car",
        id: " aha",
        postTime: DateTime.now(),
        imageUrl:
            "https://images.drive.com.au/driveau/image/upload/c_fill,f_auto,g_auto,h_675,q_auto:good,w_1200/cms/uploads/bi36meqa62rhbghgdrkh",
        likes: [
          "ghhgjghjgjhghj"
        ],
        comments: [
          Comment(userId: "kSn4XZCDQLas2F6WtoTJMihh3Kf1", comment: "comment"),
          Comment(userId: "kSn4XZCDQLas2F6WtoTJMihh3Kf1", comment: "comment")
        ])
  ];

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Buddies",
          style: GoogleFonts.nunito(
              fontWeight: FontWeight.w900,
              color: CustomColors.darkPrimary,
              fontSize: mediaQuery.width * .06),
        ),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: const Icon(Ionicons.chatbox_ellipses))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(

        type: BottomNavigationBarType.shifting,
        items: [
          const BottomNavigationBarItem(
              icon: Icon(
                Ionicons.home_outline,
                color: Colors.black,
              ),
              label: " "),
          const BottomNavigationBarItem(
              icon: Icon(
                Ionicons.search_outline,
                color: Colors.black,
              ),
              label: " "),
          BottomNavigationBarItem(
              icon: ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(CircleBorder()),
                      elevation: MaterialStateProperty.all(5),
                      backgroundColor:
                          MaterialStateProperty.all(CustomColors.lightAccent)),
                  child: const Icon(
                    Ionicons.add_outline,
                    color: Colors.white,
                  )),
              label: " "),
          const BottomNavigationBarItem(
              icon: Icon(
                Ionicons.person_circle_outline,
                color: Colors.black,
              ),
              label: " "),
          const BottomNavigationBarItem(
              icon: Icon(
                Ionicons.settings_outline,
                color: Colors.black,
              ),
              label: " ")
        ],
      ),
      body: ListView.builder(
          itemCount: posts.length,
          itemBuilder: (ctx, index) {
            return Column(
              children: [
                PostWidget(post: posts[index]),
                const Divider(
                  color: Colors.black26,
                )
              ],
            );
          }),
    );
  }
}

import 'package:buddies/utils/custom_colors.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../component_widgets/profile_widgets/profile_head_section.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({required this.name, required this.userId, Key? key})
      : super(key: key);
  final String name, userId;
  final HttpsCallable isFollowing =
      FirebaseFunctions.instance.httpsCallable('isFollowing');
  final currentUserId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          leading: const SizedBox(),
          leadingWidth: 2,
          title: Text(
            name,
            style: GoogleFonts.nunitoSans(fontWeight: FontWeight.w800),
          ),
        ),
        body: Column(
          children: [
            ProfileHeadSection(
              userId: userId,
            ),
            SizedBox(height: mediaQuery.height*.02,),
            SizedBox(
              height: MediaQuery.of(context).size.height * .05,
              child: FutureBuilder(
                  future: isFollowing.call({
                    'currentUserId': currentUserId,
                    'selectedUserId': userId,
                  }),
                  builder: (ctx, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SizedBox();
                    } else {
                      final data = snapshot.data!.data;
                      return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              backgroundColor: CustomColors.lightAccent,
                              padding: EdgeInsets.symmetric(
                                vertical: 0,
                                  horizontal:
                                      MediaQuery.of(context).size.width*.3)),
                          onPressed: () {},
                          child: Text(
                            data ? "Unfollow" : "Follow",
                            style: GoogleFonts.nunitoSans(
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.width * .045,
                                color: Colors.white),
                          ));
                    }
                  }),
            )
          ],
        ));
  }
}

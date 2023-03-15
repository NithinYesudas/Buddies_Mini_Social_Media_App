import 'package:buddies/utils/custom_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileHeadSection extends StatelessWidget {
  ProfileHeadSection({required this.userId, Key? key}) : super(key: key);
  final String userId;


  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return FutureBuilder(
        future:
            FirebaseFirestore.instance.collection("users").doc(userId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox();
          }
          final data = snapshot.data!.data();
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: mediaQuery.width * .03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: mediaQuery.height * .08,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(data!["imageUrl"]),
                        radius: mediaQuery.width * .09,
                      ),
                      Text(
                        "Posts\n   ${data["postCount"]}",
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w700,
                            fontSize: mediaQuery.width * .04),
                      ),
                      Text(
                        "Following\n     ${data["followingCount"]}",
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w700,
                            fontSize: mediaQuery.width * .04),
                      ),
                      Text(
                        "Followers\n      ${data["followersCount"]}",
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w700,
                            fontSize: mediaQuery.width * .04),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  data['name'],
                  style: GoogleFonts.nunitoSans(
                      fontWeight: FontWeight.w700,
                      fontSize: mediaQuery.width * .05),
                ),
                Text(
                  data["bio"],
                  style: GoogleFonts.nunitoSans(
                      fontWeight: FontWeight.w600,
                      fontSize: mediaQuery.width * .04),
                ),
                const SizedBox(
                  height: 10,
                ),


              ],
            ),
          );
        });
  }
}

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/custom_colors.dart';
class MutualFollowersList extends StatelessWidget {
   MutualFollowersList({required this.selectedUserId,Key? key}) : super(key: key);
  final HttpsCallable findMutualFollowers =
  FirebaseFunctions.instance.httpsCallable('getMutualFollowers');
  final currentUserId = FirebaseAuth.instance.currentUser!.uid;
  final String selectedUserId;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return  SizedBox(
      height: mediaQuery.height * .04,
      child: FutureBuilder(
          future: findMutualFollowers.call({
            'currentUserId': currentUserId,
            'selectedUserId': selectedUserId,
          }),
          builder: (ctx, snapshot) {
            final result = snapshot.data;
            if (snapshot.connectionState ==
                ConnectionState.waiting ||
                result == null) {
              return const SizedBox();
            }

            final data = result.data;

            return SizedBox(
              width: mediaQuery.width,
              child: Row(
                children: [
                  Text(
                    "Followed by: ",
                    style: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.w700),
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage:
                        NetworkImage(data[0]["imageUrl"]),
                      ),
                      Text(data[0]["name"],
                          style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.w700)),
                      data.length > 1
                          ? Text(
                        " and ${data.length} others",
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w700,
                            color: CustomColors.lightAccent),
                      )
                          : const SizedBox()
                    ],
                  )
                ],
              ),
            );
          }),
    );
  }
}

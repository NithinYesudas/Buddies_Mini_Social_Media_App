import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PostHeadWidget extends StatelessWidget {
  const PostHeadWidget({required this.userId, Key? key}) : super(key: key);
  final String userId;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return FutureBuilder(
        future:
            FirebaseFirestore.instance.collection("users").doc(userId).get(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(height: mediaQuery.height * .06);
          }
          final data = snapshot.data!.data();
          String name = data!['name'];
          return SizedBox(
            height: mediaQuery.height * .06,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 18,
                backgroundImage: NetworkImage(data["imageUrl"]),
              ),
              title: Text(
                name,
                style: GoogleFonts.nunitoSans(fontWeight: FontWeight.w700),
              ),
              trailing: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_vert_rounded),
              ),
            ),
          );
        });
  }
}

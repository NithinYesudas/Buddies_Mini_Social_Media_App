import 'package:buddies/provider/profile_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../services/follow_services.dart';
import '../../utils/custom_colors.dart';

class FollowButton extends StatefulWidget {
  const FollowButton({required this.userId, Key? key}) : super(key: key);
  final String userId;

  @override
  State<FollowButton> createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {
  final currentUserId = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<ProfileProvider>(context, listen: false)
        .getIsFollowing(widget.userId, currentUserId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height * .05,
        width: MediaQuery.of(context).size.width*.9,
        child: Consumer<ProfileProvider>(builder: (context, data, child) {
          bool isFollowed = data.isFollowing;
          return ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  backgroundColor: CustomColors.lightAccent,
                  padding: EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: MediaQuery.of(context).size.width * .3)),
              onPressed: () {
                var result = FollowServices.followUnfollow(
                        isFollowed, widget.userId, context)
                    .whenComplete(() => null);
                result.then((value) {
                  data.getIsFollowing(widget.userId, currentUserId);
                });
              },
              child: Text(
                isFollowed ? "Unfollow" : "Follow",
                style: GoogleFonts.nunitoSans(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width * .045,
                    color: Colors.white),
              ));
        }));
  }
}

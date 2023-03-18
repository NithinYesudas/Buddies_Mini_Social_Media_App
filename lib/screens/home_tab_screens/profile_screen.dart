import 'package:buddies/component_widgets/profile_widgets/follow_button.dart';
import 'package:buddies/component_widgets/profile_widgets/mutual_followers_list.dart';
import 'package:buddies/component_widgets/profile_widgets/post_list_widget.dart';
import 'package:buddies/provider/profile_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../component_widgets/profile_widgets/profile_head_section.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({required this.userId, Key? key}) : super(key: key);
  final String userId;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<ProfileProvider>(context, listen: false)
        .fetchUserDetails(widget.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;


    return Scaffold(
        appBar: AppBar(
          actions: [
            widget.userId== currentUserId?IconButton(onPressed: (){
              FirebaseAuth.instance.signOut();
            }, icon: const Icon(Icons.more_vert_rounded,color: Colors.black,)):SizedBox()
          ],
          leading: const SizedBox(),
          leadingWidth: 2,
          title: Consumer<ProfileProvider>(builder: (context, data, child) {
            final user = data.getSelectedUser;

            return Text(
              user != null ? user.name : " ",

              style: GoogleFonts.nunitoSans(fontWeight: FontWeight.w800),
            );
          }),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ProfileHeadSection(
                userId: widget.userId,
              ),
              SizedBox(
                height: mediaQuery.height * .02,
              ),
              if (widget.userId != currentUserId)
                MutualFollowersList(selectedUserId: widget.userId),
              SizedBox(
                height: mediaQuery.height * .01,
              ),
              if (widget.userId != currentUserId)
              FollowButton(userId: widget.userId),
              SizedBox(
                height: mediaQuery.height * .01,
              ),
              SizedBox(
                height: mediaQuery.height * .01,
              ),
              PostList(selectedUserId: widget.userId)
            ],
          ),
        ));
  }
}

import 'package:buddies/component_widgets/homescreen_widgets/comment_sheet.dart';
import 'package:buddies/services/post_services.dart';
import 'package:buddies/utils/custom_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';

import '../../models/post_model.dart';

class LikesAndCommentWidget extends StatefulWidget {
  const LikesAndCommentWidget({required this.post, Key? key}) : super(key: key);
  final Post post;

  @override
  State<LikesAndCommentWidget> createState() => _LikesAndCommentWidgetState();
}

class _LikesAndCommentWidgetState extends State<LikesAndCommentWidget> {
  final uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    return SizedBox(
      height: mediaQuery.height * .135,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: mediaQuery.height * .048,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FutureBuilder(
                    future: PostServices.getIsLiked(
                        selectedUserId: widget.post.userId,
                        postId: widget.post.postId),
                    builder: (context, snapshot) {
                      bool isLiked = widget.post.isLiked;
                      if (snapshot.connectionState == ConnectionState.done) {
                        isLiked = snapshot.data as bool;
                      }

                      return IconButton(
                          onPressed: () {
                            final result = PostServices.likeDislike(
                                    widget.post.userId,
                                    widget.post.postId,
                                    !isLiked,
                                    context)
                                .whenComplete(() => null);
                            result.then((value) => setState(() {}));
                          },
                          icon: Icon(
                            isLiked
                                ? Ionicons.heart_sharp
                                : Ionicons.heart_outline,
                            color: isLiked ? Colors.red : Colors.black,
                          ));
                    }),
                IconButton(
                    onPressed: () {
                      CommentSheet.openModalBottomSheet(context, widget.post);
                    },
                    icon: const Icon(Ionicons.chatbubble_outline)),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Ionicons.bookmark_outline)),
                const Expanded(child: SizedBox()),
                Text(
                  DateFormat.MMMd().format(widget.post.createdAt),
                  style: GoogleFonts.nunitoSans(fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  width: 10,
                )
              ],
            ),
          ),
          //Divider(height: 2,color: Colors.black26,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: mediaQuery.width * .03),
            height: mediaQuery.height * .056,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.post.likesCount < 2
                      ? "${widget.post.likesCount} like"
                      : "${widget.post.likesCount.toString()} likes",
                  style: GoogleFonts.nunitoSans(fontWeight: FontWeight.w800),
                ),
                TextButton(
                  onPressed: () {
                    CommentSheet.openModalBottomSheet(context, widget.post);
                  },
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.zero)),
                  child: Text(
                    widget.post.commentsCount == 0
                        ? " "
                        : widget.post.commentsCount < 2
                            ? "View ${widget.post.commentsCount} comment"
                            : "View all ${widget.post.commentsCount} comments",
                    style: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.w800,
                        color: CustomColors.lightAccent),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "Caption: ${widget.post.caption}",
              style: GoogleFonts.nunitoSans(
                  color: Colors.black, fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }
}

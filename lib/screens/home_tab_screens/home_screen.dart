import 'package:buddies/component_widgets/homescreen_widgets/post.dart';
import 'package:buddies/provider/post_provider.dart';
import 'package:buddies/utils/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

import '../../models/post_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<PostProvider>(context, listen: false).fetchFollowingPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                Navigator.of(context).pushNamed("ChatScreen");
              },
              icon: Icon(
                Ionicons.chatbox_ellipses,
                color: CustomColors.lightAccent,
              ))
        ],
      ),
      body: Selector<PostProvider, List<Post>>(
          selector: (_, myPostProvider) => myPostProvider.getFollowingPosts,
          builder: (context, getFollowingPosts, child) {
            if (getFollowingPosts.isEmpty) {
              return Center(
                child: Text(
                  "Follow some people to see their posts",
                  style: GoogleFonts.nunitoSans(fontWeight: FontWeight.w700),
                ),
              );
            }
            List<Post> posts = getFollowingPosts;

            return RefreshIndicator(
              color: CustomColors.lightAccent,
              onRefresh: Provider.of<PostProvider>(context, listen: false)
                  .fetchFollowingPosts,
              child: (ListView.builder(
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
                  })),
            );
          }),
    );
  }
}

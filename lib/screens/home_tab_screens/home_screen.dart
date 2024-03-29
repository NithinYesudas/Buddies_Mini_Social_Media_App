import 'package:buddies/component_widgets/homescreen_widgets/post.dart';
import 'package:buddies/provider/post_provider.dart';
import 'package:buddies/provider/story_provider.dart';
import 'package:buddies/utils/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import '../../component_widgets/homescreen_widgets/story_widget.dart';
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
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.lightAccent,
        title: Text(
          "Buddies",
          style: GoogleFonts.nunito(
              fontWeight: FontWeight.w900,
              color: Colors.white,
              fontSize: 20),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed("ChatScreen");
              },
              icon: const Icon(
                Ionicons.chatbox_ellipses,
                color: Colors.white,
              ))
        ],
      ),
      body: Column(
        children: [
          const StoryWidget(),
         const Divider(thickness: 3,),
          Expanded(
            child: Selector<PostProvider, List<Post>>(
                selector: (_, postProvider) => postProvider.getFollowingPosts,
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
                    onRefresh: ()async{
                      Provider.of<PostProvider>(context, listen: false)
                          .fetchFollowingPosts;
                      Provider.of<StoryProvider>(context,listen: false).fetchStories();
                      Provider.of<StoryProvider>(context,listen: false).getMyyStory();
                    },
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
          ),
         
        ],
      ),
    );
  }
}

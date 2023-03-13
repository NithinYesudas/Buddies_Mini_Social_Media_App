import 'package:buddies/component_widgets/homescreen_widgets/post.dart';
import 'package:buddies/provider/post_provider.dart';
import 'package:buddies/utils/custom_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

import '../models/post_model.dart';

class HomeScreen extends StatefulWidget {
    HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 List<Post> posts = PostProvider().getPosts;
 @override
  void initState() {
   PostProvider().fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

          return ListView.builder(
              itemCount:posts.length,
              itemBuilder: (ctx, index) {
                return Column(
                  children: [
                    PostWidget(post: posts[index]),
                    const Divider(
                      color: Colors.black26,
                    )
                  ],
                );
              });

      }
}


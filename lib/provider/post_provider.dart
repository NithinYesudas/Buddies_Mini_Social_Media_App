import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../models/post_model.dart';

class PostProvider extends ChangeNotifier {
   List<Post> _posts = [];

  List<Post> get getPosts {
    return _posts;
  }

   Future<List<Post>> fetchProducts() async {
    try {
      final HttpsCallable getFollowingPostsCallable =
          FirebaseFunctions.instance.httpsCallable('getFollowingPosts');

      final result = await getFollowingPostsCallable.call();
      final postList = result.data;


     _posts = postList.map((post)=>Post(
          userId: post["userId"],
          id: "id",
          imageUrl: post["imageUrl"],
          caption: post["caption"],
          likes: [],
          createdAt: DateTime.now(),
          comments: [])).toList();
     await FirebaseFirestore.instance.collection("users").get();

     return _posts;


    } on FirebaseException catch (e) {
      print("an error occured${e.message}");
      return [];
    }

  }
}

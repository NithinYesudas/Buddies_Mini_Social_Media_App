import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/cupertino.dart';

import '../models/post_model.dart';

class PostProvider extends ChangeNotifier {
  List<Post> _followingPosts = [];
  List<Post> _userPosts = [];

  List<Post> get getUserPosts {
    return _userPosts;
  }

  List<Post> get getFollowingPosts {
    return _followingPosts;
  }

  Future<void> fetchFollowingPosts() async {
    try {
      final HttpsCallable getFollowingPostsCallable =
          FirebaseFunctions.instance.httpsCallable('getFollowingPosts');

      final result = await getFollowingPostsCallable.call();
      final postList = result.data;
      final List<Post> loadedPosts = [];
      postList.forEach((post) {
        loadedPosts.add(Post(
            userId: post["userId"],
            id: "id",
            imageUrl: post["imageUrl"],
            caption: post["caption"],
            likes: ["jhdkjkdjfkd"],
            createdAt: DateTime.parse(post["createdAt"]),
            comments: [Comment(userId: "dhdhhd", comment: "comment")]));
      });

      _followingPosts = loadedPosts;

      print(_followingPosts);
      notifyListeners();
    } on FirebaseException catch (e) {
      print("an error occured${e.message}");
    }
  }

  Future<void> fetchUserPosts(String userId) async {
    final ref = FirebaseFirestore.instance;
    final result =
        await ref.collection("posts").doc(userId).collection("images").get();
    final postList = result.docs;
    final List<Post> loadedPosts = [];
    for (var element in postList) {
      final data = element.data();
      loadedPosts.add(Post(
          userId: data['userId'],
          id: 'id',
          imageUrl: data["imageUrl"],
          caption: data["caption"],
          likes: ["dfdjfdkjfdk"],
          createdAt: DateTime.parse(data["createdAt"]),
          comments: [Comment(userId: "userId", comment: "comment")]));
    }
    _userPosts = loadedPosts;
    notifyListeners();
  }
}

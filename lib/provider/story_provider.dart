import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../models/story_model.dart';

class StoryProvider extends ChangeNotifier {
  List<Story> _stories = [];
  Story? myStory;

  List<Story> get getStories {
    return _stories;
  }

  Future<void> fetchStories() async {
    try {
      final HttpsCallable getFollowingPostsCallable =
          FirebaseFunctions.instance.httpsCallable('getFollowingStories');
      final result = await getFollowingPostsCallable.call();
      final storyList = result.data;
      List<Story> loadedStories = [];
      storyList.forEach((story) {
        loadedStories.add(Story(
            userId: story["userId"],
            imageUrl: story["imageUrl"],
            createdAt: DateTime.parse(story["createdAt"])));
      });
      _stories = loadedStories;
      notifyListeners();
    } on FirebaseException catch (e) {
      print(e.message);
    } catch (e) {
      print(e);
    }
  }

  Future<void> getMyyStory() async {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;
    final result = await FirebaseFirestore.instance
        .collection("stories")
        .doc(currentUserId)
        .collection('images')
        .get();
    if (result.docs.isNotEmpty) {
      final story = result.docs[0].data();
      myStory = Story(
          userId: story["userId"],
          createdAt: DateTime.parse(story["createdAt"]),
          imageUrl: story["imageUrl"]);
    }
    else{
      myStory = null;
    }
  }
}

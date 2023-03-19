import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StoryServices {
  static Future<void> uploadStory(File image) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final reference = FirebaseStorage.instance;

    final fileName = "${const Uuid().v1()}.jpg";
    TaskSnapshot details = await reference
        .ref()
        .child("stories/$uid/$fileName")
        .putFile(image)
        .whenComplete(() {});
    if (details.state == TaskState.success) {
      final imageUrl = await details.ref.getDownloadURL();
      await FirebaseFirestore.instance.collection("stories")
          .doc(uid)
          .collection("images")
          .add(
          {"userId": uid,
            "imageUrl": imageUrl,
            "createdAt": DateTime.now().toIso8601String()
          });
    }
  }
}
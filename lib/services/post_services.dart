import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

import '../utils/accessory_widgets.dart';

class PostServices {
  static Future<bool> uploadPost(
      File image, String caption, BuildContext ctx) async {
    bool isSuccessful = false;
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final reference = FirebaseStorage.instance;

      final fileName = "${const Uuid().v1()}.jpg";
      TaskSnapshot details = await reference
          .ref()
          .child("posts/$uid/$fileName")
          .putFile(image)
          .whenComplete(() {});
      if (details.state == TaskState.success) {
        isSuccessful = true;
        final imageUrl = await details.ref.getDownloadURL();
        await FirebaseFirestore.instance
            .collection("posts")
            .doc(uid)
            .collection("images")
            .add({
          "userId": uid,
          "imageUrl": imageUrl,
          "caption": caption,
          "createdAt": DateTime.now()
        });
      }
    } on FirebaseException catch (e) {
      isSuccessful = false;
      AccessoryWidgets.snackBar('FirebaseException while uploading file', ctx);
      // Handle FirebaseException
    } on IOException catch (e) {
      isSuccessful = false;
      AccessoryWidgets.snackBar('IOException while uploading file', ctx);
      // Handle IOException
    } catch (e) {
      isSuccessful = false;
      AccessoryWidgets.snackBar('An Unknown error occured', ctx);
      // Handle other exceptions
    }
    return isSuccessful;
  }
}

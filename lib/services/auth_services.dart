import 'package:buddies/utils/accessory_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthServices {

  static Future<bool> login(String email, String password,
      BuildContext ctx) async {
    bool isSuccessful = true;
    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Do something with the userCredential
    } on FirebaseAuthException catch (e) {
      isSuccessful = false;
      String? message;
      if (e.code.contains("user-not-found")) {
        message = "User not found";
      } else {
        message = e.code;
      }
      AccessoryWidgets.snackBar(message, ctx);
      isSuccessful = false;
    } on PlatformException catch (e) {
      AccessoryWidgets.snackBar("An error occurred", ctx);
    } on Exception catch (e) {
      isSuccessful = false;
      AccessoryWidgets.snackBar("An error occurred", ctx);
    }
    return isSuccessful;
  }

  static Future<bool> createAccount(String email, String password,BuildContext ctx) async {
     bool isSuccessful = true;
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email, password: password);


    }
    on FirebaseAuthException catch(e){
      AccessoryWidgets.snackBar(e.code, ctx);
      isSuccessful = false;
    }
    catch(error){
      AccessoryWidgets.snackBar("An error occured", ctx);
      isSuccessful = false;
    }
    return isSuccessful;
  }
}

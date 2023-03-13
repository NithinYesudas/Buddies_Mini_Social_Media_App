import 'dart:io';

import 'package:buddies/services/post_services.dart';
import 'package:buddies/utils/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

class PostEditScreen extends StatefulWidget {
  PostEditScreen({required this.image, Key? key}) : super(key: key);
  final File image;

  @override
  State<PostEditScreen> createState() => _PostEditScreenState();
}

class _PostEditScreenState extends State<PostEditScreen> {
  final TextEditingController _controller = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 0,
        leading: SizedBox(),
        backgroundColor: CustomColors.lightAccent,
        title: Text(
          "Preview",
          style: GoogleFonts.nunitoSans(
              fontWeight: FontWeight.w900,
              fontSize: mediaQuery.width * .055,
              color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: mediaQuery.height * .65,
              width: mediaQuery.width,
              child: Image.file(
                widget.image,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: mediaQuery.height * .03,
            ),
            SizedBox(
              height: mediaQuery.height * .1,
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: mediaQuery.width * .05),
                child: TextField(
                  controller: _controller,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  textInputAction: TextInputAction.newline,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 30),
                      prefixIcon: Icon(
                        Ionicons.chatbox_outline,
                        color: CustomColors.lightAccent,
                      ),
                      hintText: "Add a Caption",
                      hintStyle: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.w600, color: Colors.black38),
                      fillColor: Colors.black12,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none)),
                ),
              ),
            ),
            SizedBox(
              height: mediaQuery.height * .03,
            ),
            ElevatedButton(
                onPressed: () async {
                  setState(() => isLoading = true);
                  bool isSuccessful = await PostServices.uploadPost(
                      widget.image, _controller.text, context);
                  isLoading = false;
                  if (isSuccessful) {
                    newPage();
                  } else {
                    setState(() {});
                  }
                },
                style: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(horizontal: mediaQuery.width * .1),
                    backgroundColor: CustomColors.lightAccent,
                    foregroundColor: Colors.white),
                child: isLoading
                    ? const CircularProgressIndicator(
                        strokeWidth: 2, color: Colors.white)
                    : Text(
                        "Post",
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w600,
                            fontSize: mediaQuery.width * .04),
                      ))
          ],
        ),
      ),
    );
  }

  void newPage() {
    Navigator.of(context).pop();
  }
}

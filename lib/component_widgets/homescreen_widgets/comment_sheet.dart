import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

import '../../models/post_model.dart';
import '../../utils/custom_colors.dart';

class CommentSheet{
  static void openModalBottomSheet(BuildContext context,Post post) {
    final TextEditingController controller = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height*.5,
          padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width*.7,
                child: TextField(
                  controller: controller,

                  decoration: InputDecoration(
                      contentPadding:
                      const EdgeInsets.symmetric(vertical: 10),
                      prefixIcon: Icon(
                        Ionicons.mail_outline,
                        color: CustomColors.lightAccent,
                      ),
                      hintText: "Add a Comment",
                      hintStyle: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.w600,
                          color: Colors.black38),
                      fillColor: Colors.black12,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none)),
                ),
              ),

              ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(CustomColors.lightAccent)),
                onPressed: () {},
                child: const Icon(Ionicons.send_outline,color: Colors.white,),
              ),
            ],
          ),
        );
      },
    );


  }
}
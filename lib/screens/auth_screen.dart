import 'package:buddies/helpers/auth/validators.dart';
import 'package:buddies/services/auth_services.dart';
import 'package:buddies/utils/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: mediaQuery.height * .15,
            ),
            SizedBox(
              height: mediaQuery.height * .3,
              width: mediaQuery.width * .5,
              child: Image.asset(
                "assets/images/login.jpg",
                fit: BoxFit.cover,
              ),
            ),
            Text(
              "Welcome Back.!",
              style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.bold,
                  fontSize: mediaQuery.width * .06),
            ),
            Text(
              "Login to your account and get started.",
              style: GoogleFonts.nunitoSans(
                  color: CustomColors.darkAccent,
                  fontSize: mediaQuery.width * .04),
            ),
            SizedBox(
              height: mediaQuery.height * .04,
            ),
            Form(
                key: _formKey,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: mediaQuery.width * .05),
                  height: mediaQuery.height * .32,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextFormField(
                        controller: _emailController,
                        validator: (value) {
                          return AuthValidators.emailValidator(value!);
                        },
                        style: GoogleFonts.nunitoSans(),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 15),
                            prefixIcon: Icon(
                              Ionicons.mail_outline,
                              color: CustomColors.lightAccent,
                            ),
                            hintText: "Email",
                            hintStyle: GoogleFonts.nunitoSans(
                                fontWeight: FontWeight.w600,
                                color: Colors.black38),
                            fillColor: Colors.black12,
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none)),
                      ),
                      TextFormField(
                        controller: _passwordController,
                        style: GoogleFonts.nunitoSans(),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) {
                          return AuthValidators.passwordValidator(value!);
                        },
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 5),
                            prefixIcon: Icon(
                              Ionicons.lock_closed_outline,
                              color: CustomColors.lightAccent,
                            ),
                            hintText: "Password",
                            hintStyle: GoogleFonts.nunitoSans(
                                fontWeight: FontWeight.w600,
                                color: Colors.black38),
                            fillColor: Colors.black12,
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: mediaQuery.width * .5),
                        child: Text(
                          "Forgot Password?",
                          textAlign: TextAlign.end,
                          style: GoogleFonts.nunitoSans(
                              color: Colors.black, fontWeight: FontWeight.w700),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            bool? isValid = _formKey.currentState?.validate();

                            if (isValid!) {
                              AuthServices.login(_emailController.text.trim(),
                                  _passwordController.text.trim());
                            }
                          },
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(
                                      horizontal: mediaQuery.width * .125,
                                      vertical: mediaQuery.height * .015)),
                              backgroundColor: MaterialStateProperty.all(
                                  CustomColors.darkAccent)),
                          child: Text(
                            "Login",
                            style: GoogleFonts.nunitoSans(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: mediaQuery.width * .04),
                          ))
                    ],
                  ),
                )),
            SizedBox(
              height: mediaQuery.height * .03,
            ),
            SizedBox(
              height: mediaQuery.height * .05,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: GoogleFonts.nunitoSans(),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        "Sign-Up",
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w800,
                            color: CustomColors.lightAccent),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

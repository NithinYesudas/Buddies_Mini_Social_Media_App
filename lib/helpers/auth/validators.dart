class AuthValidators {
  static String? emailValidator(String email) {
    if (email.isEmpty || !email.contains("@") || email.length < 5) {
      return "Enter a valid e-mail";
    } else {
      return null;
    }
  }
  static String? passwordValidator(String password){
    if(password.isEmpty || password.length<8){
      return "Password is too short or empty";
    }
    else{
      return null;
    }
  }
}

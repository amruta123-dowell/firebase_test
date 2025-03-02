class Validators {
  String? validateEmail(String email) {
    if (validateText(email) != null) {
      return "Email should not be empty";
    } else if (email.isNotEmpty) {
      bool isValidMail = RegExp(
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
          .hasMatch(email);
      if (!isValidMail) {
        return "Invalid email format";
      }
    }
    return null;
  }

  String? validatePassword(String pass) {
    bool validatePass =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
            .hasMatch(pass);
    if (!validatePass) {
      return "The password must be at least 8 characters long and include uppercase letters, numbers, and special characters.";
    }
    return null;
  }

  String? validateText(String value) {
    if (value.isEmpty) {
      return "This field is required";
    }
    return null;
  }
}

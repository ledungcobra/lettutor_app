String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return "Please input email";
  }
  if (!RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(value)) {
    return "Invalid Email";
  }
  return null;
}

String? validatePassword(String? value) {
  // TODO: implement validation password
  return null;
}

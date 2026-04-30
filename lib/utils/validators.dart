class Validators {
  static bool isValidEmail(String email) {
    return RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(email);
  }

  static bool isStrongPassword(String password) {
    final hasLetter = RegExp(r"[A-Za-z]").hasMatch(password);
    final hasNumber = RegExp(r"\d").hasMatch(password);
    return password.length >= 8 && hasLetter && hasNumber;
  }
}

/// # Validators (Folder: helpers).
/// Checks if the provided [email] is valid based on a regular expression pattern.
///
/// The [emailValid] function uses a regular expression pattern to determine if the provided [email]
/// is valid according to common email format rules. It returns true if the email is valid and false otherwise.
///
/// Example usage:
/// ```dart
/// final isValid = emailValid('example@email.com');
/// print(isValid); // Output: true
/// ```
///
/// Parameters:
/// - [email]: The email string to be validated.
///
/// Returns:
/// - A boolean value indicating whether the email is valid or not.
bool emailValid(String email) {
  final RegExp regex =
      RegExp(r"^(([^<>()[\]\\.,;:\s@\']+(\.[^<>()[\]\\.,;:\s@\']+)*)|(\'.+\'))@((\[[0-9]"
          r"{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$");

  return regex.hasMatch(email);
}

/// Validator function to check if a [text] string is empty or null.
///
/// The [emptyValidator] function checks if the provided [text] is empty or null by trimming leading and trailing spaces.
/// If the text is empty or null, it returns a validation error message; otherwise, it returns null, indicating no error.
///
/// Example usage:
/// ```dart
/// final errorMessage = emptyValidator('');
/// print(errorMessage); // Output: 'Campo Obrigatório'
/// ```
///
/// Parameters:
/// - [text]: The text string to be validated for emptiness.
///
/// Returns:
/// - A string containing an error message if the text is empty or null, otherwise null.
String? emptyValidator(String? text) => text!.trim().isEmpty ? 'Campo Obrigatório' : null;

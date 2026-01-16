import '../config/auth_enum.dart';

AuthenticationResponses validatePassword(String password) {
  const minLength = 8;
  const specialCharacters = r'!@#$%^&*(),.?":{}|<>';

  if (password.length < minLength) {
    return AuthenticationResponses.lessThanMinLength;
  }

  if (!password.contains(RegExp(r'[A-Z]'))) {
    return AuthenticationResponses.noUppercase;
  }

  if (!password.contains(RegExp(r'[0-9]'))) {
    return AuthenticationResponses.noDigit;
  }

  if (!password.contains(RegExp('[$specialCharacters]'))) {
    return AuthenticationResponses.noSpecialCharacter;
  }

  // Optional: reject unsupported special chars
  if (password.contains(RegExp(r'[^\w!@#$%^&*(),.?":{}|<>]'))) {
    return AuthenticationResponses.invalidSpecialCharacter;
  }

  return AuthenticationResponses.success;
}

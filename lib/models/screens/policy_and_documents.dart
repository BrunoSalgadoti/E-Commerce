import 'package:brn_ecommerce/models/users/users.dart';
import 'package:flutter/material.dart';

class PolicyAndDocuments extends ChangeNotifier {
  Users? users;

  bool _agreedToPolicyTerms = false;
  bool _agreedToTermsOfService = false;

  bool get agreedToPolicyTerms => _agreedToPolicyTerms;

  bool get agreedToTermsOfService => _agreedToTermsOfService;

  void setAgreedToPolicyTerms(bool value) {
    _agreedToPolicyTerms = value;
    notifyListeners();
  }

  void setAgreedToTermsOfService(bool value) {
    _agreedToTermsOfService = value;
    notifyListeners();
  }
}

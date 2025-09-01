import 'package:brn_ecommerce/models/users/users.dart';
import 'package:flutter/material.dart';

/// # PolicyAndDocuments (Folder: models/views)
///
/// A class responsible for managing policy and document agreements.
class PolicyAndDocuments extends ChangeNotifier {
  // Proprieties

  bool _agreedToPolicyTerms = false;
  bool _agreedToTermsOfService = false;
  Users? users;

  // Getters

  bool get agreedToPolicyTerms => _agreedToPolicyTerms;

  bool get agreedToTermsOfService => _agreedToTermsOfService;

  // Methods

  /// Sets the agreement status for policy and terms.
  void setAgreedToPolicyTerms(bool value) {
    _agreedToPolicyTerms = value;
    notifyListeners();
  }

  /// Sets the agreement status for terms of service.
  void setAgreedToTermsOfService(bool value) {
    _agreedToTermsOfService = value;
    notifyListeners();
  }
}

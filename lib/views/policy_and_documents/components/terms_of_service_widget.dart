import 'package:brn_ecommerce/helpers/routes_navigator.dart';
import 'package:brn_ecommerce/models/policy_documents/policy_and_documents.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class TermsOfServiceWidget extends StatefulWidget {
  const TermsOfServiceWidget({super.key});

  @override
  State<TermsOfServiceWidget> createState() => _TermsOfServiceWidgetState();
}

class _TermsOfServiceWidgetState extends State<TermsOfServiceWidget> {
  bool agreedToTermsOfService = false;

  @override
  void initState() {
    final policyAndDocuments = Provider.of<PolicyAndDocuments>(context, listen: false);
    agreedToTermsOfService = policyAndDocuments.agreedToPolicyTerms;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    goToPage(String arguments) =>
        Navigator.pushNamed(context, RoutesNavigator.privacyAndPolicyScreen);

    return Row(
      children: [
        Checkbox(
          value: agreedToTermsOfService,
          onChanged: (value) {
            setState(() {
              agreedToTermsOfService = value ?? false;
              final policyAndDocuments = Provider.of<PolicyAndDocuments>(context, listen: false);
              policyAndDocuments.setAgreedToTermsOfService(value!);
            });
          },
        ),
        InkWell(
          onTap: () async {
            final termsOfServiceText = await rootBundle.loadString('assets/docs/termsOfService.md');
            goToPage(termsOfServiceText);
          },
          child: const Text(
            'Termos de Serviço',
            style: TextStyle(
              decoration: TextDecoration.underline,
              color: Colors.blue,
            ),
          ),
        ),
      ],
    );
  }
}

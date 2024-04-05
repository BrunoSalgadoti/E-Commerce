import 'package:brn_ecommerce/models/views/policy_and_documents.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class PrivacyPolicyWidget extends StatefulWidget {
  const PrivacyPolicyWidget({super.key});

  @override
  State<PrivacyPolicyWidget> createState() => _PrivacyPolicyWidgetState();
}

class _PrivacyPolicyWidgetState extends State<PrivacyPolicyWidget> {
  bool agreedToPolicyTerms = false;

  @override
  void initState() {
    final policyAndDocuments = Provider.of<PolicyAndDocuments>(context, listen: false);
    agreedToPolicyTerms = policyAndDocuments.agreedToPolicyTerms;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    goToPage(String arguments) =>
        Navigator.pushNamed(context, "/privacy_policy", arguments: arguments);

    return Row(
      children: [
        Checkbox(
          value: agreedToPolicyTerms,
          onChanged: (value) {
            setState(() {
              agreedToPolicyTerms = value ?? false;
              final policyAndDocuments = Provider.of<PolicyAndDocuments>(context, listen: false);
              policyAndDocuments.setAgreedToPolicyTerms(value!);
            });
          },
        ),
        InkWell(
          onTap: () async {
            final privacyPolicyText = await rootBundle.loadString('assets/docs/privacyPolicy.md');
            goToPage(privacyPolicyText);
          },
          child: const Text(
            'Política de Privacidade',
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

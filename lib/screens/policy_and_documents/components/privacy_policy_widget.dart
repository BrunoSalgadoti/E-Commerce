import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:brn_ecommerce/models/policy_and_documents.dart';

class PrivacyPolicyWidget extends StatefulWidget {
  const PrivacyPolicyWidget({super.key});

  @override
  State<PrivacyPolicyWidget> createState() => _PrivacyPolicyWidgetState();
}

class _PrivacyPolicyWidgetState extends State<PrivacyPolicyWidget> {
  bool agreedToPolicyTerms = false;

  @override
  void initState() {
    final policyAndDocuments =
        Provider.of<PolicyAndDocuments>(context, listen: false);
    agreedToPolicyTerms = policyAndDocuments.agreedToPolicyTerms;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: agreedToPolicyTerms,
          onChanged: (value) {
            setState(() {
              agreedToPolicyTerms = value ?? false;
              final policyAndDocuments =
                  Provider.of<PolicyAndDocuments>(context, listen: false);
              policyAndDocuments.agreedToPolicyTerms = agreedToPolicyTerms;
            });
          },
        ),
        InkWell(
          onTap: () async {
            final privacyPolicyText =
                await rootBundle.loadString('assets/docs/privacyPolicy.md');
            // ignore: use_build_context_synchronously
            Navigator.pushNamed(context, "/privacy_policy",
                arguments: privacyPolicyText);
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

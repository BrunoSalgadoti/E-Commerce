import 'package:brn_ecommerce/models/policy_and_documents.dart';
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
    final policyAndDocuments =
        Provider.of<PolicyAndDocuments>(context, listen: false);
    agreedToTermsOfService = policyAndDocuments.agreedToPolicyTerms;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: agreedToTermsOfService,
          onChanged: (value) {
            setState(() {
              agreedToTermsOfService = value ?? false;
              final policyAndDocuments =
                  Provider.of<PolicyAndDocuments>(context, listen: false);
              policyAndDocuments.agreedToTermsOfService =
                  agreedToTermsOfService;
            });
          },
        ),
        InkWell(
          onTap: () async {
            final privacyPolicyText =
                await rootBundle.loadString('assets/docs/termsOfService.md');
            // ignore: use_build_context_synchronously
            Navigator.pushNamed(context, "/privacy_policy",
                arguments: privacyPolicyText);
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

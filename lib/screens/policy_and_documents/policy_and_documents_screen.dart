import 'package:brn_ecommerce/screens/policy_and_documents/components/privacy_policy_widget.dart';
import 'package:brn_ecommerce/screens/policy_and_documents/components/terms_of_service_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brn_ecommerce/models/policy_and_documents.dart';

class PolicyAndDocumentsScreen extends StatelessWidget {
  const PolicyAndDocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PolicyAndDocuments>(
      builder: (_, policyAndDocuments, __) {
        return ListView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: const [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Ao marcar estas opções:',
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
                PrivacyPolicyWidget(),
                TermsOfServiceWidget(),
                Text(
                  'Você estará concordando com a Política e Termos '
                      'dos nossos serviços!',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 12,
                )
              ],
            ),
          ],
        );
      },
    );
  }
}

import 'package:brn_ecommerce/common/button/custom_button.dart';
import 'package:brn_ecommerce/common/price_card.dart';
import 'package:brn_ecommerce/common/show_alert_dialog.dart';
import 'package:brn_ecommerce/models/cart_manager.dart';
import 'package:brn_ecommerce/models/policy_and_documents.dart';
import 'package:brn_ecommerce/models/users_manager.dart';
import 'package:brn_ecommerce/models/version_manager.dart';
import 'package:brn_ecommerce/screens/address/components/address_card.dart';
import 'package:brn_ecommerce/screens/policy_and_documents/components/privacy_policy_widget.dart';
import 'package:brn_ecommerce/screens/policy_and_documents/components/terms_of_service_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  Widget build(BuildContext context) {
    goToScreen() => Navigator.pushNamed(context, "/checkout");
    backScreen() => Navigator.pop(context);

    alert() {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text(
            'É necessário Concordar com a Política'
            ' de privacidade e nossos '
            'Termos de Serviço',
            style: TextStyle(fontSize: 18)),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 5),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(15),
      ));
      return;
    }

    String messenger = 'Foi verificado em nosso sistema que esta '
        'conta de usuário\n'
        'ainda não aceitou a nossa Política de '
        'privacidade e o nosso Termos de Uso'
        '\n\nPor favor, para continuar: \n\n'
        'Leia atentamente e aceite os Termos e '
        'a Política de Privacidade!';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrega'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const AddressCard(),
          Consumer3<CartManager, PolicyAndDocuments, VersionManager>(builder:
              (_, cartManager, policyAndDocuments, versionManager, __) {
            final userManager = Provider.of<UserManager>(context);
            final currentUser = userManager.users;

            void checkPolicyAndTerms() {
              if (currentUser!.policyAndTerms == false ||
                  currentUser.policyAndTerms == null) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return ShowAlertDialog(
                      titleText: 'A T E N Ç Ã O!',
                      bodyText: messenger,
                      actions: [
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            PrivacyPolicyWidget(),
                            TermsOfServiceWidget(),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CustomButton(
                              text: 'Regeitar',
                              onPressed: () {
                                backScreen();
                              },
                            ),
                            CustomButton(
                              text: 'Prosseguir',
                              onPressed: () async {
                                if (policyAndDocuments.agreedToPolicyTerms ==
                                        false ||
                                    policyAndDocuments.agreedToTermsOfService ==
                                        false) {
                                  alert();
                                } else {
                                  currentUser.policyAndTerms = true;
                                  await currentUser.updateUserData();
                                  goToScreen();
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                );
              } else {
                goToScreen();
              }
            }

            void checkAndHandleVersion() {
              if (versionManager.compatibleVersion == false) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return ShowAlertDialog(
                      titleText: 'Atualização Necessária!',
                      bodyText: 'Por favor, para continuar: \n'
                          'é necessário atualizar o aplicativo para a versão mais recente!',
                      actions: [
                        CustomButton(
                          text: 'Atualizar',
                          onPressed: () {
                            Navigator.pop(context);
                            // You can redirect to the app store for updating the app
                            // For Android, use:
                            // launch('https://play.google.com/store/apps/details?id=com.example.app');
                            // For iOS, use:
                            // launch('https://apps.apple.com/app/id<your_app_id>');
                          },
                        )
                      ],
                    );
                  },
                );
                userManager.loading = false;
                return;
              } else {
                checkPolicyAndTerms();
              }
            }

            return PriceCard(
              buttonText: 'Continuar para Pagamento',
              onPressed: cartManager.isAddressValid
                  ? () async {
                      userManager.loading = true;
                      await versionManager.checkVersion();
                      checkAndHandleVersion();
                      userManager.loading = false;
                    }
                  : null,
            );
          })
        ],
      ),
    );
  }
}

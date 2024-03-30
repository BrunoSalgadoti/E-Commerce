import 'package:brn_ecommerce/common/buttons/custom_button.dart';
import 'package:brn_ecommerce/common/cards/price_card.dart';
import 'package:brn_ecommerce/common/messengers/custom_alertdialog_adaptive.dart';
import 'package:brn_ecommerce/common/messengers/custom_scaffold_messenger.dart';
import 'package:brn_ecommerce/models/cart_manager.dart';
import 'package:brn_ecommerce/models/policy_and_documents.dart';
import 'package:brn_ecommerce/models/users_manager.dart';
import 'package:brn_ecommerce/models/version_manager.dart';
import 'package:brn_ecommerce/screens/address/components/address_card.dart';
import 'package:brn_ecommerce/screens/policy_and_documents/components/privacy_policy_widget.dart';
import 'package:brn_ecommerce/screens/policy_and_documents/components/terms_of_service_widget.dart';
import 'package:custom_universal_html/html.dart' as html;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    goToScreen() => Navigator.pushNamed(context, "/checkout");
    backScreen() => Navigator.pop(context);

    alertPolicyAndTerms() {
      CustomScaffoldMessenger(
        context: context,
        message: 'É necessário Concordar com a Política'
            ' de privacidade e nossos '
            'Termos de Serviço',
      ).alertScaffold();
      return;
    }

    String messenger = 'Foi verificado em nosso sistema que está '
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
          Consumer3<CartManager, PolicyAndDocuments, VersionManager>(
              builder: (_, cartManager, policyAndDocuments, versionManager, __) {
            final userManager = Provider.of<UserManager>(context);
            final currentUser = userManager.users;

            void checkPolicyAndTerms() {
              if (currentUser!.policyAndTerms == false || currentUser.policyAndTerms == null) {
                CustomAlertDialogAdaptive(
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
                          text: 'Rejeitar',
                          widthButton: 100,
                          heightButton: 40,
                          onPressed: () {
                            backScreen();
                          },
                        ),
                        CustomButton(
                          text: 'Aceitar',
                          widthButton: 100,
                          heightButton: 40,
                          onPressed: () async {
                            if (policyAndDocuments.agreedToPolicyTerms == false ||
                                policyAndDocuments.agreedToTermsOfService == false) {
                              alertPolicyAndTerms();
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
                ).alertContent(context);
              } else {
                goToScreen();
              }
            }

            void checkAndHandleVersion() {
              if (!versionManager.compatibleVersion) {
                CustomAlertDialogAdaptive(
                  titleText: 'Atualização Necessária!',
                  bodyText: 'Por favor, para continuar: \n'
                      'é necessário atualizar o aplicativo para a '
                      'versão mais recente!',
                  actions: [
                    CustomButton(
                      text: 'Atualizar',
                      widthButton: 100,
                      heightButton: 40,
                      onPressed: () {
                        if (kIsWeb) {
                          // Refresh the web page and clear cache
                          html.window.location.reload();
                        } else {
                          //TODO: Quando publicado
                          // Redirect to app store for updating the app
                          // Example for Android:
                          // launch('https://play.google.com/store/apps/details?id=com.example.app');
                          // Example for iOS:
                          // launch('https://apps.apple.com/app/id<your_app_id>');
                        }
                        backScreen();
                      },
                    )
                  ],
                ).alertContent(context);
                userManager.loading = false;
              } else {
                checkPolicyAndTerms();
              }
            }

            return PriceCard(
              buttonText: 'Prosseguir para Pagamento',
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

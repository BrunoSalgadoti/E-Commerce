import 'package:brn_ecommerce/common/buttons/custom_button.dart';
import 'package:brn_ecommerce/common/cards/price_card.dart';
import 'package:brn_ecommerce/common/messengers/components/text_of_alerts_and_messengers.dart';
import 'package:brn_ecommerce/common/messengers/custom_alertdialog_adaptive.dart';
import 'package:brn_ecommerce/common/messengers/custom_scaffold_messenger.dart';
import 'package:brn_ecommerce/helpers/breakpoints.dart';
import 'package:brn_ecommerce/helpers/routes_navigator.dart';
import 'package:brn_ecommerce/models/sales/cart_manager.dart';
import 'package:brn_ecommerce/models/users/users_manager.dart';
import 'package:brn_ecommerce/models/views/policy_and_documents.dart';
import 'package:brn_ecommerce/services/config/version_manager.dart';
import 'package:brn_ecommerce/views/address/components/address_card.dart';
import 'package:brn_ecommerce/views/policy_and_documents/components/privacy_policy_widget.dart';
import 'package:brn_ecommerce/views/policy_and_documents/components/terms_of_service_widget.dart';
import 'package:custom_universal_html/html.dart' as html;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Functions to remove context from async methods
    goToScreen() => Navigator.pushNamed(context, routesNavigator.checkoutScreen);
    backScreen() =>   Navigator.of(context).pop();
    alertPolicyAndTerms() => CustomScaffoldMessenger(
            context: context, message: AlertsMessengersText.policyAndTermsConfirmation)
        .alertScaffold();

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
          appBar: AppBar(
            title: const Text('Endereço de entrega:'),
            centerTitle: true,
          ),
          body: Center(
              child: Padding(
            padding: kIsWeb ? const EdgeInsets.only(top: 0) : MediaQuery.of(context).padding,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: tabletBreakpoint),
              child: ListView(
                children: [
                  const AddressCard(),
                  Consumer4<CartManager, PolicyAndDocuments, VersionManager, UserManager>(builder:
                      (_, cartManager, policyAndDocuments, versionManager, userManager, __) {
                    void checkPolicyAndTerms() {
                      if (userManager.users!.policyAndTerms == false ||
                          userManager.users!.policyAndTerms == null) {
                        CustomAlertDialogAdaptive(
                          titleText: 'A T E N Ç Ã O!',
                          bodyText: AlertsMessengersText.policyAndTermsUnchecked,
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
                                      userManager.users!.policyAndTerms = true;
                                      await userManager.users!.updateUserData();
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
                          titleText: 'Atualização necessária!',
                          bodyText: AlertsMessengersText.appUpdateRequired,
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
                      buttonText: 'Prosseguir para pagamento',
                      onPressed: cartManager.isAddressValid
                          ? () async {
                              userManager.loading = true;
                              await versionManager.checkVersion();
                              checkAndHandleVersion();
                              userManager.loading = false;
                            }
                          : null,
                      showIcon: true,
                    );
                  })
                ],
              ),
            ),
            // ),
          )));
    });
  }
}

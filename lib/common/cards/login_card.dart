import 'package:brn_ecommerce/common/buttons/custom_button.dart';
import 'package:brn_ecommerce/helpers/routes_navigator.dart';
import 'package:flutter/material.dart';

/// ## LoginCard
/// Widget Card for areas of the APP that require user login and the user is not logged in.
/// My orders area, among others.
class LoginCard extends StatelessWidget {
  const LoginCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 260, maxWidth: 380),
        child: Card(
          elevation: 20,
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 10),
            child: SizedBox(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    Icons.account_circle,
                    color: primaryColor,
                    size: 100,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0.8),
                    child: Text(
                      'Você precisa estar logado.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  CustomButton(
                    text: 'Entrar',
                    onPressed: () {
                      Navigator.pushNamed(context, RoutesNavigator.loginScreen);
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

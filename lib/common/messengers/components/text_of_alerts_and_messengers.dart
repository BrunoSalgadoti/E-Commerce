mixin AlertsMessengersText {
  // # MESSENGERS OF THE SCAFFOLDDs N´ ALERTDIALOGGs MESSENGERS (ALERTS!!!)

  /// # [POLICY_AND_TERMS_CONFIRMATION] (box unchecked and confirmation)
  static const String policyAndTermsConfirmation =
      'É necessário concordar com a Política de Privacidade '
      'e nossos Termos de Serviço';
  static const String policyAndTermsUnchecked =
      'Foi verificado em nosso sistema que está conta de usuário\n'
      'ainda não aceitou a nossa Política de privacidade e o nosso Termos de Uso'
      '\n\nPor favor, para continuar: \n\n'
      'Leia atentamente e aceite os Termos e a Política de Privacidade!';

  /// #  [APP_UPDATE_REQUIRED]
  static const String appUpdateRequired = 'Por favor, para continuar: \n'
      'é necessário atualizar o aplicativo para a versão mais recente!';

  /// # [CHECKING_THE_DELIVERY_RADIUS]
  static const String checkingDeliveryRadius = 'Não disponível pra entrega! \n '
      'Endereço fora do raio de entrega :(';

  /// # [SEND_CONTACT_EMAIL_FOR_THE_USERS]
  /// ##  Function sendEmail in [communications_utils.dart]
  //
  /// ### [Subject] of the email:
  static const String subjectOfTheEmail = "BRN Info_DEV";

  /// #### [Body] menssages of the email:
  static const String bodyMessangersEmailWithowtUserName =
      "Olá estimado Cliente,\n Estamos Entrando em contato para:\n";
  static const String bodyMessangersEmailWithUserName = "Estamos Entrando em contato para:\n";

  /// # [MESSAGE_IN_EmptyPageIndicator_PAGE_NOT_LOADING_INDICATOR]
  /// ## message page not loading in [EmptyPageIndicator]
  //
  /// ### [empty_page_indicator.dart]
  static const String erroEmptyPageIndicator = 'Verifique sua conexão com a internet!\n'
      'Se o erro persistir favor entrar em contato com: suporte@brninfodev.com';

  /// # [INFO_MARQUEE_MESSAGES]
  /// ## message Info-marquee in [CartScreen]
  //
  /// ### [cart_screen.dart]
  static const String infoMarqueeOfCartScreen = 'Continue comprando em nossa loja!! Contamos com '
      'diversos produtos em promoção, confira! Clique aqui! E boas compras!';

  /// # [SALES_SUGGESTIONS_WIDGET]
  /// ## message Info-marquee in [SalesSuggestionsWidget]
  //
  /// ### [sales_confirmation_screen.dart]
  static const String salesSuggestionMessage = 'Seu pedido foi realizado, agradecemos a preferência, '
      'acompanhe o status do seu pedidos em:\n';
}
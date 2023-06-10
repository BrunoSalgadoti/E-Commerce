String getErrorString(String code) {
  switch (code) {
    case 'ERROR_WEAK_PASSWORD':
      return 'Sua senha é muito fraca. '
          'Tente incluir caracteres especiais, '
          'letras maiúsculas e minúsculas, '
          'e pelo menos 8 caracteres.';
    case 'ERROR_INVALID_EMAIL':
    case "invalid-email":
      return 'E-mail ou Senha inválida! Revise o seu e-mail e a sua senha';
    case 'ERROR_EMAIL_ALREADY_IN_USE':
    case "email-already-in-use":
      return '! E-mail já cadastrado. '
          'Tente fazer login ou redefinir sua senha caso tenha esquecido.';
    case 'ERROR_INVALID_CREDENTIAL':
    case 'invalid_credential':
      return 'Seu e-mail é inválido. Verifique se o e-mail está escrito '
          'corretamente ou use um e-mail válido.';
    case "ERROR_WRONG_PASSWORD":
    case "wrong-password":
      return 'E-mail ou Senha inválida!. '
          'Verifique se o e-mail e a senha estão corretos.';
    case 'ERROR_USER_NOT_FOUND':
    case "user-not-found":
      return 'E-mail ou Senha inválida!';
    case 'ERROR_USER_DISABLED':
    case "user-disabled":
      return 'Este usuário foi desabilitado.';
    case 'ERROR_TOO_MANY_REQUESTS':
    case "too_many_requests":
      return 'Muitas solicitações. Tente novamente em alguns minutos.';
    case 'ERROR_OPERATION_NOT_ALLOWED':
    case "operation-not-allowed":
      return 'Operação não permitida. '
          'Verifique se você está autorizado a realizar esta operação.';

    default:
      return 'Um erro indefinido ocorreu.';
  }
}

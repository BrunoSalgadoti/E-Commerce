String getErrorString(String code) {
  switch (code) {
    case "WEAK_PASSWORD":
    case "weak-password":
      return 'Sua senha é muito fraca. '
          'Tente incluir caracteres especiais, '
          'letras maiúsculas e minúsculas, '
          'e pelo menos 8 caracteres.';
    case "INVALID_EMAIL":
    case "invalid-email":
      return 'E-mail ou Senha inválida! Revise o seu e-mail e a sua senha';
    case "EMAIL_ALREADY_IN_USE":
    case "email-already-in-use":
      return '! E-mail já cadastrado. '
          'Tente fazer login ou redefinir sua senha caso tenha esquecido.';
    case "INVALID_CREDENTIAL":
    case "invalid-credential":
      return 'E-mail ou Senha inválida! Revise o seu e-mail e a sua senha.';
    case "ERROR_WRONG_PASSWORD":
    case "wrong-password":
      return 'E-mail ou Senha inválida!. '
          'Verifique se o e-mail e a senha estão corretos.';
    case "ERROR_USER_NOT_FOUND":
    case "user-not-found":
      return 'E-mail ou Senha inválida!';
    case "ERROR_USER_DISABLED":
    case "user-disabled":
      return 'Este usuário foi desabilitado.';
    case "ERROR_TOO_MANY_REQUESTS":
    case "too-many-requests":
      return 'Muitas solicitações. Tente novamente em alguns minutos.';
    case "ERROR_OPERATION_NOT_ALLOWED":
    case "operation-not-allowed":
      return 'Operação não permitida. '
          'Verifique se você está autorizado a realizar esta operação.';
    case "unknown":
      return 'Algo deu errado, favor tentar novamente. :( . '
          'Verifique sua conexão com a internet!';

    default:
      return 'Algo deu errado :(, favor tentar novamente!\n '
          'Verifique sua conexão com a internet!';
  }
}

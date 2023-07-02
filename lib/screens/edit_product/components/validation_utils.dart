class ValidationUtils {
  static String? validateAmount(String? amount) {
    if (int.tryParse(amount!) == null || int.tryParse(amount)! <= 0) {
      return 'Inválido';
    }
    return null;
  }

  static String? validateStock(String? stock) {
    if (int.tryParse(stock!) == null || int.tryParse(stock)! < 0) {
      return 'Inválido';
    }
    return null;
  }

  static String? validateAmountAndStock(
      String? amount, String? stock, int colorsLength) {
    final amountValidation = validateAmount(amount);
    if (amountValidation != null) {
      return amountValidation;
    }

    final stockValidation = validateStock(stock);
    if (stockValidation != null) {
      return stockValidation;
    }

    if (int.parse(amount!) != colorsLength) {
      return 'A quantidade de STOCK é diferente da quantidade de CORES';
    }

    return null;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

double customFontSizeResolver(num fontSize, ScreenUtil instance) {
  // Ajuste o tamanho com base na largura da tela.
  if (instance.screenWidth < 400) {
    return fontSize * 0.8; // Reduz o tamanho da fonte para telas menores que 400dp.
  } else if (instance.screenWidth < 600) {
    return fontSize * 1.0; // Tamanho padrão para telas entre 400dp e 600dp.
  } else {
    return fontSize * 1.5; // Aumenta o tamanho da fonte para telas maiores que 600dp.
  }
}

double sizeOfPropriety(double? value, ScreenUtil instance) {
  // Defina um valor padrão, caso nenhum valor seja fornecido.
  value = value ?? 25.0;

  // Ajuste o tamanho com base na largura da tela.
  if (instance.screenWidth < 400) {
    return value * 0.7; // 70% do valor original para telas menores que 400dp.
  } else if (instance.screenWidth < 600) {
    return value * 0.78; // 75%  Tamanho padrão para telas entre 400dp e 600dp.
  } else if (instance.screenWidth < 700) {
    return value * 0.93; // 93%  Tamanho padrão para telas entre 600dp e 700dp.
  } else if (instance.screenWidth < 800) {
    return value * 0.95; // 95% Tamanho padrão para telas entre 700dp e 800dp.
  } else if (instance.screenWidth < 900) {
    return value * 0.98; // 98% Tamanho padrão para telas entre 900dp e 800dp.
  } else if (instance.screenWidth < 1000) {
    return value * 1.0; // 100% Tamanho padrão para telas entre 800dp e 1000dp.
  } else if (instance.screenWidth < 1100) {
    return value * 1.3; // 130% Tamanho padrão para telas entre 1000dp e 1100dp.
  } else if (instance.screenWidth < 1200) {
    return value * 1.5; // 150% Tamanho padrão para telas entre 1100dp e 1200dp.
  } else {
    return value * 1.7; // 170% do valor original para telas maiores que 1200dp.
  }
}

ScreenUtil initScreenUtil(
  BuildContext context, {
  MediaQueryData? data,
  Size? designSize,
  bool splitScreenMode = true,
  bool minTextAdapt = true,
  FontSizeResolver? fontSizeResolver,
}) {
  final data = MediaQuery.of(context);
  final screenSizeWidth = MediaQuery.of(context).size.width;
  final screenSizeHeight = MediaQuery.of(context).size.height;
  final currentDesignSize = designSize ?? Size(screenSizeWidth, screenSizeHeight);

  ScreenUtil.init(
    context,
    designSize: currentDesignSize,
    splitScreenMode: splitScreenMode,
    minTextAdapt: minTextAdapt,
    fontSizeResolver: fontSizeResolver ?? customFontSizeResolver,
  );
  ScreenUtil.configure(
    data: data,
  );
  return ScreenUtil();
}

///ScreenUtil Package: iniScreenUtil Exemple of usage:
//TODO: Exemplo de uso

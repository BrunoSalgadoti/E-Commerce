import 'package:brn_ecommerce/helpers/handle_erros.dart';
import 'package:brn_ecommerce/models/products/product.dart';
import 'package:brn_ecommerce/services/development_monitoring/firebase_performance.dart';
import 'package:brn_ecommerce/services/development_monitoring/monitoring_logger.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

class MonitoringStockMin {
  //TODO: quando configurar o firebase
  HandleErrors handleErrorsEmail = HandleErrors.withEmailMessage(
      recipientEmail: 'suporte@brninfodev.com',
      emailSubject: 'Erro no monitoramento do Estoque',
      emailMessage: '');

  // Function to check the minimum stock of products
  static Future<void> checkMinimumStock(
      List<Product> productsToUpdate, List<Product> productsWithoutStock) async {
    PerformanceMonitoring().startTrace('verificarEstoqueMinimo', shouldStart: true);

    if (kDebugMode) {
      MonitoringLogger().logInfo('Debug message: verificarEstoqueMinimo');
    }

    try {
      // Here you can fetch the minimum stock value from remote settings
      final int estoqueMinimoNotificacao = await _searchMinimumStockNotification();

      for (final produto in productsToUpdate) {
        if (produto.totalStock <= estoqueMinimoNotificacao) {
          // Notify about minimum stock
          _notifyMinimumStock(produto);
        }
      }

      for (final produto in productsWithoutStock) {
        // Notify about out of stock
        _notifyMinimumStock(produto);
      }
    } catch (error) {
      //TODO: quando configurar o firebase
      final handleErrors = HandleErrors.withEmailMessage(
        recipientEmail: 'suporte@brninfodev.com',
        emailSubject: 'Erro no monitoramento do Estoque',
      );

      handleErrors.handleErrorAndSendToEmail(error, 5, 20);
    }

    PerformanceMonitoring().stopTrace('verificarEstoqueMinimo');
  }

  // Function to fetch the value of the remote parameter
  // "MonitoringStockMin" with 30 mim cache
  static Future<int> _searchMinimumStockNotification() async {
    if (kDebugMode) {
      MonitoringLogger().logInfo('Message: searchStock IN FIREBASE');
    }

    try {
      final remoteConfig = FirebaseRemoteConfig.instance;
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
          fetchTimeout: const Duration(minutes: 1),
          minimumFetchInterval: const Duration(minutes: 30)));
      await remoteConfig.fetchAndActivate();
      final estoqueMinimo = remoteConfig.getInt('estoqueMinimoNotificacao');
      return estoqueMinimo;
    } catch (error) {
      // Handle any network error or failure to obtain value
      debugPrint('Erro ao buscar o valor do parâmetro remoto: $error');
      final handleErrors = HandleErrors.withEmailMessage(
        recipientEmail: 'suporte@brninfodev.com',
        emailSubject: 'Erro no monitoramento do Estoque',
      );

      handleErrors.handleErrorAndSendToEmail(error, 5, 30);
      return 0;
    }
  }

  // Function to notify about the minimum stock of a product
  static void _notifyMinimumStock(Product produto) {
    // Option 1: Notify in the console in mode debug
    debugPrint("Estoque mínimo atingido para o produto: ${produto.name}\n"
        "Quantidade de Estoque atual:  ${produto.totalStock}\n");

    // TODO: Option 2: Send an in-app notification
    // You can use a notification library to send in-app notifications.
    // Fictional example:
    // sendInAppNotification("Estoque mínimo atingido para o produto ${produto.name}");

    // TODO: Option 3: Send a SMS notification
    // You can replace this fictional logic with the actual implementation of sending SMS notifications.
    // In this example, we're providing a placeholder comment.
    // sendSMSNotification("Estoque mínimo atingido para o produto ${produto.name}");

    // TODO: Option 4: Send a push notification
    // You can replace this fictional logic with the actual implementation of sending push notifications.
    // In this example, we're providing a placeholder comment.
    // sendPushNotification("Estoque mínimo atingido para o produto ${produto.name}");

    // TODO: Option 5: Email the manager (Activate and configure firebase functions)
    // sendEmailNotification(
    //     recipientEmail: 'brunosalgadoti@gmail.com',
    //     subject: 'Estoque esgotando!!',
    //     messageText: 'Estoque mínimo atingido para o produto: ${produto.name}\n'
    //         'Quantidade de Estoque atual:  ${produto.totalStock}\n');
  }
}

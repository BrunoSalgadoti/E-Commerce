import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:brn_ecommerce/common/images/root_assets.dart';
import 'package:brn_ecommerce/helpers/routes_navigator.dart';
import 'package:brn_ecommerce/models/home_sections/home_manager.dart';
import 'package:brn_ecommerce/models/products/product.dart';
import 'package:brn_ecommerce/models/products/product_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _logoController;
  late final Animation<double> _logoScale;
  late final Animation<double> _logoOpacity;
  final AudioPlayer _audioPlayer = AudioPlayer();

  double _opacityBackground = 1.0;
  bool _homeReady = false;
  List<Product> _highlightedProducts = [];

  @override
  void initState() {
    super.initState();

    // Controlador da animação da logo
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4), //Fade-in duration and scale
    );

    _logoScale = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOutCubic),
    );

    _logoOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeIn),
    );

    _playIntroAudioAndAnimate();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final productManager = context.read<ProductManager>();
      final homeManager = context.read<HomeManager>();

      await _waitForHomeReady(productManager, homeManager);

      _highlightedProducts = productManager.highlightedProducts;
      await _prefetchAllImages(_highlightedProducts);

      // Gradually fade the background
      if (mounted) {
        for (int i = 0; i <= 10; i++) {
          await Future.delayed(const Duration(milliseconds: 100));
          setState(() => _opacityBackground = 1 - (i / 10));
        }
      }

      await Future.delayed(const Duration(milliseconds: 500));
      if (mounted) Navigator.pushReplacementNamed(context, RoutesNavigator.homeScreen);
    });
  }

  Future<void> _playIntroAudioAndAnimate() async {
    // Audio
    _audioPlayer.setReleaseMode(ReleaseMode.stop);
    await _audioPlayer.setSource(AssetSource(RootAssets.vignetteAudio));
    await _audioPlayer.resume();

    // Animate logo synchronized with audio
    _logoController.forward();
  }

  Future<void> _waitForHomeReady(ProductManager productManager, HomeManager homeManager) async {
    while (productManager.highlightedProducts.isEmpty || homeManager.sections.isEmpty) {
      await Future.delayed(const Duration(milliseconds: 200));
    }
    _homeReady = true;
  }

  Future<void> _prefetchAllImages(List<Product> products) async {
    for (var product in products) {
      if (product.images != null) {
        for (var url in product.images!) {
          await precacheImage(NetworkImage(url), context);
        }
      }
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    _audioPlayer.stop();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fading splash background
          AnimatedOpacity(
            duration: const Duration(milliseconds: 100),
            opacity: _opacityBackground,
            child: Image.asset(
              RootAssets.splashScreenJpg,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),

          // Animated logo + progress indicator
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedBuilder(
                  animation: _logoController,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _logoOpacity.value,
                      child: Transform.scale(
                        scale: _logoScale.value,
                        child: child,
                      ),
                    );
                  },
                  child: Image.asset(
                    RootAssets.storeImgLogo,
                    width: 350, // final size
                  ),
                ),
                const SizedBox(height: 20),
                const CircularProgressIndicator(color: Colors.orange),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

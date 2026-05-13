import 'dart:async';
import 'dart:ui' as ui;

import 'package:brn_ecommerce/common/outdoor/components/outdoor_controller.dart';
import 'package:brn_ecommerce/common/outdoor/components/outdoor_item.dart';
import 'package:brn_ecommerce/common/outdoor/components/slice_painter.dart';
import 'package:brn_ecommerce/models/products/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class OutdoorWidget extends StatefulWidget {
  final int slices;
  final bool isSilver;
  final OutdoorController? controller;
  final int durationPerSliceMs;

  const OutdoorWidget({
    super.key,
    required this.isSilver,
    this.controller,
    this.slices = 6,
    this.durationPerSliceMs = 500,
  });

  @override
  State<OutdoorWidget> createState() => _OutdoorWidgetState();
}

class _OutdoorWidgetState extends State<OutdoorWidget> with SingleTickerProviderStateMixin {
  late final AnimationController _animController;
  late final PageController _pageController;
  YoutubePlayerController? _ytController;

  int _currentIndex = 0;
  final Map<String, ui.Image> _imageCache = {};

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAutoPlay();
    });
  }

  void _startAutoPlay() {
    final controller = widget.controller ?? context.read<OutdoorController>();
    if (controller.items.isEmpty) return;

    final item = controller.items[_currentIndex];
    if (item.type == OutdoorType.youtube) {
      // não inicia autoplay para vídeo
      return;
    }

    Future.delayed(const Duration(seconds: 3), _nextPage);
  }

  Future<ui.Image> _composeImage(OutdoorItem item) async {
    if (_imageCache.containsKey(item.url)) return _imageCache[item.url]!;

    // Fundo
    final ByteData data = item.type == OutdoorType.asset
        ? await rootBundle.load(item.url)
        : await NetworkAssetBundle(Uri.parse(item.url)).load("");
    final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    final frame = await codec.getNextFrame();
    ui.Image background = frame.image;

    // Se tiver produto, compõe por cima
    if (item.productId != null) {
      final controller = widget.controller ?? context.read<OutdoorController>();
      final Product? product = controller.getProductById(item.productId!);

      if (product != null && product.images!.isNotEmpty) {
        final recorder = ui.PictureRecorder();
        final canvas = Canvas(recorder);
        final paint = Paint();

        // desenha fundo
        canvas.drawImageRect(
          background,
          Rect.fromLTWH(0, 0, background.width.toDouble(), background.height.toDouble()),
          Rect.fromLTWH(0, 0, background.width.toDouble(), background.height.toDouble()),
          paint,
        );

        // desenha produto (simplesmente centralizado)
        final productImageData =
            await NetworkAssetBundle(Uri.parse(product.images!.first)).load("");
        final productCodec = await ui.instantiateImageCodec(productImageData.buffer.asUint8List());
        final productFrame = await productCodec.getNextFrame();
        final productImage = productFrame.image;

        final scale = background.height / 2 / productImage.height;
        final productWidth = productImage.width * scale;
        final productHeight = productImage.height * scale;
        final offsetX = (background.width - productWidth) / 2;
        final offsetY = (background.height - productHeight) / 2;

        canvas.drawImageRect(
          productImage,
          Rect.fromLTWH(0, 0, productImage.width.toDouble(), productImage.height.toDouble()),
          Rect.fromLTWH(offsetX, offsetY, productWidth, productHeight),
          paint,
        );

        final composed = await recorder.endRecording().toImage(
              background.width,
              background.height,
            );

        _imageCache[item.url] = composed;
        return composed;
      }
    }

    _imageCache[item.url] = background;
    return background;
  }

  void _nextPage() async {
    final controller = widget.controller ?? context.read<OutdoorController>();
    if (!mounted || controller.items.isEmpty) return;

    final nextIndex = (_currentIndex + 1) % controller.items.length;
    final nextItem = controller.items[nextIndex];

    if (nextItem.type != OutdoorType.youtube) {
      await _composeImage(nextItem);

      final sliceCount = widget.slices;
      final durationPerSlice = widget.durationPerSliceMs;
      _animController.duration = Duration(milliseconds: durationPerSlice * sliceCount);
    }

    setState(() {
      _currentIndex = nextIndex;
    });

    if (nextItem.type != OutdoorType.youtube) {
      _animController.forward(from: 0).whenComplete(() {
        if (!mounted) return;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_pageController.hasClients) {
            _pageController.animateToPage(
              _currentIndex,
              duration: const Duration(milliseconds: 900),
              curve: Curves.easeInOut,
            );
          }
        });
        _startAutoPlay();
      });
    }
  }

  @override
  void dispose() {
    _ytController?.dispose();
    _animController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = widget.controller ?? context.watch<OutdoorController>();
    final items = controller.items;
    if (items.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    final nextIndex = (_currentIndex + 1) % items.length;

    return AspectRatio(
      aspectRatio: widget.isSilver ? 18 / 9 : 16 / 9,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          fit: StackFit.expand,
          children: [
            _buildItem(items[_currentIndex]),
            AnimatedBuilder(
              animation: _animController,
              builder: (context, child) {
                final currentImage = _imageCache[items[_currentIndex].url];
                final nextImage = _imageCache[items[nextIndex].url];
                if (currentImage == null || nextImage == null) return const SizedBox();

                return CustomPaint(
                  painter: SlicePainter(
                    progress: _animController.value,
                    slices: widget.slices,
                    currentImage: currentImage,
                    nextImage: nextImage,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(OutdoorItem item) {
    switch (item.type) {
      case OutdoorType.asset:
      case OutdoorType.image:
        return FutureBuilder<ui.Image>(
          future: _composeImage(item),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
            return RawImage(image: snapshot.data, fit: BoxFit.cover);
          },
        );

      case OutdoorType.youtube:
        final vid = YoutubePlayer.convertUrlToId(item.url) ?? '';

        // Descarta controller anterior
        _ytController?.pause();
        _ytController?.dispose();

        _ytController = YoutubePlayerController(
          initialVideoId: vid,
          flags: const YoutubePlayerFlags(
            autoPlay: true,
            endAt: 30,
            mute: false,
            loop: false,
          ),
        );

        // Pausa autoplay das imagens
        _animController.stop();

        // Timer de fallback para passar para o próximo outdoor
        Timer(const Duration(seconds: 30), () {
          if (!mounted) return;
          _nextPage();
        });

        // Listener para quando o vídeo termina
        _ytController!.addListener(() {
          if (_ytController!.value.playerState == PlayerState.ended) {
            if (!mounted) return;
            _nextPage();
          }
        });

        return YoutubePlayer(
          controller: _ytController!,
          showVideoProgressIndicator: true,
          progressColors: const ProgressBarColors(
            playedColor: Colors.red,
            handleColor: Colors.redAccent,
          ),
        );
    }
  }
}


//------- versão copiloto ------
// class OutdoorWidget extends StatefulWidget {
//   final int slices;
//   final bool isSilver;
//   final OutdoorController? controller;
//   final int durationPerSliceMs;
//
//   const OutdoorWidget({
//     super.key,
//     required this.isSilver,
//     this.controller,
//     this.slices = 6,
//     this.durationPerSliceMs = 500,
//   });
//
//   @override
//   State<OutdoorWidget> createState() => _OutdoorWidgetState();
// }
//
// class _OutdoorWidgetState extends State<OutdoorWidget> with SingleTickerProviderStateMixin {
//   late final AnimationController _animController;
//   late final PageController _pageController;
//   YoutubePlayerController? _ytController;
//   Timer? _autoPlayTimer;
//
//   int _currentIndex = 0;
//   final Map<String, ui.Image> _imageCache = {};
//
//   OutdoorController get _controller =>
//       widget.controller ?? context.read<OutdoorController>();
//
//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController();
//     _animController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 900),
//     );
//
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _prepareInitialImages().then((_) => _startAutoPlay());
//     });
//   }
//
//   Future<void> _prepareInitialImages() async {
//     if (_controller.items.isEmpty) return;
//     await _composeImage(_controller.items[_currentIndex]);
//     final nextIndex = (_currentIndex + 1) % _controller.items.length;
//     await _composeImage(_controller.items[nextIndex]);
//     setState(() {});
//   }
//
//   void _startAutoPlay() {
//     _autoPlayTimer?.cancel();
//     final item = _controller.items[_currentIndex];
//     if (item.type != OutdoorType.youtube) {
//       _autoPlayTimer = Timer(const Duration(seconds: 3), _nextPage);
//     }
//   }
//
//   Future<ui.Image> _composeImage(OutdoorItem item) async {
//     if (_imageCache.containsKey(item.url)) return _imageCache[item.url]!;
//
//     try {
//       final ByteData data = item.type == OutdoorType.asset
//           ? await rootBundle.load(item.url)
//           : await NetworkAssetBundle(Uri.parse(item.url)).load("");
//       final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
//       final frame = await codec.getNextFrame();
//       ui.Image background = frame.image;
//
//       if (item.productId != null) {
//         final Product? product = _controller.getProductById(item.productId!);
//         if (product != null && product.images!.isNotEmpty) {
//           final recorder = ui.PictureRecorder();
//           final canvas = Canvas(recorder);
//           final paint = Paint();
//
//           canvas.drawImageRect(
//             background,
//             Rect.fromLTWH(0, 0, background.width.toDouble(), background.height.toDouble()),
//             Rect.fromLTWH(0, 0, background.width.toDouble(), background.height.toDouble()),
//             paint,
//           );
//
//           final productData =
//           await NetworkAssetBundle(Uri.parse(product.images!.first)).load("");
//           final productCodec = await ui.instantiateImageCodec(productData.buffer.asUint8List());
//           final productFrame = await productCodec.getNextFrame();
//           final productImage = productFrame.image;
//
//           final scale = background.height / 2 / productImage.height;
//           final productWidth = productImage.width * scale;
//           final productHeight = productImage.height * scale;
//           final offsetX = (background.width - productWidth) / 2;
//           final offsetY = (background.height - productHeight) / 2;
//
//           canvas.drawImageRect(
//             productImage,
//             Rect.fromLTWH(0, 0, productImage.width.toDouble(), productImage.height.toDouble()),
//             Rect.fromLTWH(offsetX, offsetY, productWidth, productHeight),
//             paint,
//           );
//
//           final composed = await recorder.endRecording().toImage(
//             background.width,
//             background.height,
//           );
//
//           _imageCache[item.url] = composed;
//           return composed;
//         }
//       }
//
//       _imageCache[item.url] = background;
//       return background;
//     } catch (_) {
//       return ui.Image(1, 1); // fallback vazio
//     }
//   }
//
//   void _nextPage() async {
//     if (!mounted || _controller.items.isEmpty) return;
//
//     final nextIndex = (_currentIndex + 1) % _controller.items.length;
//     final nextItem = _controller.items[nextIndex];
//
//     if (nextItem.type != OutdoorType.youtube) {
//       await _composeImage(nextItem);
//       _animController.duration = Duration(milliseconds: widget.durationPerSliceMs * widget.slices);
//     }
//
//     setState(() {
//       _currentIndex = nextIndex;
//     });
//
//     if (nextItem.type != OutdoorType.youtube) {
//       _animController.forward(from: 0).whenComplete(() {
//         if (!mounted) return;
//         _pageController.animateToPage(
//           _currentIndex,
//           duration: const Duration(milliseconds: 900),
//           curve: Curves.easeInOut,
//         );
//         _startAutoPlay();
//       });
//     }
//   }
//
//   @override
//   void dispose() {
//     _ytController?.dispose();
//     _animController.dispose();
//     _pageController.dispose();
//     _autoPlayTimer?.cancel();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final items = _controller.items;
//     if (items.isEmpty) return const Center(child: CircularProgressIndicator());
//
//     final nextIndex = (_currentIndex + 1) % items.length;
//
//     return AspectRatio(
//       aspectRatio: widget.isSilver ? 18 / 9 : 16 / 9,
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(16),
//         child: Stack(
//           fit: StackFit.expand,
//           children: [
//             _buildItem(items[_currentIndex]),
//             AnimatedBuilder(
//               animation: _animController,
//               builder: (context, child) {
//                 final currentImage = _imageCache[items[_currentIndex].url];
//                 final nextImage = _imageCache[items[nextIndex].url];
//                 if (currentImage == null || nextImage == null) return const SizedBox();
//                 return CustomPaint(
//                   painter: SlicePainter(
//                     progress: _animController.value,
//                     slices: widget.slices,
//                     currentImage: currentImage,
//                     nextImage: nextImage,
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildItem(OutdoorItem item) {
//     switch (item.type) {
//       case OutdoorType.asset:
//       case OutdoorType.image:
//         return FutureBuilder<ui.Image>(
//           future: _composeImage(item),
//           builder: (context, snapshot) {
//             if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
//             return RawImage(image: snapshot.data, fit: BoxFit.cover);
//           },
//         );
//
//       case OutdoorType.youtube:
//         final vid = YoutubePlayer.convertUrlToId(item.url) ?? '';
//         _ytController?.dispose();
//         _ytController = YoutubePlayerController(
//           initialVideoId: vid,
//           flags: const YoutubePlayerFlags(
//             autoPlay: true,
//             mute: false,
//             loop: false,
//           ),
//         );
//
//         _animController.stop();
//         _autoPlayTimer?.cancel();
//
//         _ytController!.addListener(() {
//           if (_ytController!.value.playerState == PlayerState.ended) {
//             if (!mounted) return;
//             _nextPage();
//           }
//         });
//
//         return YoutubePlayer(
//           controller: _ytController!,
//           showVideoProgressIndicator: true,
//           progressColors: const ProgressBarColors(
//             playedColor: Colors.red,
//             handleColor: Colors.redAccent,
//           ),
//         );
//     }
//   }
// }
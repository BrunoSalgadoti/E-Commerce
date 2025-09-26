import 'dart:math';
import 'dart:ui' as ui;
import 'dart:ui' show lerpDouble;
import 'package:vector_math/vector_math_64.dart' show Vector3;
import 'package:brn_ecommerce/models/outdoor/components/outdoor_controller.dart';
import 'package:brn_ecommerce/models/outdoor/components/outdoor_item.dart';
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

class _OutdoorWidgetState extends State<OutdoorWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;
  late final PageController _pageController;
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
    Future.delayed(const Duration(seconds: 6), _nextPage);
  }

  Future<ui.Image> _loadImage(OutdoorItem item) async {
    if (_imageCache.containsKey(item.url)) return _imageCache[item.url]!;

    final data = item.type == OutdoorType.asset
        ? await rootBundle.load(item.url)
        : await NetworkAssetBundle(Uri.parse(item.url)).load("");

    final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    final frame = await codec.getNextFrame();
    _imageCache[item.url] = frame.image;
    return frame.image;
  }

  void _nextPage() async {
    final controller = widget.controller ?? context.read<OutdoorController>();
    if (!mounted || controller.items.isEmpty) return;

    final nextIndex = (_currentIndex + 1) % controller.items.length;

    await _loadImage(controller.items[nextIndex]);

    final sliceCount = widget.slices;
    final durationPerSlice = widget.durationPerSliceMs;
    _animController.duration = Duration(milliseconds: durationPerSlice * sliceCount);

    setState(() {
      _currentIndex = nextIndex;
    });

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

  @override
  void dispose() {
    _animController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = widget.controller ?? context.watch<OutdoorController>();
    final items = controller.items;
    if (items.isEmpty) return const Center(child: Text("Nenhum outdoor disponível"));

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
                  painter: _SlicePainter(
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
        return Image.asset(item.url, fit: BoxFit.cover);
      case OutdoorType.image:
        return Image.network(item.url, fit: BoxFit.cover);
      case OutdoorType.youtube:
        final vid = YoutubePlayer.convertUrlToId(item.url) ?? '';
        final youtubeController = YoutubePlayerController(
          initialVideoId: vid,
          flags: const YoutubePlayerFlags(autoPlay: true, mute: true, loop: true),
        );
        return YoutubePlayer(controller: youtubeController);
    }
  }
}

class _SlicePainter extends CustomPainter {
  final double progress;
  final int slices;
  final ui.Image currentImage;
  final ui.Image nextImage;

  _SlicePainter({
    required this.progress,
    required this.slices,
    required this.currentImage,
    required this.nextImage,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final sliceWidth = size.width / slices;

    for (int i = 0; i < slices; i++) {
      final left = i * sliceWidth;

      final t = ((progress * slices) - i).clamp(0.0, 1.0);
      if (t <= 0) continue;

      final currentSrc = Rect.fromLTWH(
        i * (currentImage.width / slices),
        0,
        currentImage.width / slices,
        currentImage.height.toDouble(),
      );

      final nextSrc = Rect.fromLTWH(
        i * (nextImage.width / slices),
        0,
        nextImage.width / slices,
        nextImage.height.toDouble(),
      );

      final dst = Rect.fromLTWH(left, 0, sliceWidth, size.height);

      final angle = lerpDouble(0, pi, Curves.easeInOut.transform(t))!;
      final centerX = left + sliceWidth / 2;
      final centerY = size.height / 2;

      canvas.save();
      canvas.clipRect(dst);

      // Matriz principal para rotacionar a fatia
      final matrix = Matrix4.identity();
      matrix.translateByVector3(Vector3(centerX, centerY, 0.0));
      matrix.setEntry(3, 2, 0.0015); // perspectiva
      matrix.rotateY(angle);
      matrix.translateByVector3(Vector3(-centerX, -centerY, 0.0));

      canvas.transform(matrix.storage);

      if (angle <= (pi / 2)) {
        canvas.drawImageRect(currentImage, currentSrc, dst, paint);
      } else {
        // Matriz do lado “back” da fatia
        final backMatrix = Matrix4.identity();
        backMatrix.translateByVector3(Vector3(centerX, centerY, 0.0));
        backMatrix.scaleByVector3(Vector3(-1.0, 1.0, 1.0)); // corrige o espelhamento
        backMatrix.translateByVector3(Vector3(-centerX, -centerY, 0.0));

        canvas.save();
        canvas.transform(backMatrix.storage);
        canvas.drawImageRect(nextImage, nextSrc, dst, paint);
        canvas.restore();
      }

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _SlicePainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.slices != slices;
}
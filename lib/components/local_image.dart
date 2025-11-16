import 'package:flutter/material.dart';

class LocalImage extends StatelessWidget {
  final String src;
  final BoxFit? fit;
  final double? width;
  final double? height;

  const LocalImage(this.src, {super.key, this.fit, this.width, this.height});

  String _assetFromSrc(String s) {
    try {
      final uri = Uri.parse(s);
      final name = uri.pathSegments.isNotEmpty ? uri.pathSegments.last : s;
      return 'assets/images/$name';
    } catch (_) {
      return 'assets/images/$s';
    }
  }

  @override
  Widget build(BuildContext context) {
    final asset = _assetFromSrc(src);
    return Image.asset(
      asset,
      fit: fit,
      width: width,
      height: height,
      errorBuilder: (context, error, stackTrace) {
        // Fallback to a simple placeholder if asset missing
        return Container(
          width: width,
          height: height,
          color: Colors.grey[200],
          child: const Icon(Icons.broken_image, size: 40, color: Colors.grey),
        );
      },
    );
  }
}

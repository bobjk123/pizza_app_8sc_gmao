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

  bool _isNetwork(String s) {
    return s.startsWith('http://') || s.startsWith('https://');
  }

  @override
  Widget build(BuildContext context) {
    final asset = _assetFromSrc(src);

    if (_isNetwork(src)) {
      // Try network image first; on any loading error fallback to local asset.
      return Image.network(
        src,
        fit: fit,
        width: width,
        height: height,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            width: width,
            height: height,
            color: Colors.grey[100],
            child:
                const Center(child: CircularProgressIndicator(strokeWidth: 2)),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          // Network failed — show local asset fallback
          return Image.asset(
            asset,
            fit: fit,
            width: width,
            height: height,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: width,
                height: height,
                color: Colors.grey[200],
                child: const Icon(Icons.broken_image,
                    size: 40, color: Colors.grey),
              );
            },
          );
        },
      );
    }

    // Not a network src — treat as asset name/path
    return Image.asset(
      asset,
      fit: fit,
      width: width,
      height: height,
      errorBuilder: (context, error, stackTrace) {
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

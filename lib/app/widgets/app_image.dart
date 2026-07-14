import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';

class AppImage extends StatelessWidget {
  final String imagePath;
  final double? width;
  final double? height;
  final BoxFit fit;

  const AppImage({
    super.key,
    required this.imagePath,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  });

  bool get _isAsset => imagePath.startsWith('assets/');

  @override
  Widget build(BuildContext context) {
    if (_isAsset) {
      return Image.asset(
        imagePath,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) => _errorWidget(),
      );
    }

    return CachedNetworkImage(
      imageUrl: imagePath,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) => _placeholder(),
      errorWidget: (context, url, error) => _errorWidget(),
    );
  }

  Widget _placeholder() {
    return Container(
      width: width,
      height: height,
      color: AppColors.border,
      child: const Center(
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
    );
  }

  Widget _errorWidget() {
    return Container(
      width: width,
      height: height,
      color: AppColors.border,
      child: const Icon(Icons.menu_book_outlined, color: AppColors.primary),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CachedImage extends StatelessWidget {
  final String imgUrl;
  final double height;
  final double width;
  final double? iconHeight;
  const CachedImage({
    super.key,
    required this.imgUrl,
    required this.height,
    required this.width,
    this.iconHeight = 60,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imgUrl,
      fit: BoxFit.cover,
      height: height,
      width: width,
      placeholder: (context, url) => Center(
        child: SizedBox(
            height: 120.h, width:120.h, child: const CircularProgressIndicator()),
      ),
      errorWidget: (context, url, error) => Icon(
        Icons.image,
        size: iconHeight,
        color: Colors.grey,
      ),
    );
  }
}

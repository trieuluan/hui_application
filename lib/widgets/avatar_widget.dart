import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hui_application/gen/assets.gen.dart';

class AvatarWidget extends StatelessWidget {
  final String? imageUrl;
  final String displayName;
  final double radius;
  final BoxBorder? border;
  final Color? backgroundColor;

  const AvatarWidget({
    super.key,
    required this.displayName,
    this.imageUrl,
    this.radius = 24,
    this.border,
    this.backgroundColor,
  });

  String _generateFallbackUrl(String name) {
    final encoded = Uri.encodeComponent(name.trim());
    return 'https://ui-avatars.com/api/?name=$encoded&background=random&color=ffffff&size=128';
  }

  @override
  Widget build(BuildContext context) {
    final avatarUrl =
        (imageUrl != null && imageUrl!.isNotEmpty)
            ? imageUrl!
            : _generateFallbackUrl(displayName);

    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: border,
        color: backgroundColor ?? Colors.transparent,
      ),
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: avatarUrl,
          fit: BoxFit.cover,
          placeholder:
              (context, url) =>
                  Center(child: CircularProgressIndicator(strokeWidth: 2)),
          errorWidget:
              (context, url, error) =>
                  Assets.images.defaultAvatar.image(fit: BoxFit.cover),
        ),
      ),
    );
  }
}

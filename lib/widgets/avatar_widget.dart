import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  final double size;
  final String? imageUrl;
  final String initials;

  const AvatarWidget({
    Key? key,
    this.size = 40,
    this.imageUrl,
    this.initials = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imageUrl != null) {
      return CircleAvatar(
        radius: size / 2,
        backgroundImage: NetworkImage(imageUrl!),
      );
    }
    return CircleAvatar(radius: size / 2, child: Text(initials));
  }
}

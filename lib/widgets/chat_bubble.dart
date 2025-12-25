import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isMe;
  final String avatarInitial;
  final VoidCallback? onLongPress;

  const ChatBubble({
    Key? key,
    required this.text,
    this.isMe = false,
    this.avatarInitial = '?',
    this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bg = isMe ? AppColors.chatOutgoing : AppColors.chatIncoming;
    final align = isMe ? MainAxisAlignment.end : MainAxisAlignment.start;

    final bubble = GestureDetector(
      onLongPress: onLongPress,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(text),
      ),
    );

    return Row(
      mainAxisAlignment: align,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: isMe
          ? [
              Flexible(child: bubble),
              const SizedBox(width: 8),
              CircleAvatar(radius: 14, child: Text(avatarInitial)),
            ]
          : [
              CircleAvatar(radius: 14, child: Text(avatarInitial)),
              const SizedBox(width: 8),
              Flexible(child: bubble),
            ],
    );
  }
}

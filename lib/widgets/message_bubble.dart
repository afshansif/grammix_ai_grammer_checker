import 'package:flutter/material.dart';
import '../models/chat_message.dart';
import '../theme/app_theme.dart';

class MessageBubble extends StatelessWidget {
  final ChatMessage message;
  final VoidCallback? onSave;

  const MessageBubble({super.key, required this.message, this.onSave});

  @override
  Widget build(BuildContext context) {
    final isUser = message.sender == MessageSender.user;

    final Color bubbleColor = message.isError
        ? AppColors.errorBubble
        : (isUser ? AppColors.userBubble : AppColors.assistantBubble);

    final Color textColor =
        message.isError ? AppColors.errorText : AppColors.textPrimary;

    final label = isUser ? 'You' : 'Grammix';

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 560),
        child: Column(
          crossAxisAlignment:
              isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 4, right: 4, bottom: 4),
              child: Text(
                label,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.6,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 2),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: bubbleColor,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                message.text,
                style: TextStyle(color: textColor, fontSize: 15, height: 1.45),
              ),
            ),
            if (onSave != null)
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 4),
                child: InkWell(
                  onTap: onSave,
                  borderRadius: BorderRadius.circular(8),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.download_rounded, size: 14, color: AppColors.accent),
                        SizedBox(width: 4),
                        Text(
                          'Save as .txt',
                          style: TextStyle(color: AppColors.accent, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

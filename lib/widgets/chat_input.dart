import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ChatInput extends StatelessWidget {
  final TextEditingController controller;
  final bool isLoading;
  final VoidCallback onSend;
  final VoidCallback onAttach;

  const ChatInput({
    super.key,
    required this.controller,
    required this.isLoading,
    required this.onSend,
    required this.onAttach,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.accent.withOpacity(0.12)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IconButton(
            tooltip: 'Attach a .txt file',
            onPressed: isLoading ? null : onAttach,
            icon: const Icon(Icons.attach_file_rounded, color: AppColors.textSecondary),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              enabled: !isLoading,
              minLines: 1,
              maxLines: 6,
              style: const TextStyle(color: AppColors.textPrimary),
              decoration: const InputDecoration(
                hintText: 'Type or attach a sentence to check…',
                hintStyle: TextStyle(color: AppColors.textSecondary),
                border: InputBorder.none,
              ),
              onSubmitted: (_) => onSend(),
            ),
          ),
          const SizedBox(width: 2),
          IconButton(
            onPressed: isLoading ? null : onSend,
            icon: isLoading
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.accent,
                    ),
                  )
                : const Icon(Icons.arrow_upward_rounded, color: AppColors.accent),
          ),
        ],
      ),
    );
  }
}

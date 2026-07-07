import 'package:flutter/material.dart';

import 'package:duda_educational_flutter/shared/design_system/components/duda_container.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_text.dart';
import 'package:duda_educational_flutter/shared/design_system/theme/colors.dart';
import 'package:duda_educational_flutter/shared/design_system/theme/radius.dart';
import 'package:duda_educational_flutter/shared/design_system/theme/spacing.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    required this.content,
    required this.time,
    required this.isMe,
    super.key,
    this.senderName,
  });

  final String content;
  final String time;
  final bool isMe;
  final String? senderName;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.md),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.sizeOf(context).width * 0.75,
          ),
          child: DudaContainer(
            padding: const EdgeInsets.all(AppSpacing.md),
            backgroundColor:
                isMe ? AppColors.chatBubbleSent : AppColors.chatBubbleReceived,
            borderRadius: AppRadius.mediumAll,
            boxShadow: const [],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!isMe && senderName != null) ...[
                  DudaText.caption(senderName!, color: AppColors.primary),
                  const SizedBox(height: AppSpacing.xs),
                ],
                DudaText.body(content),
                const SizedBox(height: AppSpacing.xs),
                Align(
                  alignment: Alignment.bottomRight,
                  child: DudaText.caption(time),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

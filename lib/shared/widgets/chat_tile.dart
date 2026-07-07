import 'package:flutter/material.dart';

import 'package:duda_educational_flutter/shared/design_system/components/duda_avatar.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_chip.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_list_tile.dart';
import 'package:duda_educational_flutter/shared/design_system/components/duda_text.dart';
import 'package:duda_educational_flutter/shared/design_system/theme/colors.dart';

class ChatTile extends StatelessWidget {
  const ChatTile({
    required this.participantName,
    required this.participantInitials,
    required this.lastMessage,
    required this.lastMessageTime,
    super.key,
    this.unreadCount = 0,
    this.isOnline = false,
    this.onTap,
  });

  final String participantName;
  final String participantInitials;
  final String lastMessage;
  final String lastMessageTime;
  final int unreadCount;
  final bool isOnline;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return DudaListTile(
      onTap: onTap,
      leading: DudaAvatar(
        initials: participantInitials,
        isOnline: isOnline,
      ),
      title: DudaText.title(participantName),
      subtitle: DudaText.body(
        lastMessage,
        color: AppColors.textSecondary,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          DudaText.caption(lastMessageTime),
          if (unreadCount > 0) ...[
            const SizedBox(height: 4),
            DudaUnreadBadge(count: unreadCount),
          ],
        ],
      ),
    );
  }
}

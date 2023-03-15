import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/data_models/chat_message.data.dart';
import 'package:flex_year_tablet/services/authentication.service.dart';
import 'package:flex_year_tablet/theme.dart';
import 'package:flutter/material.dart';

class MessageItem extends StatelessWidget {
  final ChatMessageData message;
  final bool showDateTime;
  final ValueSetter<int> onTap;

  const MessageItem(this.message,
      {Key? key, this.showDateTime = false, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isSelf = message.senderId == locator<AuthenticationService>().user!.id;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment:
            isSelf ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => onTap(message.messageId),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.8,
              ),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: isSelf ? AppColor.primary : Colors.grey[200],
              ),
              child: Text(
                message.messageContent,
                style: TextStyle(
                  color: isSelf ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
          if (showDateTime) const SizedBox(height: 5),
          if (showDateTime)
            Text(
              message.postedDatetime,
              style: const TextStyle(
                fontSize: 10,
                color: Colors.grey,
              ),
            ),
        ],
      ),
    );
  }
}

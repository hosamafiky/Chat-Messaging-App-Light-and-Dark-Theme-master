import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/chat_message.dart';
import '../../../models/chat_model.dart';
import 'chat_input_field.dart';
import 'message.dart';

class Body extends StatelessWidget {
  const Body(this.chat, {super.key});

  final Chat chat;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: ListView.builder(
              itemCount: demeChatMessages.length,
              itemBuilder: (context, index) => Message(message: demeChatMessages[index], chat: chat),
            ),
          ),
        ),
        const ChatInputField(),
      ],
    );
  }
}

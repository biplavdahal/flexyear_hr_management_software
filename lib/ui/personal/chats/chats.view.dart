import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/ui/personal/chats/chats.argument.dart';
import 'package:flex_year_tablet/ui/personal/chats/chats.model.dart';
import 'package:flex_year_tablet/ui/personal/chats/widgets/message_item.dart';
import 'package:flex_year_tablet/widgets/fy_input_field.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ChatsView extends StatelessWidget {
  static String tag = 'chats_view';

  final Arguments? arguments;

  const ChatsView(this.arguments, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return View<ChatsModel>(
      onDispose: (model) => model.dispose(),
      enableTouchRepeal: true,
      onModelReady: (model) => model.init(arguments as ChatsArgument),
      builder: (ctx, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(model.receiverName),
          ),
          body: model.isLoading
              ? const Center(
                  child: CupertinoActivityIndicator(),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        restorationId: "12",
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        reverse: true,
                        itemBuilder: (context, index) {
                          return MessageItem(
                            model.messages[index],
                            showDateTime: model
                                .showDateTime(model.messages[index].messageId),
                            onTap: (id) => model.showDateTimeFor = id,
                          );
                        },
                        itemCount: model.messages.length,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Container(
                      width: null,
                      color: Colors.grey[50],
                      padding: const EdgeInsets.all(6),
                      child: Row(children: [
                        Expanded(
                          child: FYInputField(
                            title: '',
                            label: 'Write message to ${model.receiverName}...',
                            controller: model.messageController,
                          ),
                        ),
                        if (model.enableSendButton)
                          IconButton(
                            onPressed: model.isBusyWidget('send-btn')
                                ? null
                                : model.sendMessage,
                            icon: model.isBusyWidget('send-btn')
                                ? const CupertinoActivityIndicator()
                                : const Icon(MdiIcons.send),
                          ),
                      ]),
                    ),
                  ],
                ),
        );
      },
    );
  }
}

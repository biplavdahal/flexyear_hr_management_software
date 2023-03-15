import 'package:bestfriend/ui/view.dart';
import 'package:flex_year_tablet/ui/personal/chat_contacts/chat_contacts.model.dart';
import 'package:flex_year_tablet/ui/personal/chats/chats.argument.dart';
import 'package:flex_year_tablet/ui/personal/chats/chats.view.dart';
import 'package:flex_year_tablet/widgets/fy_loader.widget.dart';
import 'package:flutter/material.dart';

class ChatContactsView extends StatelessWidget {
  static String tag = 'chat_contacts_view';

  const ChatContactsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return View<ChatContactsModel>(
      onModelReady: (model) {
        model.init();
      },
      builder: (ctx, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Available recipients'),
          ),
          body: model.isLoading
              ? const FYLinearLoader()
              : RefreshIndicator(
                  onRefresh: model.init,
                  triggerMode: RefreshIndicatorTriggerMode.anywhere,
                  child: ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final _contact = model.contacts[index];

                      return ListTile(
                        onTap: () {
                          model.goto(
                            ChatsView.tag,
                            arguments: ChatsArgument(contact: _contact),
                          );
                        },
                        leading: CircleAvatar(
                          child: Text(_contact.firstName.substring(0, 1)),
                        ),
                        title: Text(
                          '${_contact.firstName} ${_contact.lastName}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(_contact.username),
                        trailing: const Icon(Icons.chevron_right),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: model.contacts.length,
                  ),
                ),
        );
      },
    );
  }
}

import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/data_models/chat_contact.data.dart';
import 'package:flex_year_tablet/services/chat.service.dart';

class ChatContactsModel extends ViewModel with SnackbarMixin {
  final ChatService _chatService = locator<ChatService>();

  List<ChatContactData> _contacts = [];
  List<ChatContactData> get contacts => _contacts;

  Future<void> init() async {
    try {
      setLoading();
      _contacts = await _chatService.getContacts();
      setIdle();
    } catch (e) {
      goBack();
      snackbar.displaySnackbar(
        SnackbarRequest.of(
          message: e.toString(),
        ),
      );
    }
  }
}

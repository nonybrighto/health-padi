import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info/device_info.dart';
import 'package:healthpadi/models/chat.dart';
import 'package:healthpadi/providers/scroll_list_model.dart';
import 'package:healthpadi/services/remote/chat_remote.dart';
import 'package:healthpadi/utilities/load_state.dart';
import 'package:healthpadi/utilities/locator.dart';
import 'package:healthpadi/utilities/response.dart';
// import 'package:healthpadi/utilities/response.dart';
import 'package:uuid/uuid.dart';

class ChatConversationModel extends ScrollListModel<Chat> {
  String _sessionId;
  StreamSubscription<QuerySnapshot> _chatSubscription;
  bool _sendLoading = false;

  ChatRemote chatRemote = locator<ChatRemote>();


  bool get sendLoading => _sendLoading;

  Future<Response> sendBotChat(String message) async {
    try {
      _sendLoading = true;
      notifyListeners();
      final id = Uuid().v4();
      final sessionId = await chatRemote.sendBotMessage(
          id: id, content: message, sessionId: _sessionId);
      if (_sessionId == null) {
        _sessionId = sessionId;
      }
      _sendLoading = false;
    } catch (error) {
      _sendLoading = false;
      return Response(false, error.message);
    }
    notifyListeners();
    return Response(true, 'sent');
  }

  fetchBotChats({Function() onChatAdded}) async {
    if (canLoadMore()) {
      try {
        this.setLoadState(Loading());
        setHasReachedMax(true);
        AndroidDeviceInfo androidInfo = await DeviceInfoPlugin().androidInfo;
        _chatSubscription = Firestore.instance
            .collection('bot_chats')
            .where('deviceIdentifier', isEqualTo: androidInfo.androidId)
            .orderBy('createdAt', descending: true)
            .limit(70)
            .snapshots()
            .listen((messageSnapshot) {
          if (messageSnapshot.documents.isEmpty) {
            this.setLoadState(LoadedEmpty('Start a conversation'));
          } else {
            List<Chat> chats = messageSnapshot.documents.map((document) {
              Chat chat = Chat.fromJson(document.data);
              return chat;
            }).toList();
            setLoadState(Loaded(hasReachedMax: true));
            setItems(chats.reversed.toList());
            onChatAdded();
          }
        }, onError: (error) {
          setLoadState(LoadError(message: 'Could not fetch chats'));
        });
      } catch (error) {
        setLoadState(LoadError(
            message: error?.message != null
                ? error.message
                : 'Could not fetch chats'));
      }
      notifyListeners();
    }
  }

  endCurrentChat() {
    _chatSubscription.cancel();
  }
}

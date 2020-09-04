import 'package:flutter/material.dart';
import 'package:healthpadi/models/chat.dart';
import 'package:healthpadi/providers/chat_conversation_model.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:healthpadi/utilities/constants.dart';
import 'package:healthpadi/utilities/response.dart';
import 'package:healthpadi/widgets/chat_item.dart';
import 'package:healthpadi/widgets/views/scroll_list_view.dart';
import 'package:provider/provider.dart';

class ChatConversationView extends StatefulWidget {
  @override
  _ChatConversationViewState createState() => _ChatConversationViewState();
}

class _ChatConversationViewState extends State<ChatConversationView> {
  TextEditingController _textEditingController;
  ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Column(
        children: <Widget>[
          Expanded(
            child: ScrollListView<ChatConversationModel, Chat>(
              scrollController: _scrollController,
              reverse: true,
              viewModelBuilder: () =>
                  Provider.of<ChatConversationModel>(context),
              onLoad: () =>
                  Provider.of<ChatConversationModel>(context, listen: false)
                      .fetchBotChats(onChatAdded: () {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _scrollController.animateTo(0,
                      duration: Duration(milliseconds: 50),
                      curve: Curves.easeIn);
                });
              }),
              currentListItemWidget:
                  ({int index, Chat item, List<Chat> allItems}) => ChatItem(
                chat: item,
                showHeaderDate: index == allItems.length - 1 ||
                    (index != 0 &&
                        _isNotSameDate(
                            item.createdAt, allItems[index + 1].createdAt)),
              ),
            ),
          ),
          _buildChatSender()
        ],
      ),
    );
  }

  _buildChatSender() {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Color(0XFFe8e8e8),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: 'message...')),
          ),
          Selector<ChatConversationModel, bool>(
              builder: (context, sendLoading, child) => IconButton(
                  icon: sendLoading
                      ? SpinKitThreeBounce(
                          color: Theme.of(context).primaryColor,
                          size: 12,
                        )
                      : Icon(
                          Icons.send,
                          color: Theme.of(context).primaryColor,
                        ),
                  onPressed: sendLoading
                      ? null
                      : () async {
                          if (_textEditingController.text.isNotEmpty) {
                            Response response =
                                await Provider.of<ChatConversationModel>(
                                        context,
                                        listen: false)
                                    .sendBotChat(_textEditingController.text);
                            if (!response.success) {
                              Scaffold.of(context).showSnackBar(
                                  SnackBar(content: Text(response.message)));
                            } else {
                              _textEditingController.text = '';
                            }
                          } else {
                            Scaffold.of(context).showSnackBar(SnackBar(
                                content:
                                    Text('Please enter a message to send')));
                          }
                        }),
              selector: (_, chatConversationModel) =>
                  chatConversationModel.sendLoading)
        ],
      ),
    );
  }

  _isNotSameDate(DateTime currentChatDate, DateTime previousChatDate) {
    return !(currentChatDate.day == previousChatDate.day &&
        currentChatDate.month == previousChatDate.month &&
        currentChatDate.year == previousChatDate.year);
  }
}

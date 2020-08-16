import 'package:flutter/material.dart';
import 'package:healthpadi/models/chat.dart';
import 'package:healthpadi/utilities/constants.dart';
import 'package:healthpadi/utilities/general_utils.dart';

class ChatItem extends StatelessWidget {
  final Chat chat;
  final bool showHeaderDate;
  final bool showAvatar;
  ChatItem({this.chat, this.showHeaderDate = false, this.showAvatar = true});
  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          if (showHeaderDate) _buildDateDisplay(),
          _buildChatRow(context)
        ],
      );
  }

  _buildDateDisplay() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      child: Stack(
        children: <Widget>[
          Divider(color: Colors.grey, thickness: 1,),
          Center(child: Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 7),
            child: Text(stringDateFromDate(chat.createdAt), style: TextStyle(color: Colors.grey),),
          ))
        ],
      ),
    );
  }

  _buildChatRow(context) {
    final isRight = !chat.isBotMessage;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: isRight
          ? Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                _buildContentHolder(
                    context, chat.content, chat.createdAt, isRight),
                SizedBox(
                  width: 10,
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                if(showAvatar) _buildAvatar(),
                SizedBox(
                  width: 10,
                ),
                _buildContentHolder(
                    context, chat.content, chat.createdAt, isRight),
              ],
            ),
    );
  }

  _buildContentHolder(
      BuildContext context, String content, DateTime chatDate, bool isRight) {
    Radius radius = Radius.circular(30);
    return Column(
      crossAxisAlignment:
          isRight ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(15),
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 3 / 4),
          decoration: BoxDecoration(
              color: (isRight)
                  ? Theme.of(context).primaryColor
                  : Color(0XFFF3F3F3),
              borderRadius: (isRight)
                  ? BorderRadius.only(
                      topLeft: radius, topRight: radius, bottomLeft: radius)
                  : BorderRadius.only(
                      bottomLeft: radius, topRight: radius, bottomRight: radius)),
          child: Text(
            content,
            style: TextStyle(
                color: isRight
                    ? Colors.white
                    : Theme.of(context).textTheme.bodyText1.color),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 3),
          child: Text(
            stringTimeFromDate(chatDate),
            style: TextStyle(
                fontSize: 10,
                color: Color(0XFFa0a0a0),
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  _buildAvatar() {
    return (showAvatar)
        ? CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage('assets/avatars/bot.jpg'),
          )
        : SizedBox(
            width: 50,
          );
  }
}

import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:healthpadi/utilities/connections.dart';

class ChatRemote {
  Future<String> sendBotMessage({ String id, String content, String sessionId}) async {
    try {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      Response chatSendResponse = await (await baseDio()).post('/chats/bot', data: {'content': content, 'deviceIdentifier': androidInfo.androidId, 'id': id, 'sessionId': sessionId});

      return chatSendResponse.data;
    } catch (error) {
      return handleError(error: error, message: 'getting chats with bot');
    }
  }
}

part of 'api.dart';

// ignore: library_private_types_in_public_api
extension ApiMessage on _Api {
  /// 获取服务消息列表
  Future<List<ServiceMessageModel>> getServiceMessageList({
    required int page,
    int pageSize = 20,
  }) async {
    try {
      final response = await httpInstance.get(
        url: 'sys/service/messageList',
        queryMap: {
          'page': page,
          'pageSize': pageSize,
        },
        complete: ServiceMessageModel.fromJson,
      );
      return response ?? [];
    } catch (e) {
      return [];
    }
  }

  ///获取私聊消息列表 特殊原因，每页100条
  Future<List<PrivateMessageModel>> getPrivateMessageList({
    required int page,
    int pageSize = 100,
  }) async {
    try {
      final response = await httpInstance.get(
        url: 'privateChat/chatList',
        queryMap: {
          'page': page,
          'pageSize': pageSize,
        },
        complete: PrivateMessageModel.fromJson,
      );
      return response ?? [];
    } catch (e) {
      return [];
    }
  }

  ///获取私聊消息次数
  Future<PrivateMessageDetailModel?> getPrivateMessageCount(
      {required int toUserId}) async {
    try {
      final response = await httpInstance.get(
        url: 'privateChat/detail',
        queryMap: {'toUserId': toUserId},
        complete: PrivateMessageDetailModel.fromJson,
      );
      return response;
    } catch (e) {
      return null;
    }
  }

  ///清空私聊消息列表
  Future<bool> clearPrivateMessageList() async {
    try {
      await httpInstance.post(
        url: 'privateChat/clearChat',
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  ///删除私聊消息
  Future<bool> deletePrivateMessage({required int toUserId}) async {
    try {
      await httpInstance.post(
        url: 'privateChat/delChat',
        body: {
          'toUserId': toUserId,
        },
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  ///发送消息
  Future<bool> sendMessage({
    required int toUserId,
    required String content,
    int? quoteMsgId,
    List<String>? images,
  }) async {
    try {
      final request = {
        'content': content,
        'toUserId': toUserId,
        'quoteMsgId': quoteMsgId,
        'images': images,
      };

      await httpInstance.post(
        url: 'privateChat/send',
        body: request,
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  ///获取消息列表
  Future<List<MessageModel>> getMessageList({
    required int lastId,
    required int toUserId,
    int pageSize = 100,
  }) async {
    try {
      final response = await httpInstance.get(
        url: 'privateChat/messageList',
        queryMap: {
          'toUserId': toUserId,
          'lastId': lastId,
          'pageSize': pageSize,
        },
        complete: MessageModel.fromJson,
      );
      return response ?? [];
    } catch (e) {
      return [];
    }
  }

  ///获取搜索消息列表
  Future<List<MessageModel>> getMessageSearchList({
    required String content,
    int pageSize = 50,
  }) async {
    try {
      final response = await httpInstance.get(
        url: 'privateChat/message/search',
        queryMap: {
          'content': content,
          'pageSize': pageSize,
        },
        complete: MessageModel.fromJson,
      );
      return response ?? [];
    } catch (e) {
      return [];
    }
  }

  ///购买聊天次数
  Future<bool> buyChatNumber({required int productId}) async {
    try {
      await httpInstance.post(
        url: 'privateChat/pur/chatNum',
        body: {
          'productId': productId,
        },
      );
      return true;
    } catch (e) {
      return false;
    }
  }
}

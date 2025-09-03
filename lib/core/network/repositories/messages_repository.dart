// import 'package:memory_cloud/config/network_manager/dio/dio_client.dart';
// import 'package:memory_cloud/config/network_manager/dio/endpoints.dart';
// import 'package:memory_cloud/models/messages_model/get_messages_model.dart';
// import 'package:memory_cloud/models/response_msg_model/response_message_model.dart';

// abstract class MessagesService {
//   Future<List<GetMessagesModel>> getAllMessagesData();
//   Future<List<GetMessagesModel>> getGmailAccountMessages();
//   Future<dynamic> checkGmailAuthorization();
//   Future<dynamic> getAuthorizeUrl();
//   Future<ResponseMessageModel> deleteMessage({
//     required Map<String, dynamic> textIds,
//   });
//   Future<ResponseMessageModel> uploadMessageData({
//     required Map<String, dynamic> data,
//   });
// }

// class MessagesRepository implements MessagesService {
//   final DioClient _dioClient = DioClient();
//   @override
//   Future<List<GetMessagesModel>> getAllMessagesData() async {
//     final response = await _dioClient.request(
//       method: 'GET',
//       url: Endpoints.getAllMessagesUrl,
//       decoder: (data) {
//         return (data as List<dynamic>)
//             .map((item) => GetMessagesModel.fromJson(item))
//             .toList();
//       },
//     );

//     return response;
//   }

//   @override
//   Future<List<GetMessagesModel>> getGmailAccountMessages() async {
//     final response = await _dioClient.request(
//       method: 'GET',
//       url: Endpoints.getAllMessagesUrl,
//       decoder: (data) {
//         return (data as List<dynamic>)
//             .map((item) => GetMessagesModel.fromJson(item))
//             .toList();
//       },
//     );

//     return response;
//   }

//   @override
//   Future<dynamic> checkGmailAuthorization() async {
//     final response = await _dioClient.request(
//       method: 'Get',
//       url: Endpoints.gmailAuthCheck,
//     );
//     return response;
//   }

//   @override
//   Future<dynamic> getAuthorizeUrl() async {
//     final response = await _dioClient.request(
//       method: 'Get',
//       url: Endpoints.getGmailAuthUrl,
//     );
//     return response;
//   }

//   @override
//   Future<ResponseMessageModel> uploadMessageData({
//     required Map<String, dynamic> data,
//   }) async {
//     ResponseMessageModel response = await _dioClient.request(
//       method: 'PATCH',
//       url: Endpoints.getAllMessagesUrl,
//       body: data,
//       decoder: (data) => ResponseMessageModel.fromJson(data),
//     );
//     return response;
//   }

//   @override
//   Future<ResponseMessageModel> deleteMessage({
//     required Map<String, dynamic> textIds,
//   }) async {
//     final response = await _dioClient.request(
//       method: 'DELETE',
//       url: Endpoints.getAllMessagesUrl,
//       body: textIds,
//       decoder: (data) {
//         return ResponseMessageModel.fromJson(data);
//       },
//     );
//     return response;
//   }
// }

// import 'package:memory_cloud/config/network_manager/dio/dio_client.dart';
// import 'package:memory_cloud/config/network_manager/dio/endpoints.dart';
// import 'package:memory_cloud/models/media_model/media_model.dart';
// import 'package:memory_cloud/models/response_msg_model/response_message_model.dart';

// abstract class MediaService {
//   Future<ResponseMessageModel> deleteMedia(int mediaId);
//   Future<GetMediaDetailsModel> getSingleMediaDetails(int mediaId);
//   Future<ResponseMessageModel> deleteMultipleMedia({
//     required Map<String, dynamic> mediaIds,
//   });
// }

// class MediaRepository implements MediaService {
//   final DioClient _dioClient = DioClient();
//   @override
//   Future<ResponseMessageModel> deleteMedia(int mediaId) async {
//     ResponseMessageModel response = await _dioClient.request(
//       method: 'DELETE',
//       url: "${Endpoints.mediaUrl}/$mediaId",
//       decoder: (data) => ResponseMessageModel.fromJson(data),
//     );
//     return response;
//   }

//   @override
//   Future<GetMediaDetailsModel> getSingleMediaDetails(int mediaId) async {
//     GetMediaDetailsModel response = await _dioClient.request(
//       method: 'GET',
//       url: "${Endpoints.mediaUrl}/$mediaId",
//       decoder: (data) => GetMediaDetailsModel.fromJson(data),
//     );
//     return response;
//   }

//   @override
//   Future<ResponseMessageModel> deleteMultipleMedia({
//     required Map<String, dynamic> mediaIds,
//   }) async {
//     final response = await _dioClient.request(
//       method: 'DELETE',
//       url: Endpoints.updateMutipleMediaUrl,
//       body: mediaIds,
//       decoder: (data) {
//         return ResponseMessageModel.fromJson(data);
//       },
//     );
//     return response;
//   }
// }

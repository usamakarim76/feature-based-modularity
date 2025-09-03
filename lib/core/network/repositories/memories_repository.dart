// import 'package:dio/dio.dart';
// import 'package:http_parser/http_parser.dart';
// import 'package:memory_cloud/config/network_manager/dio/dio_client.dart';
// import 'package:memory_cloud/config/network_manager/dio/endpoints.dart';
// import 'package:memory_cloud/models/memories_model/get_memories_model.dart';
// import 'package:memory_cloud/models/response_msg_model/response_message_model.dart';

// abstract class MemoriesService {
//   Future<List<GetMemoriesModel>> getAllMediaData();
//   Future<ResponseMessageModel> postMediaData(List<Map<String, dynamic>> data);
//   Future<ResponseMessageModel> postThumbnail(List<Map<String, dynamic>> data);
// }

// class MemoriesRepository implements MemoriesService {
//   final DioClient _dioClient = DioClient();
//   @override
//   Future<List<GetMemoriesModel>> getAllMediaData() async {
//     List<GetMemoriesModel> response = await _dioClient.request(
//         method: 'GET',
//         url: Endpoints.mediaUrl,
//         decoder: (data) {
//           return (data as List<dynamic>)
//               .map((item) => GetMemoriesModel.fromJson(item))
//               .toList();
//         });
//     return response;
//   }

//   @override
//   Future<ResponseMessageModel> postMediaData(
//       List<Map<String, dynamic>> data) async {
//     // Create a list of MultipartFile from the list
//     List<MultipartFile> files = await Future.wait(
//       data.map((media) async {
//         return await MultipartFile.fromFile(
//           media['path'],
//           filename: media['path'].split('/').last,
//           contentType: media['id'] == 1
//               ? MediaType('image', 'png')
//               : media['id'] == 2
//                   ? MediaType('video', 'mp4')
//                   : media['id'] == 3
//                       ? MediaType('audio', 'mp3')
//                       : null,
//         );
//       }).toList(),
//     );

//     // Create FormData and add the list of files under the 'files' key
//     FormData formData = FormData.fromMap({
//       'files': files,
//     });

//     ResponseMessageModel response = await _dioClient.request(
//       method: 'POST',
//       url: Endpoints.mediaUrl,
//       body: formData,
//       decoder: (data) => ResponseMessageModel.fromJson(data),
//     );

//     return response;
//   }

//   @override
//   Future<ResponseMessageModel> postThumbnail(
//       List<Map<String, dynamic>> data) async {
//     // Create a list of MultipartFile from the XFile list
//     List<MultipartFile> files = await Future.wait(
//       data.map((image) async {
//         return await MultipartFile.fromFile(
//           image['thumbnail'],
//           filename: image['thumbnail'].split('/').last,
//           contentType: MediaType('image', 'png'),
//         );
//       }).toList(),
//     );

//     // Create FormData and add the list of files under the 'files' key
//     FormData formData = FormData.fromMap({
//       'files': files,
//     });

//     ResponseMessageModel response = await _dioClient.request(
//       method: 'POST',
//       url: Endpoints.videoThumbnails,
//       body: formData,
//       decoder: (data) => ResponseMessageModel.fromJson(data),
//     );
//     return response;
//   }
// }

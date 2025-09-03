// import 'package:dio/dio.dart';
// import 'package:http_parser/http_parser.dart';
// import 'package:memory_cloud/config/network_manager/dio/dio_client.dart';
// import 'package:memory_cloud/config/network_manager/dio/endpoints.dart';
// import 'package:memory_cloud/models/response_msg_model/response_message_model.dart';
// import 'package:memory_cloud/models/videos_model/get_videos_model.dart';

// abstract class VideosService {
//   Future<List<GetAllVideosModel>> getAllVideosData();
//   Future<ResponseMessageModel> addVideoData(
//     List<Map<String, dynamic>> data,
//     Function(double)? onProgress,
//   );
//   Future<ResponseMessageModel> postThumbnail(List<Map<String, dynamic>> data);
// }

// class VideosRepository implements VideosService {
//   final DioClient _dioClient = DioClient();
//   @override
//   Future<List<GetAllVideosModel>> getAllVideosData() async {
//     List<GetAllVideosModel> response = await _dioClient.request(
//         method: 'GET',
//         url: Endpoints.getAllVideosUrl,
//         decoder: (data) {
//           return (data as List<dynamic>)
//               .map((item) => GetAllVideosModel.fromJson(item))
//               .toList();
//         });
//     return response;
//   }

//   @override
//   Future<ResponseMessageModel> addVideoData(
//     List<Map<String, dynamic>> data,
//     Function(double)? onProgress,
//   ) async {
//     // Create a list of MultipartFile from the list
//     List<MultipartFile> files = await Future.wait(
//       data.map((video) async {
//         return await MultipartFile.fromFile(
//           video['path'],
//           filename: video['path'].split('/').last,
//           contentType: MediaType('video', 'mp4'),
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
//       onProgress: (progress) {
//         if (onProgress != null) {
//           onProgress(progress);
//         }
//       },
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

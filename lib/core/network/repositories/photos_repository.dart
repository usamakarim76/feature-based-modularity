// import 'package:dio/dio.dart';
// import 'package:http_parser/http_parser.dart';
// import 'package:memory_cloud/config/network_manager/dio/dio_client.dart';
// import 'package:memory_cloud/config/network_manager/dio/endpoints.dart';
// import 'package:memory_cloud/models/photos_model/get_photos_model.dart';
// import 'package:memory_cloud/models/response_msg_model/response_message_model.dart';

// abstract class PhotosService {
//   Future<List<GetAllPhotosModel>> getAllPhotosData();
//   Future<ResponseMessageModel> postAddPhotos(List<Map<String, dynamic>> data);
// }

// class PhotosRepository implements PhotosService {
//   final DioClient _dioClient = DioClient();
//   @override
//   Future<List<GetAllPhotosModel>> getAllPhotosData() async {
//     List<GetAllPhotosModel> response = await _dioClient.request(
//         method: 'GET',
//         url: Endpoints.getAllPhotosUrl,
//         decoder: (data) {
//           return (data as List<dynamic>)
//               .map((item) => GetAllPhotosModel.fromJson(item))
//               .toList();
//         });
//     return response;
//   }

//   @override
//   Future<ResponseMessageModel> postAddPhotos(
//       List<Map<String, dynamic>> images) async {
//     // Create a list of MultipartFile from the XFile list
//     List<MultipartFile> files = await Future.wait(
//       images.map((image) async {
//         return await MultipartFile.fromFile(
//           image['path'],
//           filename: image['path'].split('/').last,
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
//       url: Endpoints.mediaUrl,
//       body: formData,
//       decoder: (data) => ResponseMessageModel.fromJson(data),
//     );
//     return response;
//   }
// }

// import 'package:dio/dio.dart';
// import 'package:http_parser/http_parser.dart';
// import 'package:memory_cloud/config/network_manager/dio/dio_client.dart';
// import 'package:memory_cloud/config/network_manager/dio/endpoints.dart';
// import 'package:memory_cloud/models/response_msg_model/response_message_model.dart';
// import 'package:memory_cloud/models/voice_model/get_voice_model.dart';

// abstract class VoicesService {
//   Future<List<GetVoiceModel>> getAllVoicesData();
//   Future<ResponseMessageModel> postVoiceData(List<Map<String, dynamic>> data);
// }

// class VoicesRepository implements VoicesService {
//   final DioClient _dioClient = DioClient();
//   @override
//   Future<List<GetVoiceModel>> getAllVoicesData() async {
//     final response = await _dioClient.request(
//         method: 'GET',
//         url: Endpoints.getAllAudiosUrl,
//         decoder: (data) {
//           return (data as List<dynamic>)
//               .map((item) => GetVoiceModel.fromJson(item))
//               .toList();
//         });
//     return response;
//   }

//   @override
//   Future<ResponseMessageModel> postVoiceData(
//       List<Map<String, dynamic>> data) async {
//     // Create a list of MultipartFile from the list
//     List<MultipartFile> files = await Future.wait(
//       data.map((audio) async {
//         return await MultipartFile.fromFile(
//           audio['path'],
//           filename: audio['path'].split('/').last,
//           contentType:
//               MediaType('audio', 'mp3'), // Adjust MIME type if necessary
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

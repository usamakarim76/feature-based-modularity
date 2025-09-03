// import 'package:dio/dio.dart';
// import 'package:http_parser/http_parser.dart';
// import 'package:memory_cloud/config/network_manager/dio/dio_client.dart';
// import 'package:memory_cloud/config/network_manager/dio/endpoints.dart';
// import 'package:memory_cloud/models/cloned_voice_model/create_cloned_voice_message_model.dart';
// import 'package:memory_cloud/models/cloned_voice_model/get_all_cloned_audios_model.dart';
// import 'package:memory_cloud/models/cloned_voice_model/get_cloned_voices_model.dart';
// import 'package:memory_cloud/models/response_msg_model/response_message_model.dart';

// abstract class ClonedVoiceService {
//   Future<List<GetAllClonedAudiosModel>> getClonedVoiceData();
//   Future<List<GetClonedVoicesModel>> getAllVoiceData();
//   Future<ResponseMessageModel> createCustomVoice({
//     required Map<String, dynamic> cloneData,
//     required List<Map<String, dynamic>> voices,
//   });
//   Future<CreateClonedVoiceMessageModel> cloneAudioFile(
//     Map<String, dynamic> data,
//     // GetClonedVoicesModel data,
//     // int mediaVoiceId,
//   );
//   Future<ResponseMessageModel> deleteCloneVoice({
//     required Map<String, dynamic> mediaIds,
//   });
// }

// class ClonedVoiceRepository extends ClonedVoiceService {
//   final DioClient _dioClient = DioClient();
//   @override
//   Future<List<GetAllClonedAudiosModel>> getClonedVoiceData() async {
//     List<GetAllClonedAudiosModel> response = await _dioClient.request(
//       method: 'GET',
//       url: Endpoints.getAllClonedAudioUrl,
//       decoder: (model) {
//         return (model as List<dynamic>)
//             .map((item) => GetAllClonedAudiosModel.fromJson(item))
//             .toList();
//       },
//     );
//     return response;
//   }

//   @override
//   Future<List<GetClonedVoicesModel>> getAllVoiceData() async {
//     List<GetClonedVoicesModel> response = await _dioClient.request(
//       method: 'GET',
//       url: Endpoints.getAllClonedAudioUrl,
//       decoder: (model) {
//         return (model as List<dynamic>)
//             .map((item) => GetClonedVoicesModel.fromJson(item))
//             .toList();
//       },
//     );
//     return response;
//   }

//   @override
//   Future<ResponseMessageModel> createCustomVoice({
//     required Map<String, dynamic> cloneData,
//     required List<Map<String, dynamic>> voices,
//   }) async {
//     List<MultipartFile> files = await Future.wait(
//       voices.map((audio) async {
//         return await MultipartFile.fromFile(
//           audio['path'],
//           filename: audio['path'].split('/').last,
//           contentType: MediaType('audio', 'mp3'),
//         );
//       }).toList(),
//     );
//     // Create FormData and add the list of files under the 'files' key
//     FormData formData = FormData.fromMap({
//       'files': files,
//       ...cloneData,
//     });
//     ResponseMessageModel response = await _dioClient.request(
//       method: 'POST',
//       url: Endpoints.createCustomVoiceUrl,
//       body: formData,
//       decoder: (model) {
//         return ResponseMessageModel.fromJson(model);
//       },
//     );
//     return response;
//   }

//   @override
//   Future<CreateClonedVoiceMessageModel> cloneAudioFile(
//     Map<String, dynamic> data,
//   ) async {
//     CreateClonedVoiceMessageModel response = await _dioClient.request(
//       method: 'POST',
//       url: Endpoints.cloneAudioFileUrl,
//       body: data,
//       decoder: (model) => CreateClonedVoiceMessageModel.fromJson(model),
//     );
//     return response;
//   }

//   @override
//   Future<ResponseMessageModel> deleteCloneVoice({
//     required Map<String, dynamic> mediaIds,
//   }) async {
//     ResponseMessageModel response = await _dioClient.request(
//       method: 'DELETE',
//       url: Endpoints.deleteMultipleCloneVoices,
//       body: mediaIds,
//       decoder: (data) => ResponseMessageModel.fromJson(data),
//     );
//     return response;
//   }
// }

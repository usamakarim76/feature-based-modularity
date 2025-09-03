// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:memory_cloud/config/network_manager/dio/dio_client.dart';
// import 'package:memory_cloud/config/network_manager/dio/endpoints.dart';
// import 'package:memory_cloud/models/people_model/get_all_people_model.dart';
// import 'package:memory_cloud/models/people_model/get_single_person_model.dart';
// import 'package:memory_cloud/models/response_msg_model/response_message_model.dart';
// import 'package:http_parser/http_parser.dart';

// // import 'package:memory_cloud/data/network/base_api_services.dart';
// // import 'package:memory_cloud/data/network/network_api_services.dart';

// abstract class PeopleService {
//   // Future<dynamic> addPeople(File image, Map<String, dynamic> data);
//   Future<ResponseMessageModel> addPeople(File image, String name);
//   Future<List<GetAllPeopleModel>> getAllPeople();
//   Future<GetPersonMediaModel> getSinglePersonData(int personId);
//   Future<dynamic> submitUpdateDetails(
//       String mediaId, Map<String, dynamic> data);
//   Future<ResponseMessageModel> submitMultipleUpdateDetails(
//       Map<String, dynamic> data);
//   Future<ResponseMessageModel> deleteSinglePersonData(int personId);
// }

// class PeopleRepository implements PeopleService {
//   // final BaseApiServices _apiService = NetworkApiService();
//   final DioClient _dioClient = DioClient();

//   @override
//   Future<ResponseMessageModel> addPeople(File image, String name) async {
//     // Prepare FormData with the converted PNG file
//     final formData = FormData.fromMap({
//       'name': name,
//       'profile-image': await MultipartFile.fromFile(
//         image.path,
//         filename: image.path.split('/').last,
//         contentType: MediaType('image', 'png'),
//       ),
//     });
//     ResponseMessageModel response = await _dioClient.request(
//       method: 'POST',
//       url: Endpoints.addPeopleUrl,
//       body: formData,
//       decoder: (data) => ResponseMessageModel.fromJson(data),
//     );
//     return response;
//   }

//   @override
//   Future<List<GetAllPeopleModel>> getAllPeople() async {
//     List<GetAllPeopleModel> response = await _dioClient.request(
//       method: 'GET',
//       url: Endpoints.getAllPeopleUrl,
//       decoder: (data) {
//         return (data as List<dynamic>)
//             .map((item) => GetAllPeopleModel.fromJson(item))
//             .toList();
//       },
//     );
//     return response;
//   }

//   @override
//   Future<GetPersonMediaModel> getSinglePersonData(int personId) async {
//     final response = await _dioClient.request(
//       method: 'GET',
//       url: Endpoints.getAllPeopleUrl + personId.toString(),
//       decoder: (data) {
//         return GetPersonMediaModel.fromJson(data);
//       },
//     );
//     return response;
//   }

//   @override
//   Future<dynamic> submitUpdateDetails(
//       String mediaId, Map<String, dynamic> data) async {
//     final response = await _dioClient.request(
//       method: 'PATCH',
//       url: Endpoints.updateSingleMedia + mediaId,
//       body: data,
//     );
//     return response;
//   }

//   @override
//   Future<ResponseMessageModel> submitMultipleUpdateDetails(
//       Map<String, dynamic> data) async {
//     final response = await _dioClient.request(
//       method: 'PATCH',
//       url: Endpoints.updateMutipleMediaUrl,
//       body: data,
//       decoder: (data) => ResponseMessageModel.fromJson(data),
//     );
//     return response;
//   }

//   @override
//   Future<ResponseMessageModel> deleteSinglePersonData(int personId) async {
//     final response = await _dioClient.request(
//       method: 'DELETE',
//       url: Endpoints.getAllPeopleUrl + personId.toString(),
//       decoder: (data) {
//         return ResponseMessageModel.fromJson(data);
//       },
//     );
//     return response;
//   }
// }

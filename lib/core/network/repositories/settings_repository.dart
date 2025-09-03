// import 'dart:convert';

// import 'package:dio/dio.dart';
// import 'package:http_parser/http_parser.dart';
// import 'package:memory_cloud/config/network_manager/dio/dio_client.dart';
// import 'package:memory_cloud/config/network_manager/dio/endpoints.dart';
// import 'package:memory_cloud/models/filter_data_model/filter_data_model.dart';
// import 'package:memory_cloud/models/response_msg_model/response_message_model.dart';
// import 'package:memory_cloud/models/settings_model/get_all_filter_model.dart';

// abstract class SettingsService {
//   Future<List<GetAllFilterModel>> getUserFilters();
//   Future<ResponseMessageModel> addCustomFilter(String name);
//   Future<ResponseMessageModel> updateCustomFilter(int id, String name);
//   Future<ResponseMessageModel> deleteFilter(int id);
//   Future<List<GetAllFilterModel>> getAllFilters();
//   Future<GetFilterDataModel> getSingleFilterData({
//     required int filterId,
//   });
//   Future<ResponseMessageModel> deleteUserAccount();
//   Future<ResponseMessageModel> logoutUserAccount();
//   Future<void> uploadProfileImage({
//     required Map<String, dynamic> image,
//     required String userName,
//   });
//   Future<void> getProfileImage();
// }

// class SettingsRepository implements SettingsService {
//   final DioClient _dioClient = DioClient();
//   @override
//   Future<List<GetAllFilterModel>> getUserFilters() async {
//     List<GetAllFilterModel> response = await _dioClient.request(
//         method: 'GET',
//         url: Endpoints.filters,
//         decoder: (data) {
//           return (data as List<dynamic>)
//               .map((item) => GetAllFilterModel.fromJson(item))
//               .toList();
//         });
//     return response;
//   }

//   @override
//   Future<ResponseMessageModel> addCustomFilter(String name) async {
//     Map<String, dynamic> data = {
//       "name": name,
//     };
//     final bodyData = jsonEncode(data);
//     final response = await _dioClient.request(
//       method: 'POST',
//       url: Endpoints.createFilter,
//       body: bodyData,
//       decoder: (data) {
//         return ResponseMessageModel.fromJson(data);
//       },
//     );
//     return response;
//   }

//   @override
//   Future<ResponseMessageModel> updateCustomFilter(int id, String name) async {
//     Map<String, String> data = {
//       "name": name,
//     };
//     final bodyData = jsonEncode(data);
//     final response = await _dioClient.request(
//       method: 'PATCH',
//       url: "${Endpoints.createFilter}/$id",
//       body: bodyData,
//       decoder: (data) {
//         return ResponseMessageModel.fromJson(data);
//       },
//     );
//     return response;
//   }

//   @override
//   Future<ResponseMessageModel> deleteFilter(int id) async {
//     final response = await _dioClient.request(
//       method: 'DELETE',
//       url: "${Endpoints.createFilter}/$id",
//       decoder: (data) {
//         return ResponseMessageModel.fromJson(data);
//       },
//     );
//     return response;
//   }

//   @override
//   Future<List<GetAllFilterModel>> getAllFilters() async {
//     List<GetAllFilterModel> response = await _dioClient.request(
//         method: 'GET',
//         url: Endpoints.allFilters,
//         decoder: (data) {
//           return (data as List<dynamic>)
//               .map((item) => GetAllFilterModel.fromJson(item))
//               .toList();
//         });
//     return response;
//   }

//   @override
//   Future<ResponseMessageModel> deleteUserAccount() async {
//     final response = await _dioClient.request(
//       method: 'DELETE',
//       url: Endpoints.deleteUserAccountUrl,
//       decoder: (data) {
//         return ResponseMessageModel.fromJson(data);
//       },
//     );
//     return response;
//   }

//   @override
//   Future<ResponseMessageModel> logoutUserAccount() async {
//     final response = await _dioClient.request(
//       method: 'POST',
//       url: Endpoints.logOutUrl,
//       decoder: (data) {
//         return ResponseMessageModel.fromJson(data);
//       },
//     );
//     return response;
//   }

//   @override
//   Future uploadProfileImage({
//     required Map<String, dynamic> image,
//     required String userName,
//   }) async {
//     MultipartFile file = await MultipartFile.fromFile(
//       image['path'],
//       filename: image['path'].split('/').last,
//       contentType: MediaType('image', 'png'),
//     );

//     // Create FormData and add the list of files under the 'files' key
//     FormData formData = FormData.fromMap({
//       'profile-photo': file,
//       'name': userName,
//     });

//     // ResponseMessageModel
//     final response = await _dioClient.request(
//       method: 'POST',
//       url: Endpoints.uploadAndGetProfileImageUrl,
//       body: formData,
//       // decoder: (data) => ResponseMessageModel.fromJson(data),
//     );
//     return response;
//   }

//   @override
//   Future getProfileImage() async {
//     final response = await _dioClient.request(
//       method: 'GET',
//       url: Endpoints.uploadAndGetProfileImageUrl,
//       // decoder: (data) {
//       //   return (data as List<dynamic>)
//       //       .map((item) => GetAllFilterModel.fromJson(item))
//       //       .toList();
//       // });
//     );
//     return response;
//   }

//   @override
//   Future<GetFilterDataModel> getSingleFilterData({
//     required int filterId,
//   }) async {
//     GetFilterDataModel response = await _dioClient.request(
//         method: 'GET',
//         url: Endpoints.getSingleFilterDataUrl + filterId.toString(),
//         decoder: (data) {
//           return GetFilterDataModel.fromJson(data);
//         });
//     return response;
//   }
// }

// // import 'package:memory_cloud/config/apis_config/apis_config.dart';
// import 'package:memory_cloud/config/network_manager/dio/dio_client.dart';
// import 'package:memory_cloud/config/network_manager/dio/endpoints.dart';
// // import 'package:memory_cloud/data/network/base_api_services.dart';
// // import 'package:memory_cloud/data/network/network_api_services.dart';
// import 'package:memory_cloud/models/response_msg_model/response_message_model.dart';

// abstract class ForgotPassword {
//   Future<ResponseMessageModel> forgotPasswordStepFirst(
//       Map<String, dynamic> forgotData);
//   // Future<dynamic> forgotPasswordStepSecond(Map<String, dynamic> registerData);
//   // Future<dynamic> forgotPasswordStepThird(Map<String, dynamic> registerData);
// }

// class ForgotPasswordRepository implements ForgotPassword {
//   // final BaseApiServices _apiService = NetworkApiService();
//   final DioClient _dioClient = DioClient();
//   @override
//   Future<ResponseMessageModel> forgotPasswordStepFirst(
//       Map<String, dynamic> forgotData) async {
//     ResponseMessageModel response = await _dioClient.request(
//         method: 'POST',
//         url: Endpoints.forgotPasswordUrl,
//         body: forgotData,
//         decoder: (data) {
//           return ResponseMessageModel.fromJson(data);
//         });
//     return response;
//   }
//   // Future<ResponseMessageModel> forgotPasswordStepFirst(
//   //   Map<String, dynamic> forgotData) async {
//   // dynamic response = await _apiService.postApiResponse(
//   //     ApiConfig.forgotPasswordUrl, forgotData);
//   // return ResponseMessageModel.fromJson(response);
//   // }

//   // @override
//   // Future<dynamic> forgotPasswordStepSecond(
//   //     Map<String, dynamic> registerData) async {
//   //   dynamic response = await _apiService.postApiResponse(
//   //       ApiConfig.forgotPassEndPoint, registerData);
//   //   return response;
//   // }

//   // @override
//   // Future<dynamic> forgotPasswordStepThird(
//   //     Map<String, dynamic> registerData) async {
//   //   dynamic response = await _apiService.postApiResponse(
//   //       ApiConfig.forgotPassEndPoint, registerData);
//   //   return response;
//   // }
// }

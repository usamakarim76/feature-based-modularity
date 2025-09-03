// import 'package:memory_cloud/config/network_manager/dio/dio_client.dart';
// import 'package:memory_cloud/config/network_manager/dio/endpoints.dart';
// import 'package:memory_cloud/models/auth_model/user_model.dart';

// abstract class Authentication {
//   Future<UserModel> login(Map<String, dynamic> loginData);
//   Future<UserModel> register(Map<String, dynamic> registerData);
// }

// class AuthRepository implements Authentication {
//   final DioClient _dioClient = DioClient();
//   @override
//   Future<UserModel> login(Map<String, dynamic> loginData) async {
//     UserModel response = await _dioClient.request(
//       method: 'POST',
//       url: Endpoints.loginUrl,
//       body: loginData,
//       decoder: (data) {
//         return UserModel.fromJson(data);
//       },
//     );
//     return response;
//   }

//   @override
//   Future<UserModel> register(Map<String, dynamic> registerData) async {
//     UserModel response = await _dioClient.request(
//       method: 'POST',
//       url: Endpoints.signUpUrl,
//       body: registerData,
//       decoder: (data) {
//         return UserModel.fromJson(data);
//       },
//     );
//     return response;
//   }
// }

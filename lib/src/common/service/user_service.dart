import 'dart:convert';
import 'package:shelf/shelf.dart';

import '../constants/constants.dart';
import '../dto/api_response.dart';
import '../dto/sign_up.dart';
import '../models/user_model.dart';
import '../repository/user_repository.dart';

class UserService {
  UserService({required final IUserRepository userRepository})
      : _userRepository = userRepository;

  final IUserRepository _userRepository;

  IUserRepository get userRepository => _userRepository;

  Response login(Map<String, Object?> json) {
    ApiResponse<UserModel> response = ApiResponse();
    try {
      SignUpDto signUpDto = SignUpDto.fromJson(json);

      UserModel? user = _userRepository.findByEmail(signUpDto.email);

      if (user == null) {
        response.message = "Bu email bilan oldin ro'yxatdan o'tilmagan";
        response.data = user;
        return Response.unauthorized(
          jsonEncode(response),
          headers: Constants.header,
        );
      }

      if (signUpDto.password == user.password) {
        response.message = "Tizimga kirildi: ${user.email}";
        return Response.ok(jsonEncode(user), headers: Constants.header);
      } else {
        response.message = "Email yoki parol noto‘g‘ri";
        response.data = user;
        return Response.unauthorized(
          jsonEncode(response),
          headers: Constants.header,
        );
      }
    } on Object catch (e, s) {
      print(s);
      return Response.badRequest(
        body: "Xatolik yuz berdi: $e",
        headers: Constants.header,
      );
    }
  }

  Response signUp(Map<String, Object?> json) {
    ApiResponse<UserModel> apiResponse = ApiResponse();
    try {
      SignUpDto signUpDto = SignUpDto.fromJson(json);

      UserModel? user = _userRepository.findByEmail(signUpDto.email);

      if (user != null) {
        apiResponse.message =
            "Bu email bilan foydalanuvchi allaqachon ro'yxatdan o'tgan";
        apiResponse.data = user;
        return Response.badRequest(
          body: jsonEncode(apiResponse),
          headers: Constants.header,
        );
      }

      UserModel newUser = UserModel.fromJson(json);

      _userRepository.save(newUser);

      apiResponse.message = "Muvaffaqiyatli ro'yxatdan o'tildi.";
      apiResponse.data = newUser;

      return Response.ok(
        jsonEncode(apiResponse),
        headers: Constants.header,
      );
    } on Object catch (e, s) {
      print(s);
      return Response.badRequest(
        body: "Xatolik yuz berdi: $e",
        headers: Constants.header,
      );
    }
  }
}

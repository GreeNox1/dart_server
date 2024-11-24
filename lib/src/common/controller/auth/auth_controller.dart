import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../service/user_service.dart';
import '../../constants/constants.dart';

part 'auth_controller.g.dart';

class AuthController {
  const AuthController({
    required final UserService userService,
  }) : _userService = userService;

  final UserService _userService;

  @Route.get('/login')
  Future<Response> _login(Request request) async {
    try {
      return _userService.login(
        jsonDecode(await request.readAsString()),
      );
    } on Object catch (e) {
      return Response.badRequest(
        body: "Xatolik yuz berdi: $e",
        headers: Constants.header,
      );
    }
  }

  @Route.get('/signUp')
  Future<Response> _signUp(Request request) async {
    try {
      return _userService.signUp(
        jsonDecode(await request.readAsString()),
      );
    } on Object catch (e) {
      return Response.badRequest(
        body: "Xatolik yuz berdi: $e",
        headers: Constants.header,
      );
    }
  }

  @Route.all('/<ignored|.*>')
  Response _notFound(Request request) =>
      Response.notFound('Auth Controller not found');

  Router get authRouter => _$AuthController(this);
}

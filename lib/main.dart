import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';

import 'src/common/service/user_service.dart';
import 'src/common/constants/constants.dart';
import 'src/common/models/user_model.dart';
import 'src/common/repository/user_repository.dart';
import 'src/common/router/router.dart';
import 'src/common/utils/enum/role.dart';

class Main {

  final UserService _userService = UserService(
    userRepository: UserRepositoryImpl(),
  );

  final _email = "admin@gmail.com";

  void build() {
    _start();
  }

  void _start() async {
    AppRouter appRouter = AppRouter(
      userService: _userService,
    );

    final handler = Pipeline()
        .addMiddleware(logRequests())
        .addHandler(appRouter.appRouter.call);

    final server = await serve(
      handler,
      InternetAddress.anyIPv4, // Constants.host,
      int.parse(Platform.environment['PORT'] ?? Constants.port),
    );

    print('Server ishga tushirildi: http://${Constants.host}:${server.port}');

    _securityUser();
  }

  void _securityUser() {
    if (!_userService.userRepository.existsByEmail(_email)) {
      UserModel userModel = UserModel(
        username: "GreeNox",
        email: _email,
        password: "1234567890\$",
        role: Role.root,
      );
      _userService.userRepository.save(userModel);
    }
  }
}

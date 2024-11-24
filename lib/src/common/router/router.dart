import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../controller/auth/auth_controller.dart';
import '../service/user_service.dart';

part 'router.g.dart';

class AppRouter {
  AppRouter({
    required final UserService userService,
  }) : _userService = userService;

  final UserService _userService;

  @Route.mount('/api/auth')
  Router get _authController =>
      AuthController(userService: _userService).authRouter;

  @Route.all('/<ignored|.*>')
  Response _notFound(Request request) => Response.notFound(
        'App Router not found',
        headers: {'Content-Type': 'application/json'},
      );

  Router get appRouter => _$AppRouter(this);
}

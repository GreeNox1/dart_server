part of 'auth_controller.dart';

Router _$AuthController(AuthController controller) {
  final router = Router();
  router.add(
    'GET',
    r'/login',
    controller._login,
  );
  router.add(
    'GET',
    r'/signUp',
    controller._signUp,
  );
  router.all(
    r'/<ignored|.*>',
    controller._notFound,
  );
  return router;
}

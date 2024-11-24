part of 'router.dart';

Router _$AppRouter(AppRouter appRouter) {
  final router = Router();

  router.mount(
    r'/api/auth',
    appRouter._authController.call,
  );
  router.all(
    r'/<ignored|.*>',
    appRouter._notFound,
  );

  return router;
}

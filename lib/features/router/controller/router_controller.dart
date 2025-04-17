import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:start_pro/features/router/repository/router_repository.dart';

final routerControllerProvider = Provider<RouterController>((ref) {
  return RouterController(repository: ref.watch(routerRepositoryProvider));
});

final routerControllerFutureProvider = FutureProvider<User?>((ref) async {
  final controller = ref.watch(routerControllerProvider);
  return await controller.checkUser();
});

abstract class IRouterController {
  Future<User?> checkUser();
}

class RouterController extends IRouterController {
  RouterController({required RouterRepository repository})
    : _repository = repository;

  final RouterRepository _repository;

  @override
  Future<User?> checkUser() async {
    final response = await _repository.getUser();

    response.fold(
      (error) {
        return null;
      },
      (success) {
        return success;
      },
    );
    return null;
  }
}

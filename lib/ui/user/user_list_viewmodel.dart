import 'dart:async';

import '../../data/model/user.dart';
import '../../data/repository/repository.dart';

class UserListViewModel {
  final UserRepository _repository;
  final StreamController<List<User>> _userController = StreamController.broadcast();

  Stream<List<User>> get usersStream => _userController.stream;

  UserListViewModel({UserRepository? repository}) : _repository = repository ?? UserRepository();

  void loadUsers() {
    _repository.loadUsers().then((users) => _userController.add(users));
  }

  void dispose() {
    _userController.close();
  }
}


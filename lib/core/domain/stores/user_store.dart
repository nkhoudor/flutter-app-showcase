import 'package:bloc/bloc.dart';
import 'package:flutter_demo/core/domain/model/user.dart';

class UserStore extends Cubit<User> {
  UserStore({User? user}) : super(user ?? const User.empty());

  User get user => state;

  set user(User user) {
    emit(user);
  }
}

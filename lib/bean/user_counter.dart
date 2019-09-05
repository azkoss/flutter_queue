import 'package:flutter/material.dart';
import 'package:flutter_queue/bean/user_entity.dart';


class CounterModel with ChangeNotifier   {
  UserEntity users;

  UserEntity get counter => users;

  void increment(UserEntity user) {
    // First, increment the counter

    this.users = user;
    // Then notify all the listeners.
    notifyListeners();//2
  }
}
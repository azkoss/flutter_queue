import 'package:flutter_queue/bean/cart_model.dart';
import 'package:flutter_queue/bean/user_counter.dart';
import 'package:provider/provider.dart';

class KColorConstant {
  static List<SingleChildCloneableWidget> getProviders() {
    var providersNoti = List<SingleChildCloneableWidget>();
    var changNotifier_Login = ChangeNotifierProvider(builder: (_) => CounterModel());
    var changNotifier_cart = ChangeNotifierProvider(builder: (_) => MyCart());
    //课程管理里面单元部分。
    providersNoti.add(changNotifier_Login);
    providersNoti.add(changNotifier_cart);
    return providersNoti;
  }
}

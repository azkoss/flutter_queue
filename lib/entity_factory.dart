import 'package:flutter_queue/bean/articlebean_entity.dart';
import 'package:flutter_queue/bean/food_entity.dart';
import 'package:flutter_queue/bean/food_type_entity.dart';
import 'package:flutter_queue/bean/merchant_entity.dart';
import 'package:flutter_queue/bean/user_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "ArticlebeanEntity") {
      return ArticlebeanEntity.fromJson(json) as T;
    } else if (T.toString() == "FoodEntity") {
      return FoodEntity.fromJson(json) as T;
    } else if (T.toString() == "FoodTypeEntity") {
      return FoodTypeEntity.fromJson(json) as T;
    } else if (T.toString() == "MerchantEntity") {
      return MerchantEntity.fromJson(json) as T;
    } else if (T.toString() == "UserEntity") {
      return UserEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_queue/bean/cart_model.dart';
import 'package:flutter_queue/bean/food_entity.dart';
import 'package:flutter_queue/bean/food_model.dart';
import 'package:flutter_queue/bean/food_type_entity.dart';
import 'package:flutter_queue/bean/merchant_entity.dart';
import 'package:flutter_queue/bean/user_counter.dart';
import 'package:flutter_queue/utils/MyNetUtils.dart';
import 'package:flutter_queue/utils/values.dart';
import 'package:flutter_queue/view/failure/requestfailed.dart';
import 'package:flutter_queue/view/fragment/home/add_queue.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'foods/cart_bottom_sheet.dart';
import 'foods/food_card.dart';

//应用首页
// ignore: must_be_immutable
class MyHomePage extends StatefulWidget {
  MerchantRow merchantRow;

  MyHomePage(MerchantRow merchantRow) {
    this.merchantRow = merchantRow;
  }

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int value = 1;
  List<FoodTypeRow> foodTypeList = new List();
  List<FoodRow> foodList = new List();

  @override
  void initState() {
    super.initState();
    initData();
  }

  showCart() {
    showModalBottomSheet(
      shape: roundedRectangle40,
      context: context,
      builder: (context) => CartBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(36), vertical: ScreenUtil().setWidth(48)),
        child: Column(
          children: <Widget>[
            buildAppBar(),
            buildFoodFilter(),
            Divider(),
            foodList.length <= 0
                ? Container(
                    child: Text("当前无数据"),
                  ) //请求失败
                : buildFoodList()
          ],
        ),
      ),
    );
  }

  Widget buildAppBar() {
    int items = 0;
    Provider.of<MyCart>(context).cartItems.forEach((cart) {
      items += cart.quantity;
    });
    return SafeArea(
      child: Row(
        children: <Widget>[
          Text('首页', style: headerStyle),
          Spacer(),
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                /*Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new AddQueue(widget.merchantRow)),
                );*/
              }),
          Stack(
            children: <Widget>[
              IconButton(icon: Icon(Icons.shopping_cart), onPressed: showCart),
              Positioned(
                right: 0,
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(4),
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: mainColor),
                  child: Text(
                    '$items',
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildFoodFilter() {
    return Container(
      height: 50,
      //color: Colors.red,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        children: List.generate(foodTypeList.length, (index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ChoiceChip(
              selectedColor: mainColor,
              labelStyle: TextStyle(
                  color: value == index ? Colors.white : Colors.black),
              label: Text(foodTypeList[index].name.split('.').last),
              selected: value == index,
              onSelected: (selected) {
                setState(() {
                  value = selected ? index : null;
                  getFoodList();
                });
              },
            ),
          );
        }),
      ),
    );
  }

  Widget buildFoodList() {
    return Expanded(
      child: GridView.count(
        //itemCount: foods.length,
        childAspectRatio: 0.65,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        crossAxisCount: 2,
        physics: BouncingScrollPhysics(),
        children: foodList.map((food) {
          return FoodCard(food);
        }).toList(),
      ),
    );
  }

  ///加载数据
  void initData() {
    Map<String, dynamic> map = Map();
    Map<String, dynamic> header = Map();
    MyNetUtil.instance.getData("foodTypeClient/getFoodTypeList", (value) async {
      //获取所有菜系
      FoodTypeEntity foodTypeEntity = FoodTypeEntity.fromJson(value);
      if (foodTypeEntity.success) {
        foodTypeList.clear();
        foodTypeList.addAll(foodTypeEntity.rows);
        getFoodList();
        setState(() {});
      }
    }, params: map, headers: header);
  }

  ///获取餐厅食品列表
  void getFoodList() {
    Map<String, dynamic> map = Map();
    Map<String, dynamic> header = Map();
    map["uid"] = widget.merchantRow.id;
    map["xid"] = foodTypeList[value].id;
    MyNetUtil.instance.getData("foodClient/queryAllFood", (value) async {
      //print("早早早菜：${value.toString()}");
      //获取所有菜系
      FoodEntity foodEntity = FoodEntity.fromJson(value);
      foodList.clear();
      if (foodEntity.success) {
        foodList.addAll(foodEntity.rows);
      }
      setState(() {});
    }, params: map, headers: header);
  }
}

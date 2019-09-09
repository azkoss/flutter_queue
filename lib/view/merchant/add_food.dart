import 'package:flutter/material.dart';
import 'package:flutter_queue/bean/food_type_entity.dart';
import 'package:flutter_queue/bean/result_entity.dart';
import 'package:flutter_queue/bean/user_counter.dart';
import 'package:flutter_queue/bean/user_entity.dart';
import 'package:flutter_queue/utils/MyNetUtils.dart';
import 'package:flutter_queue/utils/toast.dart';
import 'package:flutter_queue/utils/values.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

///新增食品
class AddFood extends StatefulWidget {
  @override
  PlaygroundState createState() => new PlaygroundState();
}

class PlaygroundState extends State<AddFood> {
  int value = 0;
  var name = new TextEditingController();
  var price = new TextEditingController();
  var remark = new TextEditingController();
  var img = new TextEditingController();
  List<FoodTypeRow> foodTypeList = new List();

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    CounterModel user = Provider.of<CounterModel>(context);
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("新增菜品"),
        backgroundColor: Colors.orange, //设置appbar背景颜色
        centerTitle: true, //设置标题是否局中
      ),
      body: ListView(
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(1080),
            height: ScreenUtil.screenHeight,
            color: Colors.white,
            padding: EdgeInsets.all(ScreenUtil().setWidth(30)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "菜系",
                  style: TextStyle(fontSize: ScreenUtil().setSp(36)),
                ),
                buildFoodFilter(),
                Container(
                  height: ScreenUtil().setHeight(30),
                ),
                Text(
                  "菜品名称",
                  style: TextStyle(fontSize: ScreenUtil().setSp(36)),
                ),
                TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      icon: Icon(Icons.text_fields),
                      hintText: "请输入菜品名称",
                    ),
                    controller: name),
                Container(
                  height: ScreenUtil().setHeight(30),
                ),
                Text(
                  "菜品价格",
                  style: TextStyle(fontSize: ScreenUtil().setSp(36)),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    icon: Icon(Icons.text_fields),
                    hintText: "请输入菜品价格",
                  ),
                  controller: price,
                ),
                Container(
                  height: ScreenUtil().setHeight(30),
                ),
                Text(
                  "菜品描述",
                  style: TextStyle(fontSize: ScreenUtil().setSp(36)),
                ),
                TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    icon: Icon(Icons.text_fields),
                    hintText: "请输入菜品描述",
                  ),
                  controller: remark,
                ),
                Container(
                  height: ScreenUtil().setHeight(30),
                ),
                Text(
                  "菜品样式",
                  style: TextStyle(fontSize: ScreenUtil().setSp(36)),
                ),
                TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    icon: Icon(Icons.text_fields),
                    hintText: "请输入菜品样式地址",
                  ),
                  controller: img,
                ),
                Container(
                  width: ScreenUtil().setWidth(750),
                  margin: new EdgeInsets.only(
                      left: ScreenUtil().setWidth(130),
                      right: ScreenUtil().setWidth(100),
                      top: ScreenUtil().setHeight(100)),
                  padding: new EdgeInsets.only(
                      left: ScreenUtil().setWidth(30),
                      right: ScreenUtil().setWidth(30)),
                  child: new Card(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(22.0))),
                    color: Colors.blue,
                    elevation: 6.0,
                    child: new FlatButton(
                        onPressed: () {
                          saveUpdate(user.counter.rows.id);
                        },
                        child: new Padding(
                          padding: new EdgeInsets.all(10.0),
                          child: new Text(
                            '新增',
                            style: new TextStyle(
                                color: Colors.white, fontSize: 16.0),
                          ),
                        )),
                  ),
                )
              ],
            ),
          )
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
                });
              },
            ),
          );
        }),
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
        setState(() {});
      }
    }, params: map, headers: header);
  }

  void saveUpdate(String id) {
    if (name.text != null &&
        price.text != null &&
        remark.text != null &&
        img.text != null &&
        name.text != "" &&
        remark.text != "" &&
        img.text != "" &&
        price.text != "") {
      Map<String, String> map = Map();
      map["uid"] = id;
      map["xid"] = foodTypeList[value].id;
      map["name"] = name.text;
      map["price"] = price.text;
      map["remark"] = remark.text;
      map["img"] = Uri.encodeComponent(img.text);

      MyNetUtil.instance.getData("foodClient/addFood", (value) async {
        ResultEntity resultEntity = ResultEntity.fromJson(value);
        if (resultEntity.success) {
          ToastUtils.showToast("新增成功");
          Navigator.pop(context);
        } else {
          ToastUtils.showToast("新增失败，请检查网络");
        }
      }, params: map);
    } else {
      print("请填写完整信息");
      ToastUtils.showToast("请填写完整信息");
    }
  }
}

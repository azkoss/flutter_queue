import 'package:flutter/material.dart';
import 'package:flutter_queue/bean/food_entity.dart';
import 'package:flutter_queue/bean/result_entity.dart';
import 'package:flutter_queue/bean/user_counter.dart';
import 'package:flutter_queue/utils/MyNetUtils.dart';
import 'package:flutter_queue/utils/toast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

///修改食品
class UpdateFood extends StatefulWidget {
  FoodRow food;

  UpdateFood(FoodRow food) {
    this.food = food;
  }

  @override
  PlaygroundState createState() => new PlaygroundState();
}

class PlaygroundState extends State<UpdateFood> {
  var name;
  var price;
  var remark;
  var img;

  String names = "";
  String prices = "";
  String remarks = "";
  String imgs = "";

  @override
  void initState() {
    super.initState();
    initData();
  }

  ///加载数据
  void initData() {
    names = widget.food.name;
    prices = "${widget.food.price}";
    remarks = widget.food.remark;
    imgs = widget.food.img;
  }

  @override
  Widget build(BuildContext context) {
    CounterModel user = Provider.of<CounterModel>(context);
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("修改菜品"),
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
                  controller: name = new TextEditingController.fromValue(TextEditingValue(
                    // 设置内容
                      text: names,
                      // 保持光标在最后
                      selection: TextSelection.fromPosition(TextPosition(
                          affinity: TextAffinity.downstream,
                          offset: names.length)))),
                  onChanged: (value) {
                    names = value;
                  },
                ),
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
                  controller: price = new TextEditingController.fromValue(TextEditingValue(
                    // 设置内容
                      text: prices,
                      // 保持光标在最后
                      selection: TextSelection.fromPosition(TextPosition(
                          affinity: TextAffinity.downstream,
                          offset: prices.length)))),
                  onChanged: (value) {
                    prices = value;
                  },
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
                  controller: remark = new TextEditingController.fromValue(TextEditingValue(
                    // 设置内容
                      text: remarks,
                      // 保持光标在最后
                      selection: TextSelection.fromPosition(TextPosition(
                          affinity: TextAffinity.downstream,
                          offset: remarks.length)))),
                  onChanged: (value) {
                    remarks = value;
                  },
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
                  controller: img = new TextEditingController.fromValue(TextEditingValue(
                    // 设置内容
                      text: imgs,
                      // 保持光标在最后
                      selection: TextSelection.fromPosition(TextPosition(
                          affinity: TextAffinity.downstream,
                          offset: imgs.length)))),
                  onChanged: (value) {
                    imgs = value;
                  },
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
                            '修改',
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

  ///修改菜品
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
      map["id"] = widget.food.id;
      map["uid"] = id;
      map["xid"] = widget.food.xid;
      map["name"] = name.text;
      map["price"] = price.text;
      map["remark"] = remark.text;
      map["img"] = Uri.encodeComponent(img.text);
      MyNetUtil.instance.getData("foodClient/updateFood", (value) async {
        ResultEntity resultEntity = ResultEntity.fromJson(value);
        if (resultEntity.success) {
          ToastUtils.showToast("修改成功");
          Navigator.pop(context);
        } else {
          ToastUtils.showToast("修改失败，请检查网络");
        }
      }, params: map);
    } else {
      print("请填写完整信息");
      ToastUtils.showToast("请填写完整信息");
    }
  }
}

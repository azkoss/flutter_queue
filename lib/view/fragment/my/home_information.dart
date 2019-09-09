import 'package:flutter/material.dart';
import 'package:flutter_queue/bean/user_counter.dart';
import 'package:flutter_queue/bean/user_entity.dart';
import 'package:flutter_queue/utils/MyNetUtils.dart';
import 'package:flutter_queue/utils/toast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

///个人信息页面
class HomeInformation extends StatefulWidget {
  @override
  PlaygroundState createState() => new PlaygroundState();
}

class PlaygroundState extends State<HomeInformation> {

  TextEditingController name;
  TextEditingController gender;
  TextEditingController heads;
  TextEditingController phone;

  String names;
  String genders;
  String head;
  String phones;



  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    initData();
  }

  ///加载数据
  void initData() {
    CounterModel user = Provider.of<CounterModel>(context);
    names = user.counter.rows.name;
    genders = user.counter.rows.gender;
    head = user.counter.rows.heads;
    phones = user.counter.rows.phone;
  }

  @override
  Widget build(BuildContext context) {
    CounterModel user = Provider.of<CounterModel>(context);
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(user.counter.rows.merchant==0?"个人信息":"餐厅信息"),
        backgroundColor: Colors.orange, //设置appbar背景颜色
        centerTitle: true, //设置标题是否局中
      ),
      body: ListView(
        children: <Widget>[Container(
          width: ScreenUtil().setWidth(1080),
          height: ScreenUtil.screenHeight,
          color: Colors.white,
          padding: EdgeInsets.all(ScreenUtil().setWidth(30)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("昵称",style: TextStyle(fontSize: ScreenUtil().setSp(36)),),
              TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    icon: Icon(Icons.text_fields),
                    hintText: "请输入昵称",
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
              Text(user.counter.rows.merchant==0?"性别":"简介",style: TextStyle(fontSize: ScreenUtil().setSp(36)),),
              TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  icon: Icon(Icons.text_fields),
                  hintText: user.counter.rows.merchant==0?"请输入性别":"请输入简介",
                ),
                controller: gender = new TextEditingController.fromValue(TextEditingValue(
                  // 设置内容
                    text: genders,
                    // 保持光标在最后
                    selection: TextSelection.fromPosition(TextPosition(
                        affinity: TextAffinity.downstream,
                        offset: genders.length)))),
                onChanged: (value) {
                  genders = value;
                },
              ),
              Container(
                height: ScreenUtil().setHeight(30),
              ),
              Text(user.counter.rows.merchant==0?"头像地址":"Logo地址",style: TextStyle(fontSize: ScreenUtil().setSp(36)),),
              TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  icon: Icon(Icons.text_fields),
                  hintText: user.counter.rows.merchant==0?"请输入头像地址":"请输入Logo地址",
                ),
                controller: heads = new TextEditingController.fromValue(TextEditingValue(
                  // 设置内容
                    text: head,
                    // 保持光标在最后
                    selection: TextSelection.fromPosition(TextPosition(
                        affinity: TextAffinity.downstream,
                        offset: head.length)))),
                onChanged: (value) {
                  head = value;
                },
              ),
              Container(
                height: ScreenUtil().setHeight(30),
              ),
              Text("联系方式",style: TextStyle(fontSize: ScreenUtil().setSp(36)),),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  icon: Icon(Icons.text_fields),
                  hintText: "请输入联系方式",
                ),
                controller: phone = new TextEditingController.fromValue(TextEditingValue(
                  // 设置内容
                    text: phones,
                    // 保持光标在最后
                    selection: TextSelection.fromPosition(TextPosition(
                        affinity: TextAffinity.downstream,
                        offset: phones.length)))),
                onChanged: (value) {
                  phones = value;
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
                        saveUpdate(user.counter);
                      },
                      child: new Padding(
                        padding: new EdgeInsets.all(10.0),
                        child: new Text(
                          '保存修改',
                          style: new TextStyle(
                              color: Colors.white, fontSize: 16.0),
                        ),
                      )),
                ),
              )
            ],
          ),
        )],
      ),
    );
  }

  void saveUpdate(UserEntity user) {
    if (name.text != null &&
        gender.text != null &&
        heads.text != null &&
        phone.text != null &&
        name.text != "" &&
        heads.text != "" &&
        phone.text != "" &&
        gender.text != "") {


      Map<String, String> map = Map();
      map["id"] = user.rows.id;
      map["gender"] = gender.text;
      map["name"] = name.text;
      map["heads"] = Uri.encodeComponent(user.rows.heads);
      map["phone"] = phone.text;
      print("哈哈哈"+map.toString());
      MyNetUtil.instance.getData("userClient/modifyInformation", (value) async {
        UserEntity userEntity =UserEntity.fromJson(value);

        if(userEntity.success){
          Provider.of<CounterModel>(context).increment(userEntity);
          ToastUtils.showToast("修改成功");
        }else{
          ToastUtils.showToast("修改失败");
        }


      }, params: map);
    } else {
      print("请填写完整信息");
      ToastUtils.showToast("请填写完整信息");
    }
  }


}

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

  var name = new TextEditingController();
  var gender = new TextEditingController();
  var heads = new TextEditingController();
  var phone = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    CounterModel user = Provider.of<CounterModel>(context);
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("个人信息"),
        backgroundColor: Color(0xFF1E88E5), //设置appbar背景颜色
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
                  controller: name
              ),
              Container(
                height: ScreenUtil().setHeight(30),
              ),
              Text("性别",style: TextStyle(fontSize: ScreenUtil().setSp(36)),),
              TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  icon: Icon(Icons.text_fields),
                  hintText: "请输入性别",
                ),
                controller: gender,
              ),
              Container(
                height: ScreenUtil().setHeight(30),
              ),
              Text("头像地址",style: TextStyle(fontSize: ScreenUtil().setSp(36)),),
              TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  icon: Icon(Icons.text_fields),
                  hintText: "请输入头像地址",
                ),
                controller: heads,
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
                controller: phone,
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

  void saveUpdate(String id) {
    if (name.text != null &&
        gender.text != null &&
        heads.text != null &&
        phone.text != null &&
        name.text != "" &&
        heads.text != "" &&
        phone.text != "" &&
        gender.text != "") {
      Map<String, String> map = Map();
      /*map["id"] = id;
      map["gender"] = gender;
      map["name"] = name;
      map["heads"] = heads;
      map["phone"] = phone;*/
      MyNetUtil.instance.postData("userClient/modifyInformation?id=$id&gender=${gender.text}&name=${name.text}&heads=${heads.text}&phone=${phone.text}", (value) async {
        UserEntity userEntity =UserEntity.fromJson(value);
        print("userEntity$value");
        if(userEntity.success){
          Provider.of<CounterModel>(context).increment(userEntity);
          ToastUtils.showToast("修改成功");
        }else{
          ToastUtils.showToast("账号或用户名不匹配");
        }


      }, params: map);
    } else {
      print("请填写完整信息");
    }
  }


}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_queue/utils/MyNetUtils.dart';
import 'package:flutter_queue/utils/toast.dart';
import 'package:flutter_queue/view/homepage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 1080, height: 1920)..init(context);
    //Scaffold是Material中主要的布局组件.
    return new Scaffold(
      backgroundColor: Colors.white,
      //body占屏幕的大部分
      body: new Center(
        child: LoginPage(),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  // ignore: strong_mode_top_level_instance_method
  var leftRightPadding = ScreenUtil().setWidth(60);

  // ignore: strong_mode_top_level_instance_method
  var topBottomPadding = ScreenUtil().setWidth(10);

  // ignore: strong_mode_top_level_instance_method
  var paddingfif = ScreenUtil().setWidth(45);

  // ignore: strong_mode_top_level_instance_method
  var paddingten = ScreenUtil().setWidth(30);
  var textTips = new TextStyle(fontSize: 16.0, color: Colors.black);
  var hintTips = new TextStyle(fontSize: 15.0, color: Colors.black26);

  var _userPassController = new TextEditingController();
  var _userNameController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.white,
        /*appBar: new AppBar(
          centerTitle: true, //设置标题是否局中
          title: new Text("登录", style: new TextStyle(color: Colors.white)),
          iconTheme: new IconThemeData(color: Colors.blue),
        ),*/
        body: new ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  height: ScreenUtil().setHeight(1632), //1920-60-288
                  width: ScreenUtil().setWidth(ScreenUtil.screenWidth),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Container(
                          margin:
                              EdgeInsets.only(top: ScreenUtil().setHeight(231)),
                          child: new Image.asset(
                            "images/img_login_logo.png",
                            width: ScreenUtil().setWidth(216),
                            height: ScreenUtil().setHeight(429),
                          )),
                      Column(
                        children: <Widget>[
                          new Padding(
                              padding: new EdgeInsets.fromLTRB(
                                  leftRightPadding,
                                  ScreenUtil().setHeight(10),
                                  leftRightPadding,
                                  topBottomPadding),
                              child: Container(
                                color: Colors.white,
                                padding: EdgeInsets.only(
                                    left: ScreenUtil().setWidth(90),
                                    right: ScreenUtil().setWidth(90)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
//                  crossAxisAlignment: CrossAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  textBaseline: TextBaseline.ideographic,
                                  children: <Widget>[
                                    Image.asset(
                                      "images/img_login_studentid.png",
                                      width: 20,
                                      height: 20,
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: paddingfif,
                                            right: paddingfif,
                                            top: paddingfif,
                                            bottom: paddingfif),
                                        child: TextFormField(
                                          maxLines: 1,
                                          onSaved: (value) {},
                                          controller: _userNameController,
                                          textAlign: TextAlign.left,
                                          //inputFormatters: [WhitelistingTextInputFormatter.digitsOnly,LengthLimitingTextInputFormatter(6)],
                                          decoration: InputDecoration(
                                            hintText: ('请输入学号'),
                                            contentPadding: EdgeInsets.only(
                                                top: -5, bottom: 0),
                                            hintStyle: TextStyle(
                                              color: Color(0xff999999),
                                              fontSize: 16,
                                            ),
                                            alignLabelWithHint: true,
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide.none),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                          Container(
                            width: ScreenUtil().setWidth(780),
                            height: ScreenUtil().setWidth(1),
                            color: Colors.black45,
                          )
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          new Padding(
                              padding: new EdgeInsets.fromLTRB(
                                  leftRightPadding,
                                  ScreenUtil().setHeight(60),
                                  leftRightPadding,
                                  topBottomPadding),
                              child: Container(
                                color: Colors.white,
                                padding: EdgeInsets.only(
                                    left: ScreenUtil().setWidth(90),
                                    right: ScreenUtil().setWidth(90)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
//                  crossAxisAlignment: CrossAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  textBaseline: TextBaseline.ideographic,
                                  children: <Widget>[
                                    Image.asset(
                                      "images/img_login_name.png",
                                      width: ScreenUtil().setWidth(60),
                                      height: ScreenUtil().setHeight(60),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: paddingfif,
                                            right: paddingfif,
                                            top: paddingfif,
                                            bottom: paddingfif),
                                        child: TextFormField(
                                          maxLines: 1,
                                          onSaved: (value) {},
                                          controller: _userPassController,
                                          textAlign: TextAlign.left,
                                          //inputFormatters: [WhitelistingTextInputFormatter.digitsOnly,LengthLimitingTextInputFormatter(6)],
                                          decoration: InputDecoration(
                                            hintText: ('请输入姓名'),
                                            contentPadding: EdgeInsets.only(
                                                top: -5, bottom: 0),
                                            hintStyle: TextStyle(
                                              color: Color(0xff999999),
                                              fontSize: 16,
                                            ),
                                            alignLabelWithHint: true,
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide.none),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                          Container(
                            width: ScreenUtil().setWidth(780),
                            height: ScreenUtil().setWidth(1),
                            color: Colors.black45,
                          )
                        ],
                      ),
                      new Container(
                        width: ScreenUtil().setWidth(900),
                        margin: new EdgeInsets.fromLTRB(
                            0, ScreenUtil().setHeight(168), 0, 0.0),
                        padding: new EdgeInsets.fromLTRB(
                            leftRightPadding,
                            topBottomPadding,
                            leftRightPadding,
                            topBottomPadding),
                        child: new Card(
                          color: Colors.blue,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(22.0))),
                          //设置圆角
                          elevation: 6.0,
                          child: new FlatButton(
                              onPressed: () {
                                sendServer();
                              },
                              child: new Padding(
                                padding: new EdgeInsets.all(10.0),
                                child: new Text(
                                  '登录',
                                  style: new TextStyle(
                                      color: Colors.white, fontSize: 16.0),
                                ),
                              )),
                        ),
                      )
                    ],
                  ),
                ),
                Image.asset(
                  "images/img_waves.gif",
                  height: ScreenUtil().setHeight(288),
                  width: ScreenUtil.screenWidth,
                  fit: BoxFit.fitWidth,
                ),
              ],
            )
          ],
        ));
  }

  //注册
  void sendServer() async {
    if (_userNameController.text != null &&
        _userPassController.text != null &&
        _userNameController.text != "" &&
        _userPassController.text != "") {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Map<String, String> map = Map();
      map["mobile"] = prefs.getString("mobile");
      map["code"] = _userNameController.text;
      map["name"] = _userPassController.text;
      map["validatecode"] = prefs.getString("validatecode");
      MyNetUtil.instance.postData("user/register", (value) {
        //print("zzzzzzzzzssss   "+value.toString());
        Navigator.pushAndRemoveUntil(
          context,
          new MaterialPageRoute(builder: (context) => new Home(null)),
              (route) => route == null,
        );
        dispose(); //关闭刷新
      }, params: map);
    } else {
      print("账号或密码为空");
    }
  }
}

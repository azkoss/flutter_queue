import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_queue/bean/user_counter.dart';
import 'package:flutter_queue/bean/user_entity.dart';
import 'package:flutter_queue/utils/MyNetUtils.dart';
import 'package:flutter_queue/utils/toast.dart';
import 'package:flutter_queue/view/login/login.dart';
import 'package:flutter_queue/view/merchant/merchant_home_page.dart';
import 'package:flutter_queue/view/select_merchant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashPageState();
  }
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 1080, height: 1920)..init(context);
    return  Container(
        width: ScreenUtil.screenWidth,
        height: ScreenUtil().setHeight(320),
    decoration: BoxDecoration(
    //设置背景图片
    image: DecorationImage(
    image: AssetImage("images/img_bg.jpg"),
    fit: BoxFit.cover,
    ),
    ),);
  }

  @override
  void initState() {
    super.initState();
    countDown();
  }

// 倒计时
  void countDown() {
    var _duration = new Duration(seconds: 1);
    new Future.delayed(_duration, go2HomePage);
  }

  Future go2HomePage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString("username");
    String password = prefs.getString("password");
    print("username=$username password=$password");
    if (username != null &&
        username != "" &&
        password != null &&
        password != "") {
      login(username, password);
    } else {
      toLogin();
    }
  }

  ProgressDialog pr;

  void login(String username, String password) {
    pr = new ProgressDialog(context, ProgressDialogType.Normal);
    pr.setMessage('正在登录...');
    pr.show();
    Map<String, String> map = Map();
    /*map["username"] = _userNameController.text;
      map["password"] = _userPassController.text;*/
    MyNetUtil.instance
        .postData("userClient/login?username=$username&password=$password",
            (value) async {
      UserEntity userEntity = UserEntity.fromJson(value);
      print("userEntity$value");
      if (userEntity.success) {
        Provider.of<CounterModel>(context).increment(userEntity);
        if (userEntity.rows.merchant == 0) {
          //先进行餐厅选择
          Navigator.pushAndRemoveUntil(
            context,
            new MaterialPageRoute(builder: (context) => new SelectMerchant()),
            (route) => route == null,
          );
          ToastUtils.showToast("登录成功");
        } else if (userEntity.rows.merchant == 2) {
          Navigator.pushAndRemoveUntil(
            context,
            new MaterialPageRoute(
                builder: (context) => new MerChantHome(userEntity.rows)),
            (route) => route == null,
          );
          ToastUtils.showToast("登录成功");
        } else {
          toLogin();
          ToastUtils.showToast("账号被冻结或权限不够");
        }
      } else {
        toLogin();
        ToastUtils.showToast("账号或用户名不匹配");
      }
      pr.hide();
    }, params: map);
    pr.hide();
  }

  ///去登录页面
  void toLogin() {
    Navigator.pushAndRemoveUntil(
      context,
      new MaterialPageRoute(builder: (context) => new Login()),
      (route) => route == null,
    );
  }
}

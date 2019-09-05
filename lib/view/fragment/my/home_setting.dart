import 'package:flutter/material.dart';
import 'package:flutter_queue/utils/view/customdialog.dart';
import 'package:flutter_queue/view/login/login.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class HomeSetting extends StatefulWidget {
  @override
  HomeSettingState createState() => new HomeSettingState();
}

class HomeSettingState extends State<HomeSetting> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        titleSpacing: 1,
        //标题两边的空白区域,
        centerTitle: true,
        title: new Text(
          "Setting",
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: <Widget>[
          Container(//头像
            color: Colors.white,
            padding: EdgeInsets.all(ScreenUtil().setWidth(30)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Head portrait",style: TextStyle(fontSize: 16),),
                CircleAvatar(
                  //圆形头像
                  backgroundImage: AssetImage("img/login_lwf.png",),
                  radius: 35.0,
                ),
              ],
            ),
          ),
          SizedBox(height: 1.0, child: Container(color: Color(0xDBDBDBDB))),
          Container(//网名
            color: Colors.white,
            padding: EdgeInsets.only(left: ScreenUtil().setWidth(30),right: ScreenUtil().setWidth(30),top: ScreenUtil().setWidth(50),bottom: ScreenUtil().setWidth(50)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Name",style: TextStyle(fontSize: 16),),
                Row(
                  children: <Widget>[
                    Text("Jessy Ma",style: TextStyle(fontSize: 16,color: Colors.black54),),
                    Icon(
                      Icons.chevron_right,
                      size: ScreenUtil().setHeight(80),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 1.0, child: Container(color: Color(0xDBDBDBDB))),
          InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) {
                    return CustomDialog(
                      confirmCallback: () {//跳转到登陆页面
                        Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
                          return Login();
                        }));
                      },
                      confirmContent: "Log out",
                      content: 'Are you sure to log out?',
                      confirmColor: Colors.blue,
                    );
                  });
            },
            child: Container(
              width: ScreenUtil.screenWidth,
              color: Colors.white,
              padding: EdgeInsets.all(ScreenUtil().setWidth(60)),
              child: Center(
                child: Text(
                  "Log out",
                  style: TextStyle(color: Colors.red, fontSize: 17),
                ),
              ),
            ),
          )//注销当前账号  log out
        ],
      ),
    );
  }
}

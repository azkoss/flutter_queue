import 'package:flutter/material.dart';
import 'package:flutter_queue/bean/user_counter.dart';
import 'package:flutter_queue/utils/toast.dart';
import 'package:flutter_queue/utils/view/customdialog.dart';
import 'package:flutter_queue/view/fragment/my/home_information.dart';
import 'package:flutter_queue/view/fragment/my/home_order.dart';
import 'package:flutter_queue/view/login/login.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeMyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeMyPageState();
  }
}

class _HomeMyPageState extends State<HomeMyPage> {
  @override
  Widget build(BuildContext context) {
    CounterModel user = Provider.of<CounterModel>(context);
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              color: Colors.orange,
              width: ScreenUtil.screenWidth,
              height: ScreenUtil().setHeight(600),
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                        left: ScreenUtil().setWidth(60),
                        top: ScreenUtil().setWidth(50)),
                    child: CircleAvatar(
                      radius: 36.0,
                      backgroundImage: NetworkImage(
                          user.counter.rows.heads != null
                              ? user.counter.rows.heads
                              : ""),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: ScreenUtil().setWidth(50),
                        top: ScreenUtil().setWidth(250)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          user.counter.rows.name != null
                              ? user.counter.rows.name
                              : "",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: ScreenUtil().setSp(40)),
                        ),
                        Text(
                          user.counter.rows.phone != null
                              ? user.counter.rows.phone
                              : "",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: ScreenUtil().setSp(32)),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: ScreenUtil().setHeight(130)),
              child: Card(
                //设置圆角
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                color: Colors.white,
                //设置阴影
                elevation: 4.0,
                child: Container(
                  height: ScreenUtil().setHeight(720),
                  width: ScreenUtil().setWidth(980),
                  child: Column(
                    children: <Widget>[
                      InkWell(
                        onTap: (){
                          ToastUtils.showToast("个人信息");
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) =>
                                new HomeInformation()),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: ScreenUtil().setWidth(40),
                                      left: ScreenUtil().setWidth(40),
                                      top: ScreenUtil().setHeight(30),
                                      bottom: ScreenUtil().setHeight(30)
                                  ),
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.cyan,
                                    size: ScreenUtil().setHeight(65),
                                  ),
                                ),
                                Text(
                                  "个人信息",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: ScreenUtil().setSp(36),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(right: ScreenUtil().setWidth(40)),
                              child: Image.asset("images/index/img_index_enter.png",width: ScreenUtil().setWidth(40),height: ScreenUtil().setWidth(40),),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        color: Colors.black26,
                        width: ScreenUtil().setWidth(980),
                        height: ScreenUtil().setHeight(1),
                      ),
                      InkWell(
                        onTap: (){
                          ToastUtils.showToast("相册");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: ScreenUtil().setWidth(40),
                                      left: ScreenUtil().setWidth(40),
                                      top: ScreenUtil().setHeight(25),
                                      bottom: ScreenUtil().setHeight(25)
                                  ),
                                  child: Icon(
                                    Icons.camera,
                                    color: Colors.orange,
                                    size: ScreenUtil().setHeight(65),
                                  ),
                                ),
                                Text(
                                  "相册",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: ScreenUtil().setSp(36),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(right: ScreenUtil().setWidth(40)),
                              child: Image.asset("images/index/img_index_enter.png",width: ScreenUtil().setWidth(40),height: ScreenUtil().setWidth(40),),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.black26,
                        width: ScreenUtil().setWidth(980),
                        height: ScreenUtil().setHeight(1),
                      ),
                      InkWell(
                        onTap: (){
                          ToastUtils.showToast("表情");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: ScreenUtil().setWidth(40),
                                      left: ScreenUtil().setWidth(40),
                                      top: ScreenUtil().setHeight(25),
                                      bottom: ScreenUtil().setHeight(25)
                                  ),
                                  child: Icon(
                                    Icons.face,
                                    color: Colors.orange,
                                    size: ScreenUtil().setHeight(65),
                                  ),
                                ),
                                Text(
                                  "表情",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: ScreenUtil().setSp(36),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(right: ScreenUtil().setWidth(40)),
                              child: Image.asset("images/index/img_index_enter.png",width: ScreenUtil().setWidth(40),height: ScreenUtil().setWidth(40),),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.black26,
                        width: ScreenUtil().setWidth(980),
                        height: ScreenUtil().setHeight(1),
                      ),
                      InkWell(
                        onTap: (){
                          ToastUtils.showToast("收藏");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: ScreenUtil().setWidth(40),
                                      left: ScreenUtil().setWidth(40),
                                      top: ScreenUtil().setHeight(25),
                                      bottom: ScreenUtil().setHeight(25)
                                  ),
                                  child: Icon(
                                    Icons.dashboard,
                                    color: Colors.grey,
                                    size: ScreenUtil().setHeight(65),
                                  ),
                                ),
                                Text(
                                  "收藏",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: ScreenUtil().setSp(36),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(right: ScreenUtil().setWidth(40)),
                              child: Image.asset("images/index/img_index_enter.png",width: ScreenUtil().setWidth(40),height: ScreenUtil().setWidth(40),),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.black26,
                        width: ScreenUtil().setWidth(980),
                        height: ScreenUtil().setHeight(1),
                      ),
                      InkWell(
                        onTap: (){
                          ToastUtils.showToast("卡包");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: ScreenUtil().setWidth(40),
                                      left: ScreenUtil().setWidth(40),
                                      top: ScreenUtil().setHeight(25),
                                      bottom: ScreenUtil().setHeight(25)
                                  ),
                                  child: Icon(
                                    Icons.card_membership,
                                    color: Colors.green,
                                    size: ScreenUtil().setHeight(65),
                                  ),
                                ),
                                Text(
                                  "卡包",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: ScreenUtil().setSp(36),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(right: ScreenUtil().setWidth(40)),
                              child: Image.asset("images/index/img_index_enter.png",width: ScreenUtil().setWidth(40),height: ScreenUtil().setWidth(40),),
                            ),

                          ],
                        ),
                      ),
                      Container(
                        color: Colors.black26,
                        width: ScreenUtil().setWidth(980),
                        height: ScreenUtil().setHeight(1),
                      ),
                      InkWell(
                        onTap: (){
                          showBootom(3);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: ScreenUtil().setWidth(40),
                                      left: ScreenUtil().setWidth(40),
                                      top: ScreenUtil().setHeight(25),
                                      bottom: ScreenUtil().setHeight(25)
                                  ),
                                  child: Icon(
                                    Icons.share,
                                    color: Colors.lightBlue,
                                    size: ScreenUtil().setHeight(65),
                                  ),
                                ),
                                Text(
                                  "分享",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: ScreenUtil().setSp(36),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(right: ScreenUtil().setWidth(40)),
                              child: Image.asset("images/index/img_index_enter.png",width: ScreenUtil().setWidth(40),height: ScreenUtil().setWidth(40),),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: ScreenUtil().setWidth(750),
              height: ScreenUtil().setHeight(135),
              margin: new EdgeInsets.only(
                  left: ScreenUtil().setWidth(100),
                  right: ScreenUtil().setWidth(100),
                  top: ScreenUtil().setHeight(45)),
              padding: new EdgeInsets.only(
                  left: ScreenUtil().setWidth(30),
                  right: ScreenUtil().setWidth(30)),
              child: new Card(
                color: Colors.red,
                elevation: 6.0,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(22.0))),
                child: new FlatButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) {
                            return CustomDialog(
                              confirmCallback: () async {//跳转到登陆页面
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                prefs.setString("username", null);
                                prefs.setString("password", null);
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  new MaterialPageRoute(builder: (context) => new Login()),
                                      (route) => route == null,
                                );
                              },
                              confirmContent: "退出",
                              content: '你确定要退出登录吗?',
                              confirmColor: Colors.blue,
                            );
                          });
                    },
                    child: new Padding(
                      padding: new EdgeInsets.all(ScreenUtil().setWidth(20)),
                      child: new Text(
                        '退出登录',
                        style:
                            new TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                    )),
              ),
            )
          ],
        ),
        Positioned(
            left: ScreenUtil().setHeight(50),
            top: ScreenUtil().setHeight(500),
            child: Card(
              //设置圆角
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0))),
              color: Colors.white,
              //设置阴影
              elevation: 4.0,
              child: Container(
                padding: EdgeInsets.all(ScreenUtil().setHeight(15)),
                width: ScreenUtil().setWidth(980),
                child: Row(
                  //子组件沿着 Cross 轴（在 Row 中是纵轴）如何摆放，其实就是子组件对齐方式，可选值有：
                  //CrossAxisAlignment.start：子组件在 Row 中顶部对齐
                  //CrossAxisAlignment.end：子组件在 Row 中底部对齐
                  //CrossAxisAlignment.center：子组件在 Row 中居中对齐
                  //CrossAxisAlignment.stretch：拉伸填充满父布局
                  //CrossAxisAlignment.baseline：在 Row 组件中会报错
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //子组件沿着 Main 轴（在 Row 中是横轴）如何摆放，其实就是子组件排列方式，可选值有：
                  //MainAxisAlignment.start：靠左排列
                  //MainAxisAlignment.end：靠右排列
                  //MainAxisAlignment.center：居中排列
                  //MainAxisAlignment.spaceAround：每个子组件左右间隔相等，也就是 margin 相等
                  //MainAxisAlignment.spaceBetween：两端对齐，也就是第一个子组件靠左，最后一个子组件靠右，剩余组件在中间平均分散排列
                  //MainAxisAlignment.spaceEvenly：每个子组件平均分散排列，也就是宽度相等
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //Main 轴大小，可选值有：
                  //MainAxisSize.max：相当于 Android 的 match_parent
                  //MainAxisSize.min：相当于 Android 的 wrap_content
                  mainAxisSize: MainAxisSize.max,
                  //不太理解
//            textBaseline: TextBaseline.alphabetic,
                  //子组件排列顺序，可选值有：
                  //TextDirection.ltr：从左往右开始排列
                  //TextDirection.rtl：从右往左开始排列
                  textDirection: TextDirection.ltr,
                  //确定如何在垂直方向摆放子组件，以及如何解释 start 和 end，指定 height 可以看到效果，可选值有：
                  //VerticalDirection.up：Row 从下至上开始摆放子组件，此时我们看到的底部其实是顶部
                  //VerticalDirection.down：Row 从上至下开始摆放子组件，此时我们看到的顶部就是顶部
                  verticalDirection: VerticalDirection.down,

                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        ToastUtils.showToast("我的订单");
                        Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) =>
                              new HomeOrder(0)),
                        );
                      },
                      child: Column(
                        children: <Widget>[
                          Image.asset(
                            "images/index/img_index_listen.png",
                            width: ScreenUtil().setHeight(100),
                            height: ScreenUtil().setHeight(100),
                          ),
                          Text("所有订单",style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: ScreenUtil().setSp(36),
                          ),)
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        ToastUtils.showToast("等待付款");
                        Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) =>
                              new HomeOrder(1)),
                        );
                      },
                      child: Column(
                        children: <Widget>[
                          Image.asset(
                            "images/index/img_index_write.png",
                            width: ScreenUtil().setHeight(100),
                            height: ScreenUtil().setHeight(100),
                          ),
                          Text("等待付款",style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: ScreenUtil().setSp(36),
                          ),)
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        ToastUtils.showToast("已经付款");
                        Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) =>
                              new HomeOrder(2)),
                        );
                      },
                      child: Column(
                        children: <Widget>[
                          Image.asset(
                            "images/index/img_index_read.png",
                            width: ScreenUtil().setHeight(100),
                            height: ScreenUtil().setHeight(100),
                          ),
                          Text("已经付款",style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: ScreenUtil().setSp(36),
                          ),)
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        ToastUtils.showToast("暂未开发");
                      },
                      child: Column(
                        children: <Widget>[
                          Image.asset(
                            "images/index/img_index_speak.png",
                            width: ScreenUtil().setHeight(100),
                            height: ScreenUtil().setHeight(100),
                          ),
                          Text("退款/售后",style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: ScreenUtil().setSp(36),
                          ),)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ))
      ],
    );
  }


  ///底部对话框
  void showBootom(var statu) {
    showModalBottomSheet(
        context: context,
        builder: (contexts) {
          return Container(
            height: ScreenUtil().setHeight(400),
            margin: EdgeInsets.only(
                bottom: ScreenUtil().setHeight(20),
                top: ScreenUtil().setHeight(40)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          height: ScreenUtil().setHeight(120),
                          width: ScreenUtil().setHeight(120),
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.all(Radius.circular(100)),
                            border: Border.all(
                              color: Colors.white,
                              width: ScreenUtil().setWidth(10),
                            ),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("img/header_my.jpeg"),
                            ),
                          ),
                        ),
                        Text(
                          "微信",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          height: ScreenUtil().setHeight(120),
                          width: ScreenUtil().setHeight(120),
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.all(Radius.circular(100)),
                            border: Border.all(
                              color: Colors.white,
                              width: ScreenUtil().setWidth(10),
                            ),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("img/header_my.jpeg"),
                            ),
                          ),
                        ),
                        Text(
                          "QQ",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          height: ScreenUtil().setHeight(120),
                          width: ScreenUtil().setHeight(120),
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.all(Radius.circular(100)),
                            border: Border.all(
                              color: Colors.white,
                              width: ScreenUtil().setWidth(10),
                            ),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("img/header_my.jpeg"),
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            "支付宝",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      onTap: (){

                      },
                      child: Container(
                        width: ScreenUtil().setWidth(665),
                        margin: EdgeInsets.only(top: ScreenUtil().setHeight(65)),
                        height: ScreenUtil().setHeight(90),
                        alignment: Alignment.center,
                        child: Text(
                          "取消",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: ScreenUtil().setSp(33)),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            border: Border.all(color: Colors.grey)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }


}

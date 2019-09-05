import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_queue/utils/toast.dart';

//网路加载失败
class NetworkLoadFailed extends StatefulWidget {
  @override
  PlaygroundState createState() => new PlaygroundState();
}

class PlaygroundState extends State<NetworkLoadFailed> {
  // ignore: strong_mode_top_level_instance_method
  var leftRightPadding = ScreenUtil().setWidth(60);

  // ignore: strong_mode_top_level_instance_method
  var topBottomPadding = ScreenUtil().setWidth(10);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 1080, height: 1920)..init(context);
    return new Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
                top: ScreenUtil().setHeight(258),
                right: ScreenUtil().setWidth(171),
                left: ScreenUtil().setWidth(171),
                bottom: ScreenUtil().setHeight(189)),
            child: Image.asset(
              "images/img_network_fail.png",
              width: ScreenUtil.screenWidth,
              height: ScreenUtil().setHeight(645),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                left: ScreenUtil().setHeight(315),
                right: ScreenUtil().setHeight(315),
                bottom: ScreenUtil().setHeight(120)),
            child: Image.asset(
              "images/img_network_failure.png",
              width: ScreenUtil.screenWidth,
              height: ScreenUtil().setHeight(141),
            ),
          ),
          new Container(
            width: ScreenUtil().setWidth(300),
            height: ScreenUtil().setHeight(120),
            margin: EdgeInsets.fromLTRB(
              ScreenUtil().setWidth(275),
              topBottomPadding,
              ScreenUtil().setWidth(275),
              topBottomPadding,
            ),
            child: new Card(
              color: Colors.blue,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(22.0))),
              //设置圆角
              elevation: 6.0,
              child: new FlatButton(
                  onPressed: () {
                    ToastUtils.showToast("刷新");
                  },
                  child: new Padding(
                    padding: new EdgeInsets.all(ScreenUtil().setWidth(10)),
                    child: new Text(
                      '刷新',
                      style: new TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(42)),
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

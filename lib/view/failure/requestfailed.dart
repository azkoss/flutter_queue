import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_queue/utils/toast.dart';

//请求失败
class RequestFailed extends StatefulWidget {
  @override
  PlaygroundState createState() => new PlaygroundState();
}

class PlaygroundState extends State<RequestFailed> {
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
                top: ScreenUtil().setHeight(228),
                right: ScreenUtil().setWidth(300),
                left: ScreenUtil().setWidth(300),
                bottom: ScreenUtil().setHeight(226)),
            child: Image.asset(
              "images/img_network_request_fail.png",
              width: ScreenUtil.screenWidth,
              height: ScreenUtil().setHeight(621),
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
                    ToastUtils.showToast("重新加载");
                  },
                  child: new Padding(
                    padding: new EdgeInsets.all(ScreenUtil().setWidth(10)),
                    child: new Text(
                      '重新加载',
                      style: new TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(40)),
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

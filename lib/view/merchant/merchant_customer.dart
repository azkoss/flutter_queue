import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_queue/bean/queue_list_entity.dart';
import 'package:flutter_queue/bean/result_entity.dart';
import 'package:flutter_queue/bean/user_counter.dart';
import 'package:flutter_queue/utils/MyNetUtils.dart';
import 'package:flutter_queue/utils/toast.dart';
import 'package:flutter_queue/utils/values.dart';
import 'package:flutter_queue/utils/view/customdialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

///顾客页面
class MerchantCustomer extends StatefulWidget {
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<MerchantCustomer>
    with SingleTickerProviderStateMixin {
  ScrollController scrollController = ScrollController();
  AnimationController animationController;
  List<QueueListRow> rows = new List<QueueListRow>();

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200))
          ..forward();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    getAllQueue();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  ///获取所有排队信息
  void getAllQueue() {
    CounterModel user = Provider.of<CounterModel>(context);
    Map<String, dynamic> map = Map();
    Map<String, dynamic> header = Map();
    map["sid"] = user.counter.rows.id;
    //创建订单
    MyNetUtil.instance.getData("queueClient/getAllQueue", (value) async {
      QueueListEntity queueListEntity = QueueListEntity.fromJson(value);
      print("我爱你" + value.toString());
      if (queueListEntity.success) {
        rows.clear();
        rows.addAll(queueListEntity.rows);
        setState(() {});
      }
    }, params: map, headers: header);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: scrollController,
        physics: BouncingScrollPhysics(),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ...buildHeader(),
              //cart items list
              rows.length > 0
                  ? ListView.builder(
                      itemCount: rows.length,
                      shrinkWrap: true,
                      controller: scrollController,
                      itemBuilder: (BuildContext context, int index) {
                        return buildCartItemList(rows[index]);
                      },
                    )
                  : Center(
                      child: Text(
                        "当前无顾客排队",
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: ScreenUtil().setSp(50)),
                      ),
                    ),
              SizedBox(height: 16),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> buildHeader() {
    return [
      SafeArea(
        child: Row(
          children: <Widget>[
            Text('顾客排队', style: headerStyle),
            Spacer(),
          ],
        ),
      ),
    ];
  }

  Widget buildCartItemList(QueueListRow queue) {
    return Card(
      margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(40)),
      child: Container(
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
              flex: 3,
              child: Container(
                margin: EdgeInsets.only(
                    top: ScreenUtil().setHeight(28),
                    left: ScreenUtil().setHeight(15)),
                child: Text('用户：${queue.name != null ? queue.name : ""}'),
              ),
            ),
            Flexible(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: ScreenUtil().setHeight(35)),
                    child: Text(
                      '${queue.createdate}',
                      style: subtitleStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    //width: ScreenUtil().setWidth(360),
                    height: ScreenUtil().setWidth(110),
                    child: new Card(
                      //设置圆角
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(22.0))),
                      color: Colors.white70,
                      borderOnForeground: true,
                      //设置阴影
                      child: new FlatButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (_) {
                                  return CustomDialog(
                                    confirmCallback: () {
                                      //跳转到登陆页面
                                      ToastUtils.showToast("叫号");
                                      cancelQueue(queue.id, queue.sid);
                                    },
                                    confirmContent: "叫号",
                                    content: '你确定要叫号吗?',
                                    confirmColor: Colors.blue,
                                  );
                                });
                          },
                          child: new Padding(
                            padding:
                                new EdgeInsets.all(ScreenUtil().setWidth(15)),
                            child: new Text(
                              '叫号',
                              style: new TextStyle(
                                  color: Colors.black87,
                                  fontSize: ScreenUtil().setSp(38)),
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void cancelQueue(String id, String sid) {
    Map<String, dynamic> map = Map();
    Map<String, dynamic> header = Map();
    map["id"] = id;
    map["sid"] = sid;
    MyNetUtil.instance.getData("queueClient/deleteQueue", (value) async {
      print("早早早d菜：${value.toString()}");
      //获取所有菜系
      ResultEntity resultEntity = ResultEntity.fromJson(value);
      if (resultEntity.success) {
        ToastUtils.showToast("叫号成功");
        getAllQueue();
      }
    }, params: map, headers: header);
  }
}

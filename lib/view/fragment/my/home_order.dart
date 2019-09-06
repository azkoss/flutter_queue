import 'package:flutter/material.dart';
import 'package:flutter_queue/bean/user_counter.dart';
import 'package:flutter_queue/bean/user_entity.dart';
import 'package:flutter_queue/utils/MyNetUtils.dart';
import 'package:flutter_queue/utils/toast.dart';
import 'package:flutter_queue/view/fragment/my/order/order_all.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

///所有订单页面
class HomeOrder extends StatefulWidget {
  int flag;
  HomeOrder(int flag){
    this.flag = flag;
  }

  @override
  PlaygroundState createState() => new PlaygroundState();
}

class PlaygroundState extends State<HomeOrder> with SingleTickerProviderStateMixin{

  TabController controller;
  var tabs = <Container>[];
  @override
  void initState() {
    super.initState();
    tabs = <Container>[
      Container(
        child: Tab(
          text: "全部",
        ),
      ),
      Container(
        child: Tab(
          text: "待付款",
        ),
      ),
      Container(
        child: Tab(
          text: "已付款",
        ),
      ),
    ];

    //initialIndex初始选中第几个
    controller =
        TabController(initialIndex: widget.flag, length: tabs.length, vsync: this);
  }



  @override
  Widget build(BuildContext context) {
    CounterModel user = Provider.of<CounterModel>(context);
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("我的订单"),
        backgroundColor: Colors.orange, //设置appbar背景颜色
        centerTitle: true, //设置标题是否局中
        bottom: TabBar(
          controller: controller,
          //可以和TabBarView使用同一个TabController
          tabs: tabs,
          isScrollable: false,
          indicatorColor: Colors.blueAccent,
          indicatorWeight: 3,
          indicatorSize:TabBarIndicatorSize.label,
          indicatorPadding: EdgeInsets.only(
              bottom: ScreenUtil().setHeight(5),
              left: ScreenUtil().setWidth(180),
              right: ScreenUtil().setWidth(180)),
          labelColor: Color(0xff333333),
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: ScreenUtil().setSp(36),
          ),
          unselectedLabelColor: Colors.black54,
          unselectedLabelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: ScreenUtil().setSp(34),
          ),
        ),
      ),
      body: TabBarView(controller: controller, children: [
        OrderAll(user,1), //所有
        OrderAll(user,2), //待付款
        OrderAll(user,3), //已付款
      ]),
    );
  }



}

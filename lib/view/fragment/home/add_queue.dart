import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_queue/bean/merchant_entity.dart';
import 'package:flutter_queue/bean/result_entity.dart';
import 'package:flutter_queue/bean/user_counter.dart';
import 'package:flutter_queue/bean/user_entity.dart';
import 'package:flutter_queue/utils/MyNetUtils.dart';
import 'package:flutter_queue/utils/values.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

///用户排队页面
class AddQueue extends StatefulWidget {
  MerchantRow merchantRow;

  AddQueue(MerchantRow merchantRow) {
    this.merchantRow = merchantRow;
  }

  @override
  PlaygroundState createState() => new PlaygroundState();
}

class PlaygroundState extends State<AddQueue> {
  String num = "0";
  String btnName = "点击排队";

  //String queueId = "";

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    getIsHave();
  }

  ///获取当前饭店排队数量
  void initData() {
    Map<String, dynamic> map = Map();
    Map<String, dynamic> header = Map();
    map["sid"] = widget.merchantRow.id;
    MyNetUtil.instance.getData("queueClient/getQueueCount", (value) async {
      print("获取当前饭店排队数量：${value.toString()}");
      //获取所有菜系
      ResultEntity resultEntity = ResultEntity.fromJson(value);

      num = resultEntity.rows;
      print("早早早" + resultEntity.rows);
      setState(() {});
    }, params: map, headers: header);
  }

  ///获取当前是否在此饭店排队
  void getIsHave() {
    CounterModel user = Provider.of<CounterModel>(context);
    Map<String, dynamic> map = Map();
    Map<String, dynamic> header = Map();
    map["sid"] = widget.merchantRow.id;
    map["zid"] = user.counter.rows.id;
    MyNetUtil.instance.getData("queueClient/isHaveQueue", (value) async {
      //print("早早早菜：${value.toString()}");
      //获取所有菜系
      ResultEntity resultEntity = ResultEntity.fromJson(value);
      if (resultEntity.success) {
        //queueId = resultEntity.rows;
        btnName = "取消排队";
      } else {
        btnName = "点击排队";
      }
      setState(() {});
    }, params: map, headers: header);
  }

  ///开始排队
  void addQueue(UserRows user) {
    if (btnName == "取消排队") {
      Map<String, dynamic> map = Map();
      Map<String, dynamic> header = Map();
      map["id"] = user.id;
      map["sid"] = widget.merchantRow.id;
      MyNetUtil.instance.getData("queueClient/deleteQueue", (value) async {
        print("早早早d菜：${value.toString()}");
        //获取所有菜系
        ResultEntity resultEntity = ResultEntity.fromJson(value);
        if (resultEntity.success) {
          num = resultEntity.rows;
          btnName = "点击排队";
          setState(() {});
        }
      }, params: map, headers: header);
    } else {
      Map<String, dynamic> map = Map();
      Map<String, dynamic> header = Map();
      map["sid"] = widget.merchantRow.id;
      map["zid"] = user.id;
      map["name"] = user.name;
      MyNetUtil.instance.getData("queueClient/addQueue", (value) async {
        print("早早早菜ss：${value.toString()}");
        //获取所有菜系
        ResultEntity resultEntity = ResultEntity.fromJson(value);
        if (resultEntity.success) {
          print("早早早菜sscs：${resultEntity.toString()}");
          num = resultEntity.rows;
          btnName = "取消排队";
          setState(() {});
        }
      }, params: map, headers: header);
    }
  }

  @override
  Widget build(BuildContext context) {
    CounterModel user = Provider.of<CounterModel>(context);
    return new Scaffold(
      body: Scaffold(
        body: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(36),
                  vertical: ScreenUtil().setWidth(40)),
              child: Column(
                children: <Widget>[
                  buildAppBar(),
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    child: /*Image.network(
                    mData.heads != null ? mData.heads : "",
                    width: ScreenUtil().setWidth(260),
                    height: ScreenUtil().setHeight(260),
                    fit: BoxFit.cover,
                  )*/
                    CachedNetworkImage(
                      imageUrl: widget.merchantRow.heads != null ? widget.merchantRow.heads : "",
                      placeholder: (context, url) => Center(child: CupertinoActivityIndicator()),
                      errorWidget: (context, url, error) => new Icon(Icons.error),
                      /*width: ScreenUtil().setWidth(260),
                  height: ScreenUtil().setHeight(260),*/
                      fit: BoxFit.cover,
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                            top: ScreenUtil().setWidth(45),
                            bottom: ScreenUtil().setWidth(20)),
                        child: Text(
                          "当前餐厅${widget.merchantRow.name}排队人数：",
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(50),
                              color: Colors.black87),
                        ),
                      ),
                      Container(
                        child: Text(
                          "$num",
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(100),
                              color: Colors.black),
                        ),
                      ),

                    ],
                  ),
                  Container(
                    margin: EdgeInsets.all(ScreenUtil().setWidth(50)),
                    child: InkWell(
                      onTap: () {
                        addQueue(user.counter.rows);
                      },
                      child: CircleAvatar(
                        radius: 56.0,
                        backgroundColor: Colors.red,
                        child: Container(
                          child: Center(
                            child: Text(
                              btnName,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildAppBar() {
    return SafeArea(
      child: Row(
        children: <Widget>[
          Text('排队', style: headerStyle),
          Spacer(),
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                initData();
                /*Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new AddQueue(widget.merchantRow)),
                );*/
              }),
        ],
      ),
    );
  }

}




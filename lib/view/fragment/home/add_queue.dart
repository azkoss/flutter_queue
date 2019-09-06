import 'package:flutter/material.dart';
import 'package:flutter_queue/bean/result_entity.dart';
import 'package:flutter_queue/bean/user_counter.dart';
import 'package:flutter_queue/bean/user_entity.dart';
import 'package:flutter_queue/utils/MyNetUtils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

///用户排队页面
class AddQueue extends StatefulWidget {
  String merchantId;

  AddQueue(String id) {
    this.merchantId = id;
  }

  @override
  PlaygroundState createState() => new PlaygroundState();
}

class PlaygroundState extends State<AddQueue> {

  String num = "";
  String btnName = "点击排队";
  String queueId = "";

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
    map["sid"] = widget.merchantId;
    MyNetUtil.instance.getData("queueClient/getQueueCount", (value) async {
      print("获取当前饭店排队数量：${value.toString()}");
      //获取所有菜系
      ResultEntity resultEntity = ResultEntity.fromJson(value);

        num = resultEntity.rows;
        print("早早早"+resultEntity.rows);
        setState(() {});


    }, params: map, headers: header);

  }

  ///获取当前是否在此饭店排队
  void getIsHave() {
    CounterModel user = Provider.of<CounterModel>(context);
    Map<String, dynamic> map = Map();
    Map<String, dynamic> header = Map();
    map["sid"] = widget.merchantId;
    map["zid"] = user.counter.rows.id;
    MyNetUtil.instance.getData("queueClient/isHaveQueue", (value) async {
      //print("早早早菜：${value.toString()}");
      //获取所有菜系
      ResultEntity resultEntity = ResultEntity.fromJson(value);
      if (resultEntity.success) {
        queueId = resultEntity.rows;
        btnName = "取消排队";
      }else{
        btnName = "点击排队";
      }
      setState(() {});

    }, params: map, headers: header);
  }



  ///开始排队
  void addQueue(UserRows user) {
    if(btnName == "取消排队"){
      Map<String, dynamic> map = Map();
      Map<String, dynamic> header = Map();
      map["id"] = queueId;
      map["sid"] = widget.merchantId;
      MyNetUtil.instance.getData("queueClient/deleteQueue", (value) async {
        print("早早早d菜：${value.toString()}");
        //获取所有菜系
        ResultEntity resultEntity = ResultEntity.fromJson(value);
        if (resultEntity.success) {
          num = resultEntity.rows;
          btnName = "点击排队";
          setState(() {

          });
        }
      }, params: map, headers: header);
    }else {
      Map<String, dynamic> map = Map();
      Map<String, dynamic> header = Map();
      map["sid"] = widget.merchantId;
      map["zid"] = user.id;
      map["name"] = user.name;
      MyNetUtil.instance.getData("queueClient/addQueue", (value) async {
        print("早早早菜ss：${value.toString()}");
        //获取所有菜系
        ResultEntity resultEntity = ResultEntity.fromJson(value);
        if(resultEntity.success) {
          print("早早早菜sscs：${resultEntity.toString()}");
          num = resultEntity.rows;
          btnName = "取消排队";
          setState(() {

          });
        }
      }, params: map, headers: header);
    }
  }


  @override
  Widget build(BuildContext context) {
    CounterModel user = Provider.of<CounterModel>(context);
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("用户排队"),
        backgroundColor: Colors.orange, //设置appbar背景颜色
        centerTitle: true, //设置标题是否局中
      ),
      body: new Container(
        //color: Colors.orange,   http://img3.imgtn.bdimg.com/it/u=2892725593,305691722&fm=26&gp=0.jpg
        width: ScreenUtil.screenWidth,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/index/img_index_bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            Container(

              //width: ScreenUtil().setWidth(700),
              margin: EdgeInsets.all(ScreenUtil().setWidth(70)),
              child: new Card(
                color: Colors.orange,
                elevation: 6.0,
                child: new FlatButton(
                    onPressed: () {
                      initData();
                    },
                    child: new Padding(
                      padding: new EdgeInsets.all(ScreenUtil().setWidth(30)),
                      child: Text("刷新",style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(40)),),
                    )),
              ),
            ),

            Container(
              margin: EdgeInsets.all(ScreenUtil().setWidth(40)),
              child: InkWell(
                onTap: (){
                  addQueue(user.counter.rows);
                },
                child: CircleAvatar(
                  radius: 56.0,
                  backgroundColor: Colors.red,
                  /*backgroundImage: NetworkImage(
                      user.counter.rows.heads != null
                          ? user.counter.rows.heads
                          : ""),*/
                  child: Container(
                    width: ScreenUtil().setWidth(250),
                    height: ScreenUtil().setWidth(250),
                    child:Center(
                      child:  Text(btnName,style: TextStyle(color: Colors.white),),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(ScreenUtil().setWidth(40)),
              child: Text("当前餐厅排队人数：$num",style: TextStyle(fontSize: ScreenUtil().setSp(50)),),
            ),
          ],
        ),
      ),
    );
  }


}

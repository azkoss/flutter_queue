import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_queue/bean/merchant_entity.dart';
import 'package:flutter_queue/utils/MyNetUtils.dart';
import 'package:flutter_queue/utils/view/runningheader.dart';
import 'package:flutter_queue/view/failure/requestfailed.dart';
import 'package:flutter_queue/view/homepage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SelectMerchant extends StatefulWidget {
  @override
  SelectMerchantState createState() => new SelectMerchantState();
}

class SelectMerchantState extends State<SelectMerchant> {

  List<MerchantRow> mData = new List();

  @override
  void initState() {
    super.initState();
    initData();
  }


  ///加载数据
  void initData() {
    /*Navigator.pushAndRemoveUntil(
              context,
              new MaterialPageRoute(builder: (context) => new Home()),
                  (route) => route == null,
            );*/
    Map<String, dynamic> map = Map();
    Map<String, dynamic> header = Map();
    //获取所有餐厅
    MyNetUtil.instance.getData("userClient/getAllMerchant", (value) async {
      //获取所有菜系
      MerchantEntity foodTypeEntity = MerchantEntity.fromJson(value);
      if (foodTypeEntity.success) {
        mData.clear();
        mData.addAll(foodTypeEntity.rows);
        setState(() {

        });
      }
    }, params: map, headers: header);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("选择餐厅"),
        backgroundColor: Color(0xFF1E88E5), //设置appbar背景颜色
        centerTitle: true, //设置标题是否局中
      ),
      body: mData.length <= 0
          ? RequestFailed() //请求失败
          : new Center(
        child: MerchantList(mData),
      ),
    );
  }
}

///餐厅列表
// ignore: must_be_immutable
class MerchantList extends StatefulWidget {
  List<MerchantRow> mData =List<MerchantRow>();
  MerchantList(List<MerchantRow> mData){
    this.mData = mData;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return itemBuild();
  }
}

class itemBuild extends State<MerchantList> {
  //初始化滚动监听器，加载更多使用
  int pages = 1;
  ScrollController _controller = new ScrollController();
  String loadMoreText = "没有更多数据";
  TextStyle loadMoreTextStyle =
  new TextStyle(color: const Color(0xFF999999), fontSize: 14.0);

  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    print("=" + widget.mData.toString());

    return Container(
      child: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: RunningHeader(),
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Text("上拉加载");
            } else if (mode == LoadStatus.loading) {
              body = CupertinoActivityIndicator();
            } else if (mode == LoadStatus.failed) {
              body = Text("加载失败!点击重试!");
            } else {
              body = Text("没有更多数据");
            }
            return Container(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: ListView.builder(
          itemCount: widget.mData.length,
          itemBuilder: (BuildContext context, int position) {
            return InkWell(
              onTap: () {
                //
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) =>
                      new Home(widget.mData[position])),
                );
              },
              child: getItem(widget.mData[position]),
            );
          },
          controller: _controller,
        ),
      ),
    );
  }

  //下拉刷新
  Future<Null> _onRefresh() async {
    load(1, "");
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
    return;
  }

  //上拉加载
  void _onLoading() async {
    pages++;
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    load(pages, "");
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  //获取当前登录人的数据库信息
  void load(int page, String keyword) async {
    if (page == 1) {
      widget.mData.clear();
      Map<String, dynamic> map = Map();
      Map<String, dynamic> header = Map();
      //获取所有餐厅
      MyNetUtil.instance.getData("userClient/getAllMerchant", (value) async {
        //获取所有菜系
        MerchantEntity foodTypeEntity = MerchantEntity.fromJson(value);
        if (foodTypeEntity.success) {
          widget.mData.clear();
          widget.mData.addAll(foodTypeEntity.rows);
          setState(() {

          });
        }
      }, params: map, headers: header);
    } else {
    }

    setState(() {});
  }

  Widget getItem(MerchantRow mData) {
    return Stack(
      alignment: Alignment(1, -1.4),
      children: <Widget>[
        Container(
          width: ScreenUtil.screenWidth,
          height: ScreenUtil().setHeight(455),
          decoration: BoxDecoration(
            //设置背景图片
            image: DecorationImage(
              image: AssetImage("images/img_banner.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, //列里用这个
            children: <Widget>[
              Container(
                //id
                margin: EdgeInsets.only(
                    top: ScreenUtil().setHeight(100),
                    left: ScreenUtil().setWidth(39)),
                child: Text(
                  "Test${mData.merchant}",
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(60),
                      color: Colors.yellow,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                //标题
                margin: EdgeInsets.only(
                    top: ScreenUtil().setHeight(50),
                    left: ScreenUtil().setWidth(36)),
                child: Text(
                  "${mData.name}",
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(60), color: Colors.white),
                ),
              ),
              Container(
                //描述
                margin: EdgeInsets.only(
                    top: ScreenUtil().setHeight(10),
                    left: ScreenUtil().setWidth(39)),
                child: Text(
                  "${mData.phone}",
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(40), color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}


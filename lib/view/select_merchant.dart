import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_queue/bean/merchant_entity.dart';
import 'package:flutter_queue/utils/MyNetUtils.dart';
import 'package:flutter_queue/utils/values.dart';
import 'package:flutter_queue/view/failure/requestfailed.dart';
import 'package:flutter_queue/view/homepage.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    Map<String, dynamic> map = Map();
    Map<String, dynamic> header = Map();
    //获取所有餐厅
    MyNetUtil.instance.getData("userClient/getAllMerchant", (value) async {
      //获取所有菜系
      MerchantEntity foodTypeEntity = MerchantEntity.fromJson(value);
      if (foodTypeEntity.success) {
        mData.clear();
        mData.addAll(foodTypeEntity.rows);
        setState(() {});
      }
    }, params: map, headers: header);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("选择餐厅"),
        backgroundColor: Colors.orange, //设置appbar背景颜色
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
  List<MerchantRow> mData = List<MerchantRow>();

  MerchantList(List<MerchantRow> mData) {
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
        header: WaterDropHeader(),
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
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString("merchantId", widget.mData[position].id);
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new Home(widget.mData[position])),
                );
              },
              child: getItems(widget.mData[position]),
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
        //获取所有餐厅
        MerchantEntity foodTypeEntity = MerchantEntity.fromJson(value);
        if (foodTypeEntity.success) {
          widget.mData.clear();
          widget.mData.addAll(foodTypeEntity.rows);
          setState(() {});
        }
      }, params: map, headers: header);
    } else {}

    setState(() {});
  }

  Widget getItems(MerchantRow mData) {
    return Card(
      margin: EdgeInsets.only(
          top: ScreenUtil().setWidth(20),
          left: ScreenUtil().setWidth(20),
          right: ScreenUtil().setWidth(20)),
      //设置圆角
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      //color: Colors.white,
      //设置阴影
      elevation: 4.0,
      child: Container(
        margin: EdgeInsets.all(ScreenUtil().setHeight(20)),
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                  child: Image.network(
                    mData.heads != null ? mData.heads : "",
                    width: ScreenUtil().setWidth(260),
                    height: ScreenUtil().setHeight(260),
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: ScreenUtil().setWidth(20),
                      top: ScreenUtil().setWidth(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          margin:
                          EdgeInsets.only(top: ScreenUtil().setHeight(10)),
                          child: Text(
                            mData.name != null ? mData.name : "",
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(60),
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          )),
                      Container(
                        margin:
                        EdgeInsets.only(top: ScreenUtil().setHeight(15)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            RatingBar(
                              initialRating: 4.5,
                              direction: Axis.horizontal,
                              itemCount: 5,
                              itemSize: 17,
                              unratedColor: Colors.black,
                              itemPadding: EdgeInsets.only(right: 4.0),
                              ignoreGestures: true,
                              itemBuilder: (context, index) =>
                                  Icon(Icons.star, color: mainColor),
                              onRatingUpdate: (rating) {},
                            ),
                            Text('￥69/人'),
                          ],
                        ),
                      ),
                      Container(
                        margin:
                        EdgeInsets.only(top: ScreenUtil().setHeight(15)),
                        child: Text(
                          "95代金券抵100",
                          style: TextStyle(fontSize: ScreenUtil().setSp(34)),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: ScreenUtil().setHeight(15)),
              child: Text(
                mData.gender != null ? mData.gender : "",
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(34),
                    color: Colors.black87,
                    height: 1.2),
              ),
            )
          ],
        ),
      ),
    );
  }
}

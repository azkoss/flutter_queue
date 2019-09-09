import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_queue/bean/order_list_entity.dart';
import 'package:flutter_queue/bean/result_entity.dart';
import 'package:flutter_queue/bean/user_counter.dart';
import 'package:flutter_queue/utils/MyNetUtils.dart';
import 'package:flutter_queue/utils/toast.dart';
import 'package:flutter_queue/utils/values.dart';
import 'package:flutter_queue/utils/view/customdialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

///所有订单页面
class OrderAll extends StatefulWidget {
  CounterModel user;
  int flag;

  OrderAll(CounterModel user, int flag) {
    this.user = user;
    this.flag = flag;
  }

  @override
  HomeEvaluateAllState createState() => new HomeEvaluateAllState();
}

class HomeEvaluateAllState extends State<OrderAll> {
  List<OrderListRow> orderList = List<OrderListRow>();

  //初始化滚动监听器，加载更多使用
  int pages = 1;
  ScrollController _controller = new ScrollController();
  ScrollController scrollController = ScrollController();
  String loadMoreText = "没有更多数据";
  TextStyle loadMoreTextStyle =
      new TextStyle(color: const Color(0xFF999999), fontSize: 14.0);

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    load(1);
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
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
      child: orderList.length > 0
          ? ListView.builder(
              //physics: NeverScrollableScrollPhysics(),
              //shrinkWrap: true,
              itemCount: orderList.length,
              itemBuilder: (BuildContext context, int position) {
                return getItem(orderList[position]);
              },
              controller: _controller,
            )
          : Center(
              child: Text("当前无订单"),
            ),
    );
  }

  //下拉刷新
  Future<Null> _onRefresh() async {
    load(1);
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
    load(pages);
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  ///加载实体类
  void load(int page) async {
    if (page == 1) {
      orderList.clear();
      Map<String, dynamic> map = Map();
      Map<String, dynamic> header = Map();
      String id = widget.user.counter.rows.id;
      String url;
      if (widget.user.counter.rows.merchant == 0) {
        url = "orderClient/getOrderListByUid";
        map["uid"] = id;
      } else {
        url = "orderClient/getOrderListByCid";
        map["cid"] = id;
      }
      //获取该用户或商家所有订单
      MyNetUtil.instance.getData(url, (value) async {
        OrderListEntity orderListEntity = OrderListEntity.fromJson(value);
        if (orderListEntity.success) {
          if (widget.flag == 1) {
            orderList.addAll(orderListEntity.rows);
          } else if (widget.flag == 2) {
            for (int i = 0; i < orderListEntity.rows.length; i++) {
              if (orderListEntity.rows[i].payment == 0) {
                orderList.add(orderListEntity.rows[i]);
              }
            }
          } else {
            for (int i = 0; i < orderListEntity.rows.length; i++) {
              if (orderListEntity.rows[i].payment != 0) {
                orderList.add(orderListEntity.rows[i]);
              }
            }
          }
          setState(() {});
        }
      }, params: map, headers: header);
    }
  }

  ///删除订单
  void deleteOrder(String id) {
    Map<String, dynamic> map = Map();
    Map<String, dynamic> header = Map();
    map["id"] = id;
    MyNetUtil.instance.getData("orderClient/deleteOrder", (value) async {
      ResultEntity resultEntity = ResultEntity.fromJson(value);
      if (resultEntity.success) {
        load(1);
      }
    }, params: map, headers: header);
  }

  ///构建列表
  Widget getItem(OrderListRow orderListRow) {
    return InkWell(
      onTap: () {
        ToastUtils.showToast("此订单花费${orderListRow.amount}元");
      },
      child: Container(
        margin: EdgeInsets.only(
            top: ScreenUtil().setHeight(30),
            right: ScreenUtil().setWidth(30),
            left: ScreenUtil().setWidth(30)),
        child: Card(
          //设置圆角
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          color: Colors.white,
          //设置阴影
          elevation: 3.0,
          child: Container(
            padding: EdgeInsets.all(ScreenUtil().setHeight(15)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                ListView.builder(
                  itemCount: orderListRow.allMyOrder.length,
                  shrinkWrap: true,
                  controller: scrollController,
                  itemBuilder: (BuildContext context, int index) {
                    return buildCartItemList(orderListRow.allMyOrder[index]);
                  },
                ),
                Container(
                  margin: EdgeInsets.only(
                      bottom: ScreenUtil().setHeight(20),
                      right: ScreenUtil().setWidth(20)),
                  child: Text("共${orderListRow.allMyOrder.length}件商品 合计：￥${orderListRow.amount}元"),
                ),
                Container(
                  //width: ScreenUtil().setWidth(360),
                  height: ScreenUtil().setWidth(110),
                  child: new Card(
                    //设置圆角
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(22.0))),
                    color: Colors.white,
                    borderOnForeground: true,
                    //设置阴影
                    child: new FlatButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (_) {
                                return CustomDialog(
                                  confirmCallback: () {//跳转到登陆页面
                                    ToastUtils.showToast("删除订单");
                                    deleteOrder(orderListRow.id);
                                  },
                                  confirmContent: "删除",
                                  content: '你确定要删除订单吗?',
                                  confirmColor: Colors.blue,
                                );
                              });
                        },
                        child: new Padding(
                          padding:
                              new EdgeInsets.all(ScreenUtil().setWidth(15)),
                          child: new Text(
                            '删除订单',
                            style: new TextStyle(
                                color: Colors.black87,
                                fontSize: ScreenUtil().setSp(38)),
                          ),
                        )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCartItemList(OrderListRowsAllmyorder cartModel) {
    return Container(
      padding: EdgeInsets.all(ScreenUtil().setHeight(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(
            flex: 3,
            fit: FlexFit.tight,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              child: /*Image.network(
                cartModel.food.img != null ? cartModel.food.img : "",
              )*/
              CachedNetworkImage(
                imageUrl: cartModel.food.img != null ? cartModel.food.img : "",
                placeholder: (context, url) => Center(child: CupertinoActivityIndicator()),
                errorWidget: (context, url, error) => new Icon(Icons.error),
              ),
            ),
          ),
          Flexible(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 45,
                  child: Text(
                    cartModel.food.name,
                    style: subtitleStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  color: Colors.white24,
                  child: Text(
                    "卫生安全保障",
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(30),
                        fontWeight: FontWeight.w500,
                        color: Colors.orange),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: 45,
                  width: 70,
                  child: Text(
                    '\￥ ${cartModel.food.price}',
                    style: titleStyle,
                    textAlign: TextAlign.end,
                  ),
                ),
                Container(
                  height: 45,
                  width: 70,
                  child: Text(
                    '\X ${cartModel.num}',
                    style: subtitleStyle,
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


}

import 'package:flutter/material.dart';
import 'package:flutter_queue/bean/cart_model.dart';
import 'package:flutter_queue/bean/result_entity.dart';
import 'package:flutter_queue/bean/user_counter.dart';
import 'package:flutter_queue/utils/MyNetUtils.dart';
import 'package:flutter_queue/utils/toast.dart';
import 'package:flutter_queue/utils/values.dart';
import 'package:flutter_queue/view/fragment/checkout_page.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
///弹出购物车
class CartBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MyCart cart = Provider.of<MyCart>(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            child: Container(
              width: 90,
              height: 8,
              decoration: ShapeDecoration(
                  shape: StadiumBorder(), color: Colors.black26),
            ),
          ),
          buildTitle(cart),
          Divider(),
          if (cart.cartItems.length <= 0) // ignore: sdk_version_ui_as_code
            noItemWidget()
          else
            buildItemsList(cart),
          Divider(),
          buildPriceInfo(cart),
          SizedBox(height: 8),
          addToCardButton(cart, context),
        ],
      ),
    );
    //});
  }

  Widget buildTitle(cart) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text('你的订单', style: headerStyle),
        RaisedButton.icon(
          icon: Icon(Icons.delete_forever),
          color: Colors.red,
          shape: StadiumBorder(),
          splashColor: Colors.white60,
          onPressed: cart.clearCart,
          textColor: Colors.white,
          label: Text('清空'),
        ),
      ],
    );
  }

  Widget buildItemsList(MyCart cart) {
    return Expanded(
      child: ListView.builder(
        itemCount: cart.cartItems.length,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                  backgroundImage:
                      NetworkImage(cart.cartItems[index].food.img!=null?cart.cartItems[index].food.img:"")),
              title: Text('${cart.cartItems[index].food.name}',
                  style: subtitleStyle),
              subtitle: Text('\￥ ${cart.cartItems[index].food.price}'),
              trailing: Text('x ${cart.cartItems[index].quantity}',
                  style: subtitleStyle),
            ),
          );
        },
      ),
    );
  }

  Widget noItemWidget() {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('你现在还没有订单！！！', style: titleStyle2),
            SizedBox(height: 16),
            Icon(Icons.remove_shopping_cart, size: 40),
          ],
        ),
      ),
    );
  }

  Widget buildPriceInfo(MyCart cart) {
    double total = 0;
    for (CartItem cartModel in cart.cartItems) {
      total += cartModel.food.price * cartModel.quantity;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text('总计:', style: headerStyle),
        Text('\￥ ${total.toStringAsFixed(2)}', style: headerStyle),
      ],
    );
  }

  Widget addToCardButton(cart, context) {
    return Center(
      child: RaisedButton(
        child: Text('提交订单', style: titleStyle),
        onPressed: cart.cartItems.length == 0
            ? null
            : () {
          CounterModel user = Provider.of<CounterModel>(context);
          createOrder(user.counter.rows.id,cart);
                //Navigator.of(context).pop();
                /*Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CheckOutPage()));*/
                //ToastUtils.showToast("请前往购物车查看详细信息");
              },
        padding: EdgeInsets.symmetric(horizontal: 64, vertical: 12),
        color: mainColor,
        shape: StadiumBorder(),
      ),
    );
  }

  ///创建订单
  Future createOrder(String uid, MyCart cart) async {
    double amount = 0;
    for(int i = 0;i<cart.cartItems.length;i++){
      amount=cart.cartItems[i].quantity*cart.cartItems[i].food.price+amount;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String merchantId = prefs.getString("merchantId");
    Map<String, dynamic> map = Map();
    Map<String, dynamic> header = Map();
    map["cid"] = merchantId;
    map["uid"] = uid;
    map["amount"] = amount;
    //创建订单
    MyNetUtil.instance.getData("orderClient/addOrder", (value) async {
      ResultEntity resultEntity = ResultEntity.fromJson(value);
      if (resultEntity.success) {
        createOrderDetails(cart,merchantId,resultEntity.rows);
        ToastUtils.showToast("提交订单成功");
        cart.clearCart();
      }
    }, params: map, headers: header);
  }


  ///创建订单详情
  bool createOrderDetails(MyCart cart, String merchantId,String did) {
    bool isSuccess = false;

    for(int i = 0;i<cart.cartItems.length;i++){
      Map<String, dynamic> map = Map();
      Map<String, dynamic> header = Map();
      map["did"] = did;
      map["cid"] = cart.cartItems[i].food.id;
      map["amount"] = cart.cartItems[i].food.price*cart.cartItems[i].quantity;
      map["num"] = cart.cartItems[i].quantity;
      MyNetUtil.instance.getData("orderClient/addOrderDetails", (value) async {
        ResultEntity resultEntity = ResultEntity.fromJson(value);
        if (resultEntity.success) {
          isSuccess = true;
        }
      }, params: map, headers: header);
    }
    return isSuccess;
  }

}

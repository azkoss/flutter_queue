import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_queue/bean/cart_model.dart';
import 'package:flutter_queue/utils/toast.dart';
import 'package:flutter_queue/utils/values.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
///购物车页面
class CheckOutPage extends StatefulWidget {
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> with SingleTickerProviderStateMixin {
  var now = DateTime.now();
  get weekDay => DateFormat('EEEE').format(now);
  get day => DateFormat('dd').format(now);
  get month => DateFormat('MMMM').format(now);
  double oldTotal = 0;
  double total = 0;

  ScrollController scrollController = ScrollController();
  AnimationController animationController;
  @override
  void initState() {
    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 200))..forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<MyCart>(context);
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
              ListView.builder(
                itemCount: cart.cartItems.length,
                shrinkWrap: true,
                controller: scrollController,
                itemBuilder: (BuildContext context, int index) {
                  return buildCartItemList(cart, cart.cartItems[index]);
                },
              ),
              SizedBox(height: 16),
              Divider(),
              buildPriceInfo(cart),
              checkoutButton(cart, context),
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
            Text('购物车', style: headerStyle),
            Spacer(),
          ],
        ),
      ),
    ];
  }

  Widget buildPriceInfo(MyCart cart) {
    oldTotal = total;
    total = 0;
    for (CartItem cart in cart.cartItems) {
      total += cart.food.price * cart.quantity;
    }
    //oldTotal = total;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text('总计:', style: headerStyle),
        AnimatedBuilder(
          animation: animationController,
          builder: (context, child) {
            return Text('\￥ ${lerpDouble(oldTotal, total, animationController.value).toStringAsFixed(2)}', style: headerStyle);
          },
        ),
      ],
    );
  }

  Widget checkoutButton(MyCart cart, context) {
    return Container(
      margin: EdgeInsets.only(top: 24, bottom: 64),
      width: double.infinity,
      child: RaisedButton(
        child: Text('提交订单', style: titleStyle),
        onPressed: () {
          if(cart.cartItems.length>0) {
            cart.clearCart();
          }else{
            ToastUtils.showToast("当前购物车为空");
          }
          //Navigator.of(context).pop();
        },
        padding: EdgeInsets.symmetric(horizontal: 64, vertical: 12),
        color: mainColor,
        shape: StadiumBorder(),
      ),
    );
  }

  Widget buildCartItemList(MyCart cart, CartItem cartModel) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      child: Container(
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
              flex: 3,
              fit: FlexFit.tight,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: Image.network(cartModel.food.img!=null?cartModel.food.img:""),
              ),
            ),
            Flexible(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: 45,
                    child: Text(
                      cartModel.food.name,
                      style: subtitleStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        customBorder: roundedRectangle4,
                        onTap: () {
                          cart.decreaseItem(cartModel);
                          animationController.reset();
                          animationController.forward();
                        },
                        child: Icon(Icons.remove_circle),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 2),
                        child: Text('${cartModel.quantity}', style: titleStyle),
                      ),
                      InkWell(
                        customBorder: roundedRectangle4,
                        onTap: () {
                          cart.increaseItem(cartModel);
                          animationController.reset();
                          animationController.forward();
                        },
                        child: Icon(Icons.add_circle),
                      ),
                    ],
                  )
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
                      '\$ ${cartModel.food.price}',
                      style: titleStyle,
                      textAlign: TextAlign.end,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      cart.removeAllInCart(cartModel.food);
                      animationController.reset();
                      animationController.forward();
                    },
                    customBorder: roundedRectangle12,
                    child: Icon(Icons.delete_sweep, color: Colors.red),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

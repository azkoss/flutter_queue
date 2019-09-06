import 'package:flutter/material.dart';
import 'package:flutter_queue/bean/merchant_entity.dart';
import 'package:flutter_queue/bean/user_entity.dart';
import 'package:flutter_queue/view/bottomnavigation.dart';
import 'package:flutter_queue/view/fragment/checkout_page.dart';
import 'package:flutter_queue/view/fragment/home_my_page.dart';
import 'package:flutter_queue/view/fragment/home_page.dart';
import 'package:flutter_queue/view/merchant/home_page_merchant.dart';
import 'package:flutter_queue/view/merchant/merchant_bottomnavigation.dart';
import 'package:flutter_queue/view/merchant/merchant_customer.dart';

///商家首页
class MerChantHome extends StatefulWidget {
  UserRows rows;

  MerChantHome(UserRows rows){
    this.rows = rows;
  }


  @override
  PlaygroundState createState() => new PlaygroundState();
}

class PlaygroundState extends State<MerChantHome> {
  List<Widget> list = List();
  int _currentIndex = 0;

  MerchantRow merchantRow;


  @override
  void initState(){
    merchantRow = new MerchantRow(password: widget.rows.password,phone: widget.rows.phone,name: widget.rows.name,merchant: widget.rows.merchant,id: widget.rows.id,heads: widget.rows.heads,account: widget.rows.account);
    list..add(MerchantMyHomePage(merchantRow))..add(MerchantCustomer())..add(HomeMyPage());
    super.initState(); //无名无参需要调用
  }

  onTap(index) {
    _currentIndex = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: list[_currentIndex],
      bottomNavigationBar: MerChantBottomNavigationWidget(onTap),
    );
  }
}
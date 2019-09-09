import 'package:flutter/material.dart';
import 'package:flutter_queue/bean/merchant_entity.dart';
import 'package:flutter_queue/view/bottomnavigation.dart';
import 'package:flutter_queue/view/fragment/home/add_queue.dart';
import 'package:flutter_queue/view/fragment/home_my_page.dart';


import 'fragment/checkout_page.dart';
import 'fragment/home_page.dart';

class Home extends StatefulWidget {
  MerchantRow merchantRow;

  Home(MerchantRow mData){
    this.merchantRow= mData;
  }

  @override
  PlaygroundState createState() => new PlaygroundState();
}

class PlaygroundState extends State<Home> {
  List<Widget> list = List();
  int _currentIndex = 0;

  @override
  void initState(){
    list..add(MyHomePage(widget.merchantRow))..add(AddQueue(widget.merchantRow))..add(CheckOutPage())..add(HomeMyPage());
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
      bottomNavigationBar: BottomNavigationWidget(onTap),
    );
  }
}
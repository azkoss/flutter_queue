//
// Created by ckckck on 2018/9/25.
//
import 'package:flutter_queue/generated/KColorConstant.dart';
import 'package:flutter_queue/splash_page.dart';
import 'package:flutter_queue/view/login/login.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MultiProvider(
      providers: KColorConstant.getProviders(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false, //取出debug
        theme: ThemeData(          // Add the 3 lines from here...
          primaryColor: Colors.orange,
          platform: TargetPlatform.iOS,//右滑返回
        ),
        title: 'Flutter Tutorial',
        home: SplashPage(),
      ),
    ),
  );
}

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

//git仓库里面网络端端请求
class MyNetUtil {
  BaseOptions baseOptions = BaseOptions(
    method:POST,
    connectTimeout:50000,
    contentType: ContentType('application', 'json', charset: 'utf-8'),
    receiveTimeout: 50000,
    baseUrl: "http://114.116.42.235:8088/queue/",
    followRedirects: true,
  );
  static Map<String, dynamic> smap = new Map();
  static const String GET = "get";
  static const String POST = "post";
  static const String PUT = "put";
  static const String GETSTRING = "gets";
  static const String POSTSTRING = "posts";

  // 工厂模式
  factory MyNetUtil() => _getInstance();

  static MyNetUtil get instance => _getInstance();
  static MyNetUtil _instance;

  MyNetUtil._internal() {
    // 初始化
  }

  static MyNetUtil _getInstance() {
    if (_instance == null) {
      _instance = new MyNetUtil._internal();
    }
    return _instance;
  }

  /*Future<String> getToken() async {
    */ /*StudentSqlite bookSqlite = new StudentSqlite();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();*/ /*
    String _id = sharedPreferences.getString("id");
    if (_id != null && bookSqlite != null) {
      await bookSqlite.openSqlite();
      return await bookSqlite.getstudent(_id).then((loginStudent) {
        if (loginStudent != null) {
          return loginStudent.token;
        } else {
          return "";
        }
      });
    } else {
      return "";
    }
  }*/

  //TODO 网络请求
  void getData(String url, Function callBack,
      {Map<String, dynamic> headers,
      Map<String, dynamic> params,
      Function errorCallBack}) async {
    baseOptions.method=GET;
    if(headers!=null&&headers.isNotEmpty) {
      smap.addAll(headers);
      baseOptions.headers = smap;
    }
    _request(url, callBack,
        method: GET, params: params, errorCallBack: errorCallBack);

//这里去获取本地token如果有token就添加。没有就不添加。
/*getToken().then((value) {
      if (value != null && value != "") {
        smap["Authorization"] = value;
      }
      smap.addAll(headers);
      baseOptions.headers = smap;
      _request(url, callBack,
          method: GET, params: params, errorCallBack: errorCallBack);
    });*/
  }

//TODO 网络请求
  void postData(String url, Function callBack,
      {Map<String, String> headers,
      Map<String, String> params,
      Function errorCallBack}) async {
    baseOptions.method=POST;
    if(headers!=null&&headers.isNotEmpty) {
      smap.addAll(headers);
      baseOptions.headers = smap;
    }
    _request(url, callBack,
        method: POST, params: params, errorCallBack: errorCallBack);

    /*getToken().then((value) {
      if (value != null && value != "") {
        smap["Authorization"] = value;
      }
      smap.addAll(headers);
      baseOptions.headers = smap;
      _request(url, callBack,
          method: POST, params: params, errorCallBack: errorCallBack);
    });*/
  }

//TODO 网络请求
  void putData(String url, Function callBack,
      {Map<String, String> headers,
      Map<String, String> params,
      Function errorCallBack}) async {
    baseOptions.method=PUT;
    if(headers!=null&&headers.isNotEmpty) {
      smap.addAll(headers);
      baseOptions.headers = smap;
    }
    _request(url, callBack,
        method: PUT, params: params, errorCallBack: errorCallBack);
    /* getToken().then((value) {
      if (value != null && value != "") {
        smap["Authorization"] = value;
      }
      smap.addAll(headers);
      baseOptions.headers = smap;
      _request(url, callBack,
          method: PUT, params: params, errorCallBack: errorCallBack);
    });*/
  }

  void _request(String url, Function callBack,
      {String method,
      Map<String, dynamic> params,
      Function errorCallBack}) async {
    String errorMsg = "";
    Response response;
    try {
      //get请求
      if (method == GET) {
        response = await Dio(baseOptions)
            .get(getUrlParames(url, params))
            .then((responses) {
          if (responses.statusCode == 200) {
            print("Get "+responses.toString());
            Map<String, dynamic> map = json.decode(responses.toString());
            callBack(map);
          } else {
            errorMsg = "网络请求错误,状态码:" + responses.statusCode.toString();
            _handError(errorCallBack, errorMsg.toString());
          }
        }).catchError((onErro) {
          _handError(errorCallBack, onErro.toString());
        });
      } else if (method == POST) {
        //post请求
        if (params != null && params.isNotEmpty) {
          response =
              await Dio(baseOptions).post(url, data: params).then((responses) {
            print(response.toString());
            if (responses.statusCode == 200) {
              print("ssssss "+responses.toString());
              Map<String, dynamic> map = json.decode(responses.toString());
              print("zzzz "+map.toString());
              callBack(map);
            } else {
              _handError(errorCallBack, errorMsg.toString());
            }
          }).catchError((onErro) {
            _handError(errorCallBack, onErro.toString());
          });
        } else {
          response = await Dio(baseOptions).post(url).then((responsesend) {
            if (responsesend.statusCode == 200) {
              Map<String, dynamic> map = json.decode(responsesend.toString());
              //判断如果这里token过期那么再次调用登录接口将token获取到然后写到本地。并且再次调用自己
              print(responsesend.toString());
              callBack(map);
            } else {
              errorMsg = "网络请求错误,状态码:" + responsesend.statusCode.toString();
              _handError(errorCallBack, errorMsg);
            }
          }).whenComplete(() {
            if (params != null) {
              params.clear();
            }
          });
          ;
        }
      } else if (method == PUT) {
        if (params != null && params.isNotEmpty) {
          response =
              await Dio(baseOptions).put(url, data: params).then((responses) {
            if (responses.statusCode == 200) {
              Map<String, dynamic> map = json.decode(responses.toString());
              callBack(map);
            } else {
              _handError(errorCallBack, errorMsg.toString());
            }
          }).catchError((onErro) {
            _handError(errorCallBack, onErro.toString());
          });
        }
      }
    } catch (exception) {
      print(exception.toString());
      _handError(errorCallBack, exception.toString());
    } finally {}
  }

//处理异常
  static void _handError(Function errorCallback, String errorMsg) {
    if (errorCallback != null) {
      errorCallback(errorMsg);
    }
  }

  static String getUrlParames(url, params) {
    if (params != null && params.isNotEmpty) {
      StringBuffer sb = new StringBuffer("?");
      params.forEach((key, value) {
        sb.write("$key" + "=" + "$value" + "&");
      });
      String paramStr = sb.toString();
      paramStr = paramStr.substring(0, paramStr.length - 1);
      url += paramStr;
      print("urlend=" + url);
    } else {
      url += "?";
    }
    return url;
  }
}

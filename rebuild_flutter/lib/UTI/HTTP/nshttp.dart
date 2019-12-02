
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rebuild_flutter/UTI/HTTP/nshttpresponse.dart';

/// restful - api - type
enum NSHTTPRequestType { GET, POST, PUT, DELETE }

/// 网络请求库处理
class NSHTTP {
  /*
   * 网络请求主要方法
   * 需要自己添加  header & parmas
   * header和params是可选参数
   * 超时时间30S
   * 目前支持GET POST PUT
   */
  static Future<NSHttpResponse> startRequest(
      NSHTTPRequestType requestType, 
      String url,
      {Map<String, dynamic> header, 
      Map<String, dynamic> params,
      String contentType,
      bool showAlertInfo = true
      }) async {

    NSHttpResponse response = NSHttpResponse();
    Dio manager = new Dio();
    //这里设置了代理-正式需要去掉 =================
    // bool isProxyChecked = true;
    // String proxy = '10.25.11.132:8984';
    // (manager.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    //     (client) {
    //   client.badCertificateCallback =
    //       (X509Certificate cert, String host, int port) {
    //     return isProxyChecked && Platform.isAndroid;
    //   };
    //   client.findProxy = (url) {
    //     return isProxyChecked ? 'PROXY $proxy' : 'DIRECT';
    //   };
    // };
    //这里设置了代理-正式需要去掉 =================
    try {
      switch (requestType) {
        case NSHTTPRequestType.GET:
          Options opt = Options(
              method: "get",
              headers: header,
              receiveTimeout: 30);
          var result = await manager.get(url, options: opt);
          return NSHTTP.progressResponse(result);
          break;
        case NSHTTPRequestType.POST:
          Options opt = Options(
              method: "post",
              headers: header,
              contentType: contentType,
              receiveTimeout: 30);
            
          var result = await manager.post(url, data: params, options: opt);
          return NSHTTP.progressResponse(result);
          break;
        case NSHTTPRequestType.PUT:
          Options opt = Options(
              method: "put",
              headers: header,
              contentType: contentType,
              receiveTimeout: 30);
          var result = await manager.put(url, data: params, options: opt);
          return NSHTTP.progressResponse(result);
          break;
        case NSHTTPRequestType.DELETE:
          Options opt = Options(
              method: "delete",
              headers: header,
              receiveTimeout: 30);
          var result = await manager.delete(url, data: params, options: opt);
          return NSHTTP.progressResponse(result);
          break;
        default:
          return response;
          break;
      }
    } on DioError catch (e) {
      if (showAlertInfo) {
        _alertError();
      }
      response = NSHttpResponse(type: e.type);
    } on Error {
      if (showAlertInfo) {
        _alertError();
      }
      response = NSHttpResponse(type: DioErrorType.DEFAULT);
    }
  }

  /// 数据处理
  static NSHttpResponse progressResponse(Response response) {
    NSHttpResponse result;
    try {
      Map<dynamic, dynamic> dic = response.data;
      result = NSHttpResponse(dicValue: dic);
    } on Exception {
      try {
        List<dynamic> arr = response.data;
        result = NSHttpResponse(arrValue: arr);
      } on Exception {
        result = NSHttpResponse(anyValue: response.data);
      } on Error {
        result = NSHttpResponse(anyValue: response.data);
      }
   } on Error {
      try {
        List<dynamic> arr = response.data;
        result = NSHttpResponse(arrValue: arr);
      } on Exception {
        result = NSHttpResponse(anyValue: response.data);
      } on Error {
        result = NSHttpResponse(anyValue: response.data);
      }
   }
  
    return result;
  }

  static void _alertError() {
    Fluttertoast.showToast(msg: "网络异常，请稍后再试", gravity: ToastGravity.CENTER);
  }
}

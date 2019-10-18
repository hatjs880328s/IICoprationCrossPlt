import 'package:dio/dio.dart';

/// restful - api - type
enum NSHTTPRequestType {
  GET,
  POST,
  PUT,
  DELETE
}

/// 网络请求库处理
class NSHTTP {

  /*
   * 网络请求主要方法
   * 需要自己添加  header & parmas
   * header和params是可选参数
   * 超时时间30S
   * 目前支持GET POST PUT
   */
  static Future<Response> startRequest(
    NSHTTPRequestType requestType, 
    String url, 
    [Map<String, dynamic> header, 
    Map<String, dynamic> params]) async {

    Dio manager = new Dio();
    try {
    switch (requestType) {
      case NSHTTPRequestType.GET: 
      Options opt = Options(
          method: "get",
          extra: params,
          headers: header,
          receiveTimeout: 30
        );
        return manager.get(url, options: opt); break;
      case NSHTTPRequestType.POST:
        Options opt = Options(
          method: "post",
          extra: params,
          headers: header,
          receiveTimeout: 30
        );
        return manager.post(url, options: opt); break;
      case NSHTTPRequestType.PUT:
        Options opt = Options(
          method: "put",
          extra: params,
          headers: header,
          receiveTimeout: 30
        );
        return manager.put(url, options: opt); break;
      default: return null; break;
    }
    } on Exception catch (e) {
      throw e;
    } on Error {
      return null;
    }
  } 
}
import 'package:dio/dio.dart';

/// 网络请求错误类
class NSHttpError {
  var code;

  var msg;

  /// 二级错误信息
  var lv2Msg;

  /// 二级错误码
  var lv2Code;

  DioErrorType errorType;

  NSHttpError({int code, String msg, DioErrorType type}) {
    this.code = code;
    this.msg = msg;
  }
}

/// 网络请求结果封装
class NSHttpResponse {

  /// dic value
  Map<dynamic, dynamic> dicValue;

  /// list value
  List<dynamic> arrayValue;

  /// str & any-object
  var anyValue;

  /// 网络请求错误对象
  NSHttpError errorInfo;

  /// 构造函数 [dart不适用方法的重载，使用的是可选参数]
  NSHttpResponse({
    int errcode, 
    String msg, 
    Map<dynamic, dynamic> dicValue, 
    List<dynamic> arrValue, 
    dynamic anyValue, 
    DioErrorType type}) {

    if (errcode != null) {
      errorInfo = NSHttpError(code: errcode, msg: msg, type: type);
    }
    if (dicValue != null) {
      this.dicValue = dicValue;
    }
    if (arrValue != null) {
      this.arrayValue = arrValue;
    }
    if (anyValue != null) {
      this.anyValue = anyValue;
    }
  }
}
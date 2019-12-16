import 'package:rebuild_flutter/DAL/api/apistruct.dart';
import 'package:rebuild_flutter/UTI/HTTP/nshttp.dart';
import 'package:rebuild_flutter/UTI/HTTP/nshttpresponse.dart';

class GitFileDAL {

  /// 获取某一个文件的map
  Future<Map> getUserInfo(String id) async {
    var url = APIStruct.getFile.replaceAll(":id", id);
    NSHttpResponse res = await NSHTTP.startRequest(
        NSHTTPRequestType.GET, url);
    if (res.dicValue == null) {
      return {};
    }
    return res.dicValue;
  }

  /// 获取最新文件夹下的所有文件
  Future<List> getallNewestFiles(String id) async {
    var url = APIStruct.getNewestsFile.replaceAll(":id", id);
    NSHttpResponse res = await NSHTTP.startRequest(
        NSHTTPRequestType.GET, url);
    if (res.arrayValue == null) {
      return [];
    }
    return res.arrayValue;
  }

  /// 更新file
  Future<bool> updateFile(Map<String, dynamic> params) async {
    var url = APIStruct.createFile;
    NSHttpResponse res = await NSHTTP.startRequest(NSHTTPRequestType.PUT, 
    url, params: params, contentType: "application/x-www-form-urlencoded");
    if (res.dicValue != null) {
      return res.dicValue['result'];
    } 
    return false;
  }

  /// 删除file
  Future<bool> deleteFile(String fileid) async {
    var url = APIStruct.getFile;
    NSHttpResponse res = await NSHTTP.startRequest(NSHTTPRequestType.DELETE, url);
    if (res.dicValue != null) {
      return res.dicValue['result'];
    } 
    return false;
  }

  /// 创建file
  Future<bool> createFile(Map<String, dynamic> params) async {
    var url = APIStruct.createFile;
    NSHttpResponse res = await NSHTTP.startRequest(NSHTTPRequestType.POST, 
    url, params: params, contentType: "application/x-www-form-urlencoded");
    if (res.dicValue != null) {
      return res.dicValue['result'];
    } 
    return false;
  }
}
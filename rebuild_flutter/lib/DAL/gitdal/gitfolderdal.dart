import 'package:rebuild_flutter/DAL/api/apistruct.dart';
import 'package:rebuild_flutter/UTI/HTTP/nshttp.dart';
import 'package:rebuild_flutter/UTI/HTTP/nshttpresponse.dart';

/// 文件夹 dal
class GitFolderDAL {

  /// 获取某一个文件夹的map
  Future<Map> getFolderInfo(String id) async {
    var url = APIStruct.getFolder.replaceAll(":id", id);
    NSHttpResponse res = await NSHTTP.startRequest(
        NSHTTPRequestType.GET, url);
    if (res.dicValue == null) {
      return {};
    }
    return res.dicValue;
  }

  /// 获取某个文件夹下的文件
  Future<List> getOneFolderFiles(String folderid) async {
    var url = APIStruct.getOneFoldersFiles.replaceAll(":id", folderid);
    NSHttpResponse res = await NSHTTP.startRequest(
        NSHTTPRequestType.GET, url);
    if (res.arrayValue == null) {
      return [];
    }
    return res.arrayValue;
  }

  /// 获取某个文件夹下的文件
  Future<Map> getOneCoperationFolderFiles(String folderid) async {
    var url = APIStruct.getCoperationFolder.replaceAll(":id", folderid);
    NSHttpResponse res = await NSHTTP.startRequest(
        NSHTTPRequestType.GET, url);
    if (res.dicValue == null) {
      return {};
    }
    return res.dicValue;
  }

  /// 获取当前用户的所有文件夹 - 需要区分普通文件夹&协同文件夹
  Future<List> getOneUserFolders(String userid, int type) async {
    var url = APIStruct.getOneUserFolders.replaceAll(":id", userid).replaceAll(":type", "$type");
    NSHttpResponse res = await NSHTTP.startRequest(
        NSHTTPRequestType.GET, url);
    if (res.arrayValue == null) {
      return [];
    }
    return res.arrayValue;
  }

  /// 创建文件夹
  Future<bool> createFolder(Map<String, dynamic> params) async {
    var url = APIStruct.createFolder;
    NSHttpResponse res = await NSHTTP.startRequest(NSHTTPRequestType.POST, 
    url, params: params, contentType: "application/x-www-form-urlencoded");
    if (res.dicValue != null) {
      return res.dicValue['result'];
    } 
    return false;
  }
}
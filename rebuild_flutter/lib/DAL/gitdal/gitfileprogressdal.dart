// /*
//  * GIT 文件操作的dal ✅
//  * 
//  * 1.文件创建(文件夹创建是创建一个文件包含在此文件夹下) ✅
//  * 
//  * 2.文件更新 ✅
//  * 
//  * 3.文件内容获取 ✅
//  * 
//  * 4.文件删除 ✅
//  */
// import 'dart:core';
// import 'package:dio/dio.dart';
// import 'package:rebuild_flutter/DAL/api/apistruct.dart';
// import 'package:rebuild_flutter/MODEL/Newfile/filegitcommitmodel.dart';
// import 'package:rebuild_flutter/MODEL/Newfile/filegitcommitsmallmodel.dart';
// import 'package:rebuild_flutter/UTI/HTTP/nshttp.dart';
// import 'package:rebuild_flutter/UTI/HTTP/nshttpextension.dart';
// import 'package:rebuild_flutter/UTI/HTTP/nshttpresponse.dart';

// class GitFileProgressDAL {
//   String headerContentType = "application/json";

//   /// 创建一个文件 path: 路径； fileContent: 文件内容（base64编码过后）; creatorName: 创建者姓名 ； creatorEmail: 创建者邮箱
//   Future<bool> createFile(String path, String fileContent, String creatorName,
//       String creatorEmail) async {
//     FileGitCommitSmallModel smallModel =
//         FileGitCommitSmallModel(creatorName, creatorEmail);
//     FileGitCommitModel model = FileGitCommitModel(
//         creatorName + "commit.", fileContent, smallModel, "");
//     String url = APIStruct.gitAPINormalURL + path;
//     Map<String, dynamic> headers = NSHTTPExtension().getNormalGitHeader();
//     headers["content-type"] = headerContentType;
//     NSHttpResponse res = await NSHTTP.startRequest(
//         NSHTTPRequestType.PUT, url, header: headers, params: model.toJson());
//     if (null == res.errorInfo) {
//       return true;
//     }
//     return false;
//   }

//   /// 更新一个文件 path: 路径； fileContent: 文件内容（base64编码过后）; creatorName: 更新者姓名 ； creatorEmail: 更新者邮箱 ; sha: 更新文件必要字段
//   Future<bool> updateFile(String path, String fileContent, String creatorName,
//       String creatorEmail, String sha) async {
//     FileGitCommitSmallModel smallModel =
//         FileGitCommitSmallModel(creatorName, creatorEmail);
//     FileGitCommitModel model = FileGitCommitModel(
//         creatorName + "update.", fileContent, smallModel, sha);
//     String url = APIStruct.gitAPINormalURL + path;
//     Map<String, dynamic> headers = NSHTTPExtension().getNormalGitHeader();
//     headers["content-type"] = headerContentType;
//     NSHttpResponse res = await NSHTTP.startRequest(
//         NSHTTPRequestType.PUT, url, header: headers, params: model.toJson());
//     if (null == res.errorInfo) {
//       return true;
//     }
//     return false;
//   }

//   /// 根据path，获取一个目录下的所有内容
//   Future<dynamic> getFileInfo(String path) async {
//     String url = APIStruct.gitAPINormalURL + path;
//     NSHttpResponse res = await NSHTTP.startRequest(
//         NSHTTPRequestType.GET, url, header: NSHTTPExtension().getNormalGitHeader());
//     return res.dicValue;
//   }

//   /// 根据path sha，删除一个文件
//   Future<bool> deleteOneFile(
//       String path, String sha, String creatorName, String creatorEmail) async {
//     FileGitCommitSmallModel smallModel =
//         FileGitCommitSmallModel(creatorName, creatorEmail);
//     FileGitCommitModel model =
//         FileGitCommitModel(creatorName + "update.", "", smallModel, sha);
//     String url = APIStruct.gitAPINormalURL + path;
//     Map<String, dynamic> headers = NSHTTPExtension().getNormalGitHeader();
//     headers["content-type"] = headerContentType;
//     Map<String, dynamic> params = model.toJson();
//     params.remove("content");
//     NSHttpResponse res = await NSHTTP.startRequest(
//         NSHTTPRequestType.DELETE, url, header: headers, params: params);
//     if (null == res.errorInfo) {
//       return true;
//     }
//     return false;
//   }
// }

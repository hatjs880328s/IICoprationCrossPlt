import 'package:rebuild_flutter/UTI/HTTP/nshttp.dart';
import 'package:dio/dio.dart';

class NewListDAL {
    Future<List<dynamic>> getUserFolders(String userid) async {
      Response res = await NSHTTP.startRequest(NSHTTPRequestType.GET, 'url');
    }
}
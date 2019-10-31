import 'package:fluttertoast/fluttertoast.dart';
import 'package:rebuild_flutter/DAL/Groups/nscoperationgroupdal.dart';
import 'package:rebuild_flutter/MODEL/Login/nsloginglobal.dart';
import 'package:uuid/uuid.dart';

class CoperationGroupBLL {
  NSCoperationGroupDAL dal = NSCoperationGroupDAL();

  /// 创建一个协同群组
  Future<bool> createGroup(
    String name
  ) async {
    String groupid = Uuid().v1();
    var userinfo = await NSLoginGlobal.getInstance().getUserInfo();
    return await this.dal.createGroup(name, groupid, userinfo.uid);
  }
}
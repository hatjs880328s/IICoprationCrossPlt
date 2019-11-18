import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rebuild_flutter/BLL/gitbll/gitfileprogressbll.dart';
import 'package:rebuild_flutter/MODEL/CoperationGroup/coperationgroupmodel.dart';
import 'package:rebuild_flutter/MODEL/Newfile/realgitfilemodel.dart';
import 'package:rebuild_flutter/USL/CoperationGroup/coperitiongroupcell.dart';
import 'package:rebuild_flutter/UTI/COMPONENT/IIAnimationColor/iianimationcolor.dart';
import 'package:rebuild_flutter/UTI/COMPONENT/NSActionSheet/nsactionfield.dart';

class CoperationGroup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CoperationGroupState();
  }
}

class CoperationGroupState extends State<CoperationGroup>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  List<CoperationGroupModel> list = [];

  @override
  void initState() {
    super.initState();
    this.getGroupinfo();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 1,
          title:
              Text('协作', style: TextStyle(color: Colors.black, fontSize: 20)),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  showCupertinoDialog(
                      context: context,
                      builder: (context) {
                        NSActionField alertinfo =
                            NSActionField("创建协同组", "请输入协同组名称", "创建");
                        alertinfo.actionOne = (groupname) {
                          this.createGroup(groupname);
                        };
                        return alertinfo;
                      });
                }),
          ],
        ),
        body: 
        Container(
          color: Colors.white,
          child: ListView.builder(
            itemCount: list.length == 0 ? 1 : list.length,
            itemBuilder: (context, i) {
              if (this.list.length == 0) {
                return Center(
                    child: LinearProgressIndicator(
                        backgroundColor: Colors.white,
                        valueColor: IIAnimationColor()));
              }
              return CoperitionGroupCell(list[i], () {});
            },
          ),
        ));
  }

  /// 创建协同组 - 然后请求最新数据
  Future<void> createGroup(String groupname) async {
    var infobll = GitFileProgressBLL();
    await infobll.createFolder(false, groupname);
    this.getGroupinfo();
  }

  /// 获取协同组信息
  Future<void> getGroupinfo() async {
    var filebll = GitFileProgressBLL();
    var listsInfo = await filebll.getOneUsersAllFolders(false);
    setState(() {
      this.list = listsInfo.dirs;
    });
  }

  @override
  bool get wantKeepAlive => true;
}

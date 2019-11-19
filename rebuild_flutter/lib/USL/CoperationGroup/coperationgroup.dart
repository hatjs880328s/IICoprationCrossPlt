import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rebuild_flutter/BLL/gitbll/gitfileprogressbll.dart';
import 'package:rebuild_flutter/BLL/gitbll/gituserprogressbll.dart';
import 'package:rebuild_flutter/MODEL/CMD/gitcmdmodel.dart';
import 'package:rebuild_flutter/MODEL/CoperationGroup/coperationgroupmodel.dart';
import 'package:rebuild_flutter/USL/CoperationGroup/coperationgroupnotificationcell.dart';
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

  List<GitCMDModel> cmdlists = [];

  String segmentkey = "0";

  @override
  void initState() {
    super.initState();
    this.getGroupinfo();
    this.getNotificationInfos();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          title:
              CupertinoSegmentedControl(
                borderColor: Colors.grey,
                selectedColor: Colors.grey,
                pressedColor: Colors.grey,
                children: {
                  "0": Padding(
                    padding: EdgeInsets.all(4), 
                    child: Text('  协作组  ', style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w400))),
                  "1": Padding(
                    padding: EdgeInsets.all(4), 
                    child: Text('消息', style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w400)))},
                onValueChanged: (keys) {
                  setState(() {
                    this.segmentkey = keys;
                  });
                },
              ),
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
        body: this.getBody(this.segmentkey));
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

  /// 获取指令消息
  Future<void> getNotificationInfos() async {
    var userbll = GitUserProgressBLL();
    this.cmdlists = await userbll.getOwnCMDs();
  }

  Widget getBody(String keys) {
    if (keys == "0") {
      return Container(
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
        );
    } else {
      return Container(
          color: Colors.white,
          child: ListView.builder(
            itemCount: cmdlists.length == 0 ? 1 : cmdlists.length,
            itemBuilder: (context, i) {
              if (this.cmdlists.length == 0) {
                return Center(
                    child: LinearProgressIndicator(
                        backgroundColor: Colors.white,
                        valueColor: IIAnimationColor()));
              }
              return CoperitionGroupNotificationCell(cmdlists[i]);
            },
          ),
        );
    }
  }

  @override
  bool get wantKeepAlive => true;
}

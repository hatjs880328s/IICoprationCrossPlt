import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rebuild_flutter/BLL/gitbll/gitfileprogressbll.dart';
import 'package:rebuild_flutter/BLL/gitbll/gituserprogressbll.dart';
import 'package:rebuild_flutter/MODEL/CMD/gitcmdmodel.dart';
import 'package:rebuild_flutter/MODEL/CMD/gitcmdshowmodel.dart';
import 'package:rebuild_flutter/MODEL/CoperationGroup/coperationgroupmodel.dart';
import 'package:rebuild_flutter/MODEL/Newfile/foldermodel.dart';
import 'package:rebuild_flutter/USL/CoperationGroup/coperationgroupnotificationcell.dart';
import 'package:rebuild_flutter/USL/CoperationGroup/coperitiongroupcell.dart';
import 'package:rebuild_flutter/UTI/COMPONENT/IIAnimationColor/iianimationcolor.dart';
import 'package:rebuild_flutter/UTI/COMPONENT/IIWaitAni/iiwaitani.dart';
import 'package:rebuild_flutter/UTI/COMPONENT/NSActionSheet/nsactionfield.dart';

class CoperationGroup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CoperationGroupState();
  }
}

class CoperationGroupState extends State<CoperationGroup>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {

  List<FolderModel> list = [];

  List<GitCMDShowModel> cmdlists = [];

  String segmentkey = "0";

  @override
  void initState() {
    super.initState();
    this.getGroupinfo(true);
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
                    child: Text('  协作组  ', style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w500))),
                  "1": Padding(
                    padding: EdgeInsets.all(4), 
                    child: Text('消息', style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w500)))},
                onValueChanged: (keys) {
                  setState(() {
                    this.segmentkey = keys;
                  });
                },
              ),
          actions: <Widget>[
            IconButton(
                icon: Image(image: AssetImage('images/coperation_addnew_group.png'),width: 25, height: 25),
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
    this.getGroupinfo(false);
  }

  /// 获取协同组信息
  Future<void> getGroupinfo(bool havehud) async {
    if (havehud) {
      IIWaitAni.showWait('');
    }
    var filebll = GitFileProgressBLL();
    var listsInfo = await filebll.getOneUsersAllFolders(false);
    IIWaitAni.hideWait();
    setState(() {
      this.list = listsInfo;
    });
  }

  /// 获取指令消息
  Future<void> getNotificationInfos() async {
    var userbll = GitUserProgressBLL();
    this.cmdlists = await userbll.getOwnCMDs();
  }

  Widget getBody(String keys) {
    if (keys == "0") {
      return RefreshIndicator(
        child: Container(
          color: Colors.white,
          child: ListView.builder(
            itemCount: list.length == 0 ? 1 : list.length,
            itemBuilder: (context, i) {
              if (this.list.length == 0) {
                return Center();
              }
              return CoperitionGroupCell(list[i]);
            },
          ),
        ),
        onRefresh: this._loaddata,
      );
    } else {
      return RefreshIndicator(
        child: Container(
          color: Colors.white,
          child: ListView.builder(
            itemCount: cmdlists.length == 0 ? 1 : cmdlists.length,
            itemBuilder: (context, i) {
              if (this.cmdlists.length == 0) {
                return Center();
              }
              return CoperitionGroupNotificationCell(cmdlists[i], cmdlists);
            },
          ),
        ),
        onRefresh: this._loaddata,
      );
    }
  }

  Future<void> _loaddata() async {
    if (this.segmentkey == "0") {
      await this.getGroupinfo(false);
    } else {
      await this.getNotificationInfos();
    }
  }

  @override
  bool get wantKeepAlive => true;
}

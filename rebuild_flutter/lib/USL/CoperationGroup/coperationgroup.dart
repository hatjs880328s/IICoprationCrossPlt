import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rebuild_flutter/BLL/CoperationGroupBLL/coperationgroupbll.dart';
import 'package:rebuild_flutter/MODEL/Newfile/foldermodel.dart';
import 'package:rebuild_flutter/USL/CoperationGroup/coperitiongroupcell.dart';
import 'package:rebuild_flutter/USL/FolderPage/folderpagecell.dart';
import 'package:rebuild_flutter/UTI/COMPONENT/IIAnimationColor/iianimationcolor.dart';
import 'package:rebuild_flutter/UTI/COMPONENT/NSActionSheet/nsactionfield.dart';
import 'package:rebuild_flutter/UTI/NSNotificationCenter/nsnotificationcenter.dart';

class CoperationGroup extends StatefulWidget {
  @override 
  State<StatefulWidget> createState() { return CoperationGroupState();}
}

class CoperationGroupState extends State<CoperationGroup> with AutomaticKeepAliveClientMixin, TickerProviderStateMixin{

  List<FolderModel> list = [];

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
        elevation: 1,
        title: Text('协作', style: TextStyle(color: Colors.black, fontSize: 20)),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add), onPressed: () {
            showCupertinoDialog(
              context: context,
              builder: (context) {
                NSActionField alertinfo = NSActionField("创建协同组", "请输入协同组名称", "创建");
                alertinfo.actionOne = (groupname) {
                  this.createGroup(groupname);
                };
                return alertinfo;
              }
            );
          }),
        ],
      ),
      body: Container(
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
            return CoperitionGroupCell(list[i].getTitleInfo(),
                list[i].getCreateTime(), () {
                });
          },
        ),
      )
    );
  }

  /// 创建协同组 - 然后请求最新数据
  Future<void> createGroup(String groupname) async {
    CoperationGroupBLL bll = CoperationGroupBLL();
    await bll.createGroup(groupname);
    this.getGroupinfo();
  }

  /// 获取协同组信息
  Future<void> getGroupinfo() async {
    CoperationGroupBLL bll = CoperationGroupBLL();
    List<FolderModel> list = await bll.getallGroups();
    setState(() {
      this.list = list;
    });
  }

  @override
  bool get wantKeepAlive => true;
}
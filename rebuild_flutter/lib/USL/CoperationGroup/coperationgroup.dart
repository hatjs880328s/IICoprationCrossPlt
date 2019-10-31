import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rebuild_flutter/BLL/CoperationGroupBLL/coperationgroupbll.dart';
import 'package:rebuild_flutter/UTI/COMPONENT/NSActionSheet/nsactionfield.dart';
import 'package:rebuild_flutter/UTI/NSNotificationCenter/nsnotificationcenter.dart';

class CoperationGroup extends StatefulWidget {
  @override 
  State<StatefulWidget> createState() { return CoperationGroupState();}
}

class CoperationGroupState extends State<CoperationGroup> {

  NSNormalNotificationObserver observer = NSNormalNotificationObserver();

  @override
  void initState() {
    super.initState();
    NSNotificationCenter.getInstance().addOneItem2SomeTable(observer, this.observer.notificationKey);
    this.observer.executeAction = (Map<String, dynamic> map) {

    };
  }

  @override 
  Widget build(BuildContext context) {
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
      )
    );
  }

  void createGroup(String groupname) {
    CoperationGroupBLL bll = CoperationGroupBLL();
    bll.createGroup(groupname);
  }

  /// 获取协同组信息
  void getGroupinfo() {

  }
}
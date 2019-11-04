import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rebuild_flutter/BLL/CoperationGroupBLL/coperationgroupbll.dart';
import 'package:rebuild_flutter/MODEL/Newfile/foldermodel.dart';
import 'package:rebuild_flutter/USL/CoperationGroup/coperitiongroupcell.dart';
import 'package:rebuild_flutter/UTI/COMPONENT/IIAnimationColor/iianimationcolor.dart';
import 'package:rebuild_flutter/UTI/COMPONENT/NSActionSheet/nsactionfield.dart';

class CoperationFileList extends StatefulWidget {
  @override 
  State<StatefulWidget> createState() {
    return CoperationFileListState();
  }

  CoperationFileList(String coperid) {
    this.coperid = coperid;
  }

  String coperid;
}

class CoperationFileListState extends State<CoperationFileList> {

  List<String> list = [];

  @override
  void initState() {
    super.initState();
    this.getGroupinfo();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text('协作', style: TextStyle(color: Colors.black, fontSize: 20)),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add), onPressed: () {
            
          }),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, i) {
            if (this.list.length == 0) {
              return Center(
                  child: LinearProgressIndicator(
                      backgroundColor: Colors.white,
                      valueColor: IIAnimationColor()));
            }
            return CoperitionGroupCell(list[i],
                list[i], () {
                });
          },
        ),
      )
    );
  }

  /// 获取协同组信息
  Future<void> getGroupinfo() async {
    CoperationGroupBLL bll = CoperationGroupBLL();
    List<String> list = await bll.getGroups(widget.coperid);
    setState(() {
      this.list = list;
    });
  }
}
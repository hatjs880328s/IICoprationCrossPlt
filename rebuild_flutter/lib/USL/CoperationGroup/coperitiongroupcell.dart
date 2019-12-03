import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rebuild_flutter/BLL/AppBll/nsnormalconfig.dart';
import 'package:rebuild_flutter/MODEL/CoperationGroup/coperationgroupmodel.dart';
import 'package:rebuild_flutter/MODEL/Newfile/foldermodel.dart';
import 'package:rebuild_flutter/USL/CoperationGroup/coperationfilelist.dart';

class CoperitionGroupCell extends StatefulWidget {
  FolderModel file;

  CoperitionGroupCell(FolderModel file) {
    this.file = file;
  }

  @override
  State<StatefulWidget> createState() {
    return CoperitionGroupCellState();
  }
}

class CoperitionGroupCellState extends State<CoperitionGroupCell> {
  String creatorInfo = "";

  @override
  void initState() {
    super.initState();
    this.creator();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        this.gopage(this.widget.file.folderid, context);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 4),
              child: Row(
                children: <Widget>[
                  Image(
                      height: 35,
                      width: 35,
                      image: AssetImage("images/main_tab_group.png")),
                  Container(
                    padding: EdgeInsets.only(left: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(this.widget.file.name,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontFamily: NSNormalConfig.fontFamily)),
                        ),
                        // Container(
                        //   padding: EdgeInsets.only(top: 8),
                        //   child: Text("文件数目: ${this.widget.file}",
                        //       style: TextStyle(
                        //           fontSize: 14,
                        //           color: Colors.grey,
                        //           fontFamily: NSNormalConfig.fontFamily)),
                        // ),
                        Container(
                          padding: EdgeInsets.only(top: 8),
                          child: Text("群拥有者: $creatorInfo",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  fontFamily: NSNormalConfig.fontFamily)),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 8),
                          child: Text(this.widget.file.getCreateTime(),
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  fontFamily: NSNormalConfig.fontFamily)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(height: 1, color: Colors.black12, endIndent: 0),
          ],
        ),
      ),
    );
  }

  void gopage(String coperid, BuildContext context) {
    CoperationFileList widget =
        CoperationFileList(coperid, this.widget.file.users);
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return widget;
    }));
  }

  /// 创建者信息
  void creator() async {
    bool isself = await this.widget.file.isSelfCreate();
    setState(() {
      if (isself) {
        this.creatorInfo = "自己";
      } else {
        this.creatorInfo = "其他人";
      }
    });
  }
}

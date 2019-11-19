import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rebuild_flutter/BLL/AppBll/nsnormalconfig.dart';
import 'package:rebuild_flutter/MODEL/CMD/gitcmdmodel.dart';
import 'package:rebuild_flutter/USL/CoperationGroup/coperationfilelist.dart';

class CoperitionGroupNotificationCell extends StatelessWidget {
  
  GitCMDModel file;

  CoperitionGroupNotificationCell(GitCMDModel file) {
    this.file = file;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //this.gopage(this.file.name, context);
      },
      child: Container(
        height: 125,
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
                      image: AssetImage("images/coperation_folder_invitepeople.png")),
                  Container(
                    padding: EdgeInsets.only(left: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text("邀请人: ${this.file.sender.nickname}",
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black,
                                  fontFamily: NSNormalConfig.fontFamily)),
                        ),                      
                        Container(
                          padding: EdgeInsets.only(top: 8),
                          child: Text("目标群组: this.file.group.name",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  fontFamily: NSNormalConfig.fontFamily)),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 8),
                          child: Text("..",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  fontFamily: NSNormalConfig.fontFamily)),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 8),
                          child: Text("..",
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
    CoperationFileList widget = CoperationFileList(coperid);
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return widget;
    }));
  }
}

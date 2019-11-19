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
    return Container(
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.fromLTRB(5, 8, 0, 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black26, width: 0.5),
        borderRadius: BorderRadius.circular(4),
        boxShadow: [BoxShadow(color: Colors.grey, spreadRadius: 0.5, blurRadius: 2)]
      ),
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
                  child: Text("邀请人员: ${this.file.sender.nickname}",
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                          fontFamily: NSNormalConfig.fontFamily)),
                ),
                Container(
                  padding: EdgeInsets.only(top: 8),
                  child: Text("群组名称: ${this.file.group.name}",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontFamily: NSNormalConfig.fontFamily)),
                ),
                Container(
                  padding: EdgeInsets.only(top: 8),
                  child: Text("邀请时间: ${this.file.getTime()}",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontFamily: NSNormalConfig.fontFamily)),
                ),
                Container(
                    padding: EdgeInsets.only(top: 8),
                    child: Row(
                      children: <Widget>[
                        GestureDetector(
                          child: Container(
                            alignment: Alignment.center,
                            width: 55,
                            height: 30,
                            child: Text('同意',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white)),
                            decoration: BoxDecoration(
                                color: NSNormalConfig.themeColor,
                                border:
                                    Border.all(color: Colors.grey, width: 0.5),
                                borderRadius: BorderRadius.circular(3)),
                          ),
                          onTap: () {},
                        ),
                        SizedBox(width: 40),
                        GestureDetector(
                          child: Container(
                            alignment: Alignment.center,
                            width: 55,
                            height: 30,
                            child: Text('拒绝',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black87)),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 0.5),
                                borderRadius: BorderRadius.circular(3)),
                          ),
                          onTap: () {},
                        )
                      ],
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void gopage(String coperid, BuildContext context) {
    CoperationFileList widget = CoperationFileList(coperid);
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return widget;
    }));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rebuild_flutter/BLL/AppBll/nsnormalconfig.dart';
import 'package:rebuild_flutter/BLL/gitbll/gitcmdprogressbll.dart';
import 'package:rebuild_flutter/MODEL/CMD/gitcmdmodel.dart';
import 'package:rebuild_flutter/USL/CoperationGroup/coperationfilelist.dart';

/// 消息cell
class CoperitionGroupNotificationCell extends StatelessWidget {

  GitCMDModel file;

  List<GitCMDModel> allcmd;

  CoperitionGroupNotificationCell(GitCMDModel file, List<GitCMDModel> allcmd) {
    this.file = file;
    this.allcmd = allcmd;
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
        boxShadow: [BoxShadow(color: Colors.grey, spreadRadius: 0.1, blurRadius: 1, offset: Offset(0.1, 0.7))]
      ),
      child: Row(
        children: <Widget>[
          Image(
              height: 30,
              width: 30,
              image: AssetImage("images/coperation_folder_invitepeople.png")),
          Container(
            padding: EdgeInsets.only(left: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text("邀请人员: ${this.file.sender.nickname}",
                      style: TextStyle(
                          fontSize: 16,
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
                          onTap: () {
                            this.agreeInvite(true);
                          },
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
                          onTap: () {
                            this.agreeInvite(false);
                          },
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

  /// 拒绝或者同意
  Future<void> agreeInvite(bool agree) async {
    var bll = GitCMDProgressBLL();
    await bll.progressInviteCMD(agree, this.file, this.allcmd);
  }
}

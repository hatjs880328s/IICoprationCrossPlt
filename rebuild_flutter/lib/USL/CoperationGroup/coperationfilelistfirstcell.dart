import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rebuild_flutter/MODEL/CoperationGroup/coperationgroupmodel.dart';
import 'package:rebuild_flutter/USL/CreateFile/createCoperationFile.dart';
import 'package:rebuild_flutter/USL/InvitePeople/invitepeople.dart';

/// 协同组顶部漂亮cell
class CoperationFileListFirstCell extends StatelessWidget {

  String coperationName;

  CoperationGroupModel oldGroupInfoModel;

  CoperationFileListFirstCell(String coperationGroupname, CoperationGroupModel oldGroupInfoModel) {
    this.coperationName = coperationGroupname;
    this.oldGroupInfoModel = oldGroupInfoModel;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 243,
        //color: Colors.white,
        child: Stack(
          children: <Widget>[
            Positioned(
              child: IconButton(
                icon: Image(image: AssetImage('images/app_back.png'), width: 22, height: 35),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Positioned(
                left: 8,
                top: 100,
                right: 8,
                height: 130,
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      border: Border.all(width: 0.5, color: Colors.grey),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 1.0),
                            blurRadius: 1.0,
                            spreadRadius: 0.3)
                      ],
                    ),
                    padding: EdgeInsets.only(top: 50),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                            left: 40,
                            top: 10,
                            child: GestureDetector(
                                child: Column(
                                  children: <Widget>[
                                    Image(image: AssetImage('images/coperation_folder_invitepeople.png'), height: 22, width: 22),
                                    Text('邀请', style: TextStyle(fontSize: 15)),
                                    Text('加入',
                                        style: TextStyle(
                                            fontSize: 13, color: Colors.grey)),
                                  ],
                                ),
                                onTap: () {
                                  this.invitePeople(context);
                                })),
                        Positioned(
                            width: 60,
                            left: (MediaQuery.of(context).size.width - 16) / 2 -
                                30,
                            top: 10,
                            child: GestureDetector(
                              child: Column(
                                children: <Widget>[
                                  Image(image: AssetImage('images/coperation_detail_share.png'), height: 22, width: 22),
                                  Text('分享', style: TextStyle(fontSize: 15)),
                                  Text('此群组',
                                      style: TextStyle(
                                          fontSize: 13, color: Colors.grey)),
                                ],
                              ),
                              onTap: () {
                                print("点击分享");
                              },
                            )),
                        Positioned(
                            right: 40,
                            top: 10,
                            child: GestureDetector(
                              child: Column(
                                children: <Widget>[
                                  Image(image: AssetImage('images/coperation_detail_edit.png'), height: 22, width: 22),
                                  Text('创建', style: TextStyle(fontSize: 15)),
                                  Text('新文章',
                                      style: TextStyle(
                                          fontSize: 13, color: Colors.grey)),
                                ],
                              ),
                              onTap: () {
                                //print("点击收藏");
                                this.createNewCoperationFile(context);
                              },
                            ))
                      ],
                    ))),
            //头像
            Positioned(
                left: 40,
                top: 50,
                width: 100,
                height: 100,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    border: Border.all(
                        width: 1, color: Colors.grey, style: BorderStyle.solid),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                      image: AssetImage('images/cop_128.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                )),
            //协同组名称
            Positioned(
                top: 110,
                right: 40,
                child: Text("组名:  ${this.oldGroupInfoModel.name.substring(0, 12)}",
                    textAlign: TextAlign.end,
                    style:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.w500)))
          ],
        ));
  }

  /// 创建一个新的协同组文章
  void createNewCoperationFile(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return CreateCoperationFile(this.oldGroupInfoModel);
    }));

  }

  void invitePeople(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return InvitePeople(this.oldGroupInfoModel);
    }));
  }

}

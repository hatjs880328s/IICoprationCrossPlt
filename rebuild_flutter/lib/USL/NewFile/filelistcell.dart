import 'package:flutter/cupertino.dart';
import 'package:rebuild_flutter/BLL/AppBll/nsnormalconfig.dart';
import 'package:flutter/material.dart';
import 'package:rebuild_flutter/MODEL/CoperationGroup/coperationgroupmodel.dart';
import 'package:rebuild_flutter/MODEL/Newfile/realgitfilemodel.dart';
import 'package:rebuild_flutter/USL/CreateFile/updateFile.dart';
import 'package:rebuild_flutter/USL/MoveArticlePage/movearticlepage.dart';

class FileListCell extends StatelessWidget {
  CoperationGroupModel groupModel;

  RealGitFileModel itemmodel;

  dynamic deleteAction;

  FileListCell(CoperationGroupModel groupItem, RealGitFileModel itemmodel,
      dynamic deleteAction) {
    this.groupModel = groupItem;
    this.itemmodel = itemmodel;
    this.deleteAction = deleteAction;
  }

  /// vw create
  Widget build(BuildContext context) {
    return Dismissible(
      child: Container(
        padding: EdgeInsets.fromLTRB(16, 8, 0, 8),
        child: GestureDetector(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: Text(this.itemmodel.name,
                    style: TextStyle(
                        fontSize: 16, fontFamily: NSNormalConfig.fontFamily)),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: Text(nonEnterSubtitle(),
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: NSNormalConfig.fontFamily,
                        color: Colors.grey)),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: Text(this.itemmodel.getCreateTime(),
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        fontFamily: NSNormalConfig.fontFamily)),
              ),
              Divider(height: 1, color: Colors.black12, endIndent: 0),
            ],
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return UpdateFile(this.groupModel, this.itemmodel, true);
            }));
          },
        ),
      ),
      key: Key('${itemmodel.fileid}'),
      onDismissed: (direction) {
        this.deleteAction(this.itemmodel);
        jump2OtherPage(context, this.itemmodel);
      },
      background: Text('', style: TextStyle(fontSize: 16)),
      secondaryBackground: Container(
          color: Colors.grey,
          child: ListTile(
            trailing: Icon(Icons.move_to_inbox),
            subtitle: Text('点击确定将跳转选择文件夹页面', style: TextStyle(fontSize: 15, height: 2)),
            title: Text('移动', style: TextStyle(fontSize: 18)),
          )),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          return false;
        }
        var isDismiss = await this._createDialog(context);
        if (isDismiss == null) {
          isDismiss = false;
        }
        return isDismiss;
      },
    );
  }

  /// 去掉结尾的换行
  String nonEnterSubtitle() {
    var result = this.itemmodel.description.replaceAll("\n", "");
    return result;
  }

  void jump2OtherPage(BuildContext context, RealGitFileModel originFile) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return MoveArticlePage(originFile);
    }));
  }

  /// 删除询问
  Future<bool> _createDialog(BuildContext context) async {
    var dialog = CupertinoAlertDialog(
      title: Text(
        '提醒',
        style: TextStyle(fontSize: 18, color: NSNormalConfig.themeColor),
      ),
      content: Text(
        '确定要移动此项目到其他文件夹?',
        style: TextStyle(fontSize: 15, height: 1.8),
      ),
      actions: <Widget>[
        CupertinoButton(
          child: Text('确定'),
          onPressed: () {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('确认'),
              duration: Duration(milliseconds: 400),
            ));
            Navigator.of(context).pop(true);
          },
        ),
        CupertinoButton(
          child: Text('取消'),
          onPressed: () {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('取消'),
              duration: Duration(milliseconds: 400),
            ));
            Navigator.of(context).pop(false);
          },
        ),
      ],
    );
    return showDialog<bool>(context: context, builder: (_) => dialog);
  }
}

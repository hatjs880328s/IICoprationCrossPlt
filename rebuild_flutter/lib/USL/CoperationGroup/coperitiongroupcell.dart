import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rebuild_flutter/BLL/AppBll/nsnormalconfig.dart';
import 'package:rebuild_flutter/USL/CoperationGroup/coperationfilelist.dart';

class CoperitionGroupCell extends StatelessWidget {
  String title = "";

  String time = "";

  dynamic action;

  CoperitionGroupCell(String title, String time, dynamic action) {
    this.time = time;
    this.title = title;
    this.action = action;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //action();
        this.gopage(this.title, context);
      },
      child: Container(
        height: 75,
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
                          child: Text(title,
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black,
                                  fontFamily: NSNormalConfig.fontFamily)),
                        ),
                        // Container(
                        //   padding: EdgeInsets.only(top: 8),
                        //   child: Text(time,
                        //       style: TextStyle(
                        //           fontSize: 14,
                        //           color: Colors.grey,
                        //           fontFamily: NSNormalConfig.fontFamily)),
                        // ),
                        // Container(
                        //   padding: EdgeInsets.only(top: 8),
                        //   child: Text("文件数目: 6",
                        //       style: TextStyle(
                        //           fontSize: 14,
                        //           color: Colors.grey,
                        //           fontFamily: NSNormalConfig.fontFamily)),
                        // ),
                        // Container(
                        //   padding: EdgeInsets.only(top: 8),
                        //   child: Text("成员人数: 3",
                        //       style: TextStyle(
                        //           fontSize: 14,
                        //           color: Colors.grey,
                        //           fontFamily: NSNormalConfig.fontFamily)),
                        // ),
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

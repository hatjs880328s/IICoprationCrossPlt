import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rebuild_flutter/BLL/gitbll/gituserprogressbll.dart';
import 'package:rebuild_flutter/MODEL/CoperationGroup/coperationgroupmodel.dart';
import 'package:rebuild_flutter/MODEL/Login/nsloginmodel.dart';

class InvitePeople extends StatefulWidget {
  State<InvitePeople> createState() {
    return InvitePeopleState();
  }

  InvitePeople(CoperationGroupModel model) {
    this.group = model;
  }

  CoperationGroupModel group;
}

/// 邀请用户
class InvitePeopleState extends State<InvitePeople> {
  List<NSLoginModel> users;

  List<NSLoginModel> results = [];

  TextEditingController con;

  @override
  void initState() {
    this.con = TextEditingController();
    this.getAllUserInfo();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text('邀请', style: TextStyle(fontSize: 20)),
        ),
        body: ListView(
          children: <Widget>[
            //搜索框
            Container(
                margin: EdgeInsets.all(8),
                constraints: BoxConstraints(maxHeight: 40),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.circular(3)),
                child: TextField(
                  controller: this.con,
                  onChanged: (txt) {
                    getDataWithName(txt);
                  },
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(8, 7, 0, 7),
                      hintText: '搜索人邮箱或者id',
                      suffixIcon: Icon(Icons.search),
                      border: InputBorder.none),
                )),
            //搜索结果列表
            Column(
              children: getWidgetWithResults(),
            )
          ],
        ));
  }

  /// 获取条件匹配信息
  void getDataWithName(String txt) async {
    if (this.users.length == 0) {
      Fluttertoast.showToast(msg: "请稍候再试");
      return;
    }
    List<NSLoginModel> result = [];
    for (NSLoginModel eachUser in this.users) {
      if (eachUser.nickname.contains(txt)) {
        result.add(eachUser);
      }
    }
    if (txt.isEmpty) {
      this.results = [];
    } else {
      this.results = result;
    }
    setState(() {
      //this.results = result;
    });
  }

  /// 获取所有人信息
  void getAllUserInfo() async {
    this.users = await GitUserProgressBLL().getALLUserInfo();
  }

  /// 根据结果创建widget数组
  List<Widget> getWidgetWithResults() {
    List<Widget> result = [];
    for (NSLoginModel eachuser in this.results) {
      var info = Container(
          padding: EdgeInsets.all(8),
          child: Stack(
            children: <Widget>[
              Positioned(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: eachuser.icon.contains("http") 
                                  ? Image.network(eachuser.icon).image 
                                  : Image(image: AssetImage('images/cop_128.png')).image,
                                  fit: BoxFit.cover)),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(eachuser.nickname),
                      ],
                    ),
                    SizedBox(height: 8),
                    Divider(
                      indent: 55,
                      color: Colors.black12,
                      height: 1,
                    )
                  ],
                ),
              ),
              Positioned(
                  right: 8,
                  child: GestureDetector(
                    child: Image(
                        image: AssetImage(
                            'images/coperation_folder_invitepeople.png'),
                        height: 25,
                        width: 25),
                    onTap: () {
                      this.inviteSomeOne(eachuser);
                    },
                  ))
            ],
          ));
      result.add(info);
    }
    return result;
  }

  void inviteSomeOne(NSLoginModel receiver) async {
    var result =
        await GitUserProgressBLL().inviteSomeOne2Group(receiver, widget.group);
    if (result) {
      Fluttertoast.showToast(msg: "邀请成功");
    } else {
      Fluttertoast.showToast(msg: "邀请失败,请稍候再试");
    }
  }
}

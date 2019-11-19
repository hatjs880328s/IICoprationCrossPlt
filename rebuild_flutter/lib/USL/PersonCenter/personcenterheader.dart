import 'package:flutter/material.dart';
import 'package:rebuild_flutter/MODEL/Login/nsloginmodel.dart';

class PersonCenterHeader extends StatelessWidget {
  NSLoginModel model;

  PersonCenterHeader(NSLoginModel userinfo) {
    this.model = userinfo;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        //配置
        Container(
          padding: EdgeInsets.fromLTRB(0, 10, 16, 0),
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.bottomRight,
          child: GestureDetector(
            child: Image(
                image: AssetImage("images/personcenter_setting.png"),
                height: 25,
                width: 25),
            onTap: () {},
          ),
        ),
        //个人信息
        Container(
            margin: EdgeInsets.fromLTRB(16, 5, 16, 5),
            child: Row(
              children: <Widget>[
                //头像
                Container(
                  width: 75,
                  height: 75,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    image: DecorationImage(
                        image: this.model == null ? Image(image: AssetImage("images/cop_128.png")).image : 
                        this.model.icon.contains("http") 
                        ? NetworkImage('${this.model.icon}')
                        : Image(image: AssetImage("images/cop_128.png")).image,
                        fit: BoxFit.cover),
                  ),
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(8, 0, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        //名字
                        Text(this.model == null ? "" : this.model.nickname,
                            style:
                                TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w600,)),
                        //用量
                        Container(
                            margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
                            padding: EdgeInsets.fromLTRB(0, 0, 100, 0),
                            width: MediaQuery.of(context).size.width - 130,
                            height: 5,
                            color: Colors.black12,
                            child: Container(
                              width: 50,
                              height: 5,
                              color: Colors.blue,
                            )),
                        //用量文字
                        Text("空间使用情况: 100M/10G",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 14, color: Colors.grey)),
                      ],
                    )),
              ],
            )),
        //会员与签到
        Container(
            height: 80,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, 0.0),
                      blurRadius: 8.0,
                      spreadRadius: 0.5)
                ]),
            margin: EdgeInsets.fromLTRB(16, 18, 16, 8),
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 15,
                  width: (MediaQuery.of(context).size.width - 32) / 2,
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image(image: AssetImage('images/personcenter_vip.png'), width: 20, height: 20),
                          SizedBox(width: 8),
                          Text(
                            '购买会员',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        '尊享更多会员特权',
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 15,
                  left: (MediaQuery.of(context).size.width - 32) / 2,
                  width: (MediaQuery.of(context).size.width - 32) / 2,
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image(image: AssetImage('images/main_tab_bookstore.png'), width: 20, height: 20),
                          SizedBox(width: 8),
                          Text(
                            '签到',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        '签到获取更多存储空间',
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Positioned(
                    left: (MediaQuery.of(context).size.width - 32) / 2 - 0.5,
                    top: 15,
                    bottom: 15,
                    width: 1,
                    child: Container(color: Colors.black12)),
              ],
            ))
      ],
    ));
  }
}

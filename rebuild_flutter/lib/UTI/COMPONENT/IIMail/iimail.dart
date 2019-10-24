import 'dart:math';

import 'package:flutter_email_sender/flutter_email_sender.dart';

/// 邮件发送
class IIMail {
  Future<String> sendMail(String mail) async {
    String i = this.randomStr();
    var emial = Email(
      body: "协同APP邀请您加入(请不要将验证码告诉任何人)，验证码：$i ",
      subject: "协同APP验证码",
      recipients: [mail],
      isHTML: false
    );
    try {
      await FlutterEmailSender.send(emial);
      return i;
    } on Exception catch (exe) {
      print(exe);
      return null;
    }
  }

  /// 生成随机数
  String randomStr() {
    String alphabet = 'qwertyuiopasdfghjklzxcvbnm0123456789';
    int strlenght = 4;
    String left = '';
    for (var i = 0; i < strlenght; i++) {
      left = left + alphabet[Random().nextInt(alphabet.length)]; 
    } 
    return left;
  }
}
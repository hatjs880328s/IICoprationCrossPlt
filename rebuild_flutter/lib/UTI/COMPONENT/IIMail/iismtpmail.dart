
import 'package:mailer2/mailer.dart';
import 'dart:math';
/*
 * 仅支持smtp协议的邮箱 - qq等
 */

class IISmtpMail {
  void sendMail(dynamic resultaction) {
    String i = this.randomStr();
    var options = new GmailSmtpOptions()
    ..username = 'hatjs880328@gmail.com'
    ..password = 'nimabiguge'; // Note: if you have Google's "app specific passwords" enabled,
                                        // you need to use one of those here.
                                        
  // How you use and store passwords is up to you. Beware of storing passwords in plain.

  // Create our email transport.
  var emailTransport = new SmtpTransport(options);

  // Create our mail/envelope.
  var envelope = new Envelope()
    ..from = '协同文档'
    ..recipients.add('451145552@qq.com')
    //..bccRecipients.add('hidden@recipient.com')
    ..subject = '【协同文档】邀请您'
    //..attachments.add(new Attachment(file: new File('path/to/file')))
    ..text = '..'
    ..html = '<h1>协同文档邀请你，请勿将邀请码透露给其他人</h1><p>邀请码为： $i</p>';

  // Email it.
  emailTransport.send(envelope)
    .then((envelope) {
      print('Email sent!');
      resultaction(i);
    })
    .catchError((e){
      print('Error occurred: $e');
      resultaction(null);
    });
  }

  /// 获取随机码
  String randomStr() {
    String alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    int strlenght = 4;
    String left = '';
    for (var i = 0; i < strlenght; i++) {
      left = left + alphabet[Random().nextInt(alphabet.length)]; 
    } 
    return left;
  }
}

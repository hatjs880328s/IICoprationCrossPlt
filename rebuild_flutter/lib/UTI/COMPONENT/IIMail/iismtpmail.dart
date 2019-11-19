
import 'package:mailer2/mailer.dart';
import 'dart:math';
/*
 * 仅支持smtp协议的邮箱 - qq等
 */

class IISmtpMail {
  void sendMail(String email, dynamic resultaction) {
    String i = this.randomStr();
    // var options = new GmailSmtpOptions()
    // ..username = 'hatjs880328@gmail.com'
    // ..password = 'ilpibwtkvdcxxdni';

  var options = SmtpOptions()
    ..hostName = 'smtp.qq.com'
    ..port = 465
    ..secured = true
    ..username = '451145552@qq.com'
    ..password = 'uvrhhaygfisqbgih';

  // Create our email transport.
  var emailTransport = new SmtpTransport(options);

  // Create our mail/envelope.
  var envelope = new Envelope()
    ..from = '451145552@qq.com'
    ..recipients.add(email)
    //..bccRecipients.add('hidden@recipient.com')
    ..subject = '[comporation-doc] invite u'
    //..attachments.add(new Attachment(file: new File('path/to/file')))
    ..text = 'comporation-doc'
    ..html = '<h1>[comporation-doc] invite u, do not tell the code 2 someothers.</h1><p>CODE： $i</p>';

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
    String alphabet = '0123456789';
    int strlenght = 4;
    String left = '';
    for (var i = 0; i < strlenght; i++) {
      left = left + alphabet[Random().nextInt(alphabet.length)]; 
    } 
    return left;
  }
}

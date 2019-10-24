import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rebuild_flutter/UTI/COMPONENT/NSShare/nsahresdk.dart';

class LoginPage extends StatefulWidget {
  @override 
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {

  NSShareSDK sdk = NSShareSDK();

  @override
  void initState() {
    sdk.sharesdkConfig();
    super.initState();
  }

  @override 
  Widget build(BuildContext context) {
    //super.build(context);
    return IconButton(icon: Icon(Icons.person_pin), onPressed: () {
      setState(() {
        this.sdk.showPlatMenu((Map maps) {
          print("halo,world");
        });
      });
    });
  }
}
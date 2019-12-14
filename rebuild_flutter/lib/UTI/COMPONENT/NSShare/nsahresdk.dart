import 'package:sharesdk_plugin/sharesdk_plugin.dart';

/// 平台类型
enum NSShareType {
  qq, wx, sina
}

/// 分享配置类
class NSShareSDK {

  /// 平台注册 - 需要再initstate里面调用在superinit之前
  void sharesdkConfig() {
    ShareSDKRegister reg = ShareSDKRegister();

    reg.setupWechat("wxd65286084621658c", "6c906766908b4ad7725db5c08c031aee", "https://hatjs880328s.github.io/apple-app-site-association/");
    reg.setupQQ("1109322686", "SMmtHCbX4eAzVXs0");
    reg.setupSinaWeibo("1238681065", "9daa170c7d83186847a85f825c611223", "https://hatjs880328s.github.io");

    SharesdkPlugin.regist(reg);
  }

  /// 第三方登陆信息获取平台信息获取
  void authPlatform(ShareSDKPlatform plt, dynamic result) {
    SharesdkPlugin.auth(plt, null, (SSDKResponseState state, Map user, SSDKError error) {
      if (error.code == 0) {
        result(user);
      } else {
        result(null);
      }
    });
  }

  /// 分享平台显示与回调
  void showPlatMenu(dynamic action) {
    String url = "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1541565611543&di=4615c8072e155090a2b833059f19ed5b&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201501%2F06%2F20150106003502_Ajcte.jpeg";
    SSDKMap params = SSDKMap()..setGeneral(
      "平台选择", 
      "选择使用的登陆平台", 
      null, 
      url, 
      url, 
      url, 
      url, 
      url, 
      url,
      url, 
      SSDKContentTypes.auto,
      );

      SharesdkPlugin.showMenu([ShareSDKPlatforms.qq], params, (SSDKResponseState state, ShareSDKPlatform platform, Map userData, Map contentEntity, SSDKError error) {
        if (error == null) {
          action(userData);
        } else {
          action(null);
        }
      });
  }

}
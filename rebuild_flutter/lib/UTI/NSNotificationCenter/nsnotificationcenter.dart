
/*
 * 通知中心
 * 
 * 1.有一个center类，管理所有的通知子类；
 *    a.拥有添加观察者、移除观察者、发送消息给观察者的方法
 *    b.每一类通知自定一个数组；此center类，可绑定多组  0bserver - observable 
 * 2.观察者设计
 *    a.拥有同一个父类，父类实现了一个接受center发送通知的方法[center调用每一个监听者的接受数据方法]
 *    b.观察者有一个释放函数；释放自己再center类中的引用[dispose方法]
 * 
 * How 2 use:
 *    a.发送通知方：通过
 *      NSNotificationCenter.getInstance().postNotification(NSNormalNotificationObserver().notificationKey, {});
 *    b.接受方：通过
 *      NSNormalNotificationObserver observer = NSNormalNotificationObserver();
 *      observer.executeAction = (Map<String, dynamic> mapInfo) {
 *        this.getSelfFolderList();
 *      };
 *      NSNotificationCenter.getInstance().addOneItem2SomeTable(observer, observer.notificationKey);
 *      observer.dispose();
 */

/// center
class NSNotificationCenter {

  static NSNotificationCenter shareInstance;

  static NSNotificationCenter getInstance() {
    if (shareInstance == null) {
      shareInstance = NSNotificationCenter();
    }
    return shareInstance;
  }

  /// 所有数据
  Map<String, List<NSNotificationObserverFather>> allObserverTab = {};

  /// 像某个监听table中添加一个监听者
  void addOneItem2SomeTable(NSNotificationObserverFather item, String table) {
    if (this.allObserverTab[table] == null) {
      // 还没有这个监听
      List<NSNotificationObserverFather> oneList = [item];
      this.allObserverTab[table] = oneList;
    } else {
      // 已经有这个监听
      this.allObserverTab[table].add(item);
    }
  }

  /// 根据talbe item 移除监听者
  void remove(NSNotificationObserverFather item, String table) {
    if (this.allObserverTab[table].length == 0) { return; }
    for (NSNotificationObserverFather eachItem in this.allObserverTab[table]) {
      if (item == eachItem) {
        this.allObserverTab[table].remove(item);
        return;
      }
    }
  }

  /// 发送通知
  void postNotification(String table, Map<String, dynamic> userInfo) {
    if (this.allObserverTab[table].length == 0) { return; }
    for (NSNotificationObserverFather eachItem in this.allObserverTab[table]) {
      eachItem.executeAction(userInfo);
    }
  }
}


/// observer - father - interface
abstract class NSNotificationObserverFather {

  /// 通知table-key
  String notificationKey;

  /// execute具体实现
  dynamic executeAction;

  /// 被调用方法
  void execute(Map<String, dynamic> maps);

  /// 释放自己的方法
  void dispose();

}

/// 一个正常实现 - 页面间数据传递
class NSNormalNotificationObserver implements NSNotificationObserverFather {

  @override
  String notificationKey = "NSNormalNotificationObserver";

  @override
  void dispose() {
    NSNotificationCenter.getInstance().remove(this, this.notificationKey);
  }

  @override
  void execute(Map<String, dynamic> maps) {
    executeAction(maps);
  }

  @override
  var executeAction;
  
}
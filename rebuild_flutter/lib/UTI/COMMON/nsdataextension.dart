

import 'dart:convert';

class NSDataExtension {
  /*
     * base64解码
     */
    String base64Decodes(String base64Str) {
      var result = base64Decode(base64Str);
      return utf8.decode(result);
    }
    
}
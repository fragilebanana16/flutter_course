import 'package:flutter_course/common/models/user.dart';
import 'package:flutter_course/common/services/http_util.dart';

class SignInRepo {
  static Future SignIn({UserProfile? param}) async {
    var rsp = await HttpUtil().post("/logIn", queryParameters: param?.toJson());
    print(rsp);
    return rsp; // return with code fromjson to entity?
  }
}

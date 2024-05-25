class UserProfile {
  String? userName;
  String? avatar;
  String? email;
  String? password;

  UserProfile({this.userName, this.avatar, this.email, this.password});

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
      userName: json["userName"],
      avatar: json["avatar"],
      email: json["email"],
      password: json["password"]);

  Map<String, dynamic> toJson() => {
        "userName": userName,
        "avatar": avatar,
        "email": email,
        "password": password,
      };
}

class LoginRsp {
  int? code;
  String? msg;
  UserProfile? userProfile;

  LoginRsp({this.code, this.msg, this.userProfile});
  factory LoginRsp.fromJson(Map<String, dynamic> json) => LoginRsp(
      code: json["code"],
      msg: json["msg"],
      userProfile: UserProfile.fromJson(json["userProfile"]));

  Map<String, dynamic> toJson() => {
        "code": code,
        "msg": msg,
        "userProfile": userProfile?.toJson(),
      };
}

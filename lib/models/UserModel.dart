class User {
  List<UserModel> items=[];

  User.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      json['items'].forEach((v) {
        items.add(new UserModel.fromJson(v));
      });
    }
  }
}

class UserModel {
  int ? UserId;
  String ? UserName;
  String ? Password;
  int ? Active;
  int ? LeId;
  int ? CustVenMId;


  UserModel({this.UserId,this.UserName,this.Password,this.Active,this.LeId,this.CustVenMId});
  UserModel.fromJson(Map<String, dynamic> json) {
    UserId = json['Userid'];
    UserName = json['UserName'];
    Password = json['Password'];
    Active = json['Active'];
    LeId = json['LeId'];
    CustVenMId = json['CustVenMId'];

  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Userid'] = this.UserId;
    data['UserName'] = this.UserName;
    data['Password'] = this.Password;
    data['Active'] = this.Active;
    data['LeId'] = this.LeId;
    data['CustVenMId'] = this.CustVenMId;
    return data;
  }

}




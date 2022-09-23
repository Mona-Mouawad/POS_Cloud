class ITEM_GROUP {
  List<ITEM_GROUP_Model> items=[];

  ITEM_GROUP.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      //  items = <ITEM_GROUP_Model>[];
      json['items'].forEach((v) {
        items.add(new ITEM_GROUP_Model.fromJson(v));
      });
    }
  }
}


class ITEM_GROUP_Model {
  int ? ITEM_GROUP_ID ;
  String ? GROUP_NAME;
  int ? LeId;
  String ? status ;
  int ? UserId;


  ITEM_GROUP_Model({this.ITEM_GROUP_ID,this.GROUP_NAME,this.LeId});

  ITEM_GROUP_Model.fromJson(Map<String, dynamic> json) {
    ITEM_GROUP_ID  = json['GroupItemId'];
    GROUP_NAME = json['GrpName'];
    status = json['status'];
    LeId = json['LeId'];
    UserId = json['UserId'];

  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['GroupItemId'] = this.ITEM_GROUP_ID ;
    data['GrpName'] = this.GROUP_NAME;
    data['UserId'] = this.UserId;
    data['LeId'] = this.LeId;
    return data;
  }

}




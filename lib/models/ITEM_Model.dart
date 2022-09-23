class ITEMS {
  List<ITEM_Model> items=[];

  ITEMS.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      //  items = <ITEM_Model>[];
      json['items'].forEach((v) {
        items.add(new ITEM_Model.fromJson(v));
      });
    }
  }
}

class ITEM_Model {
  dynamic ? ITEM_ID ;
  String ? ITEM_NAME;
  String ? BARCODE;
  dynamic ? SalesPrice1;
  dynamic ? SalesPrice2;
  dynamic ? SalesPrice3;
  String ? Nodes;
  dynamic ? GroupId;
  dynamic ? LeId;
  dynamic ? Quantity;
  String ? status  ;
  dynamic ? UserId;

  ITEM_Model({this.ITEM_ID ,this.ITEM_NAME,this.BARCODE,this.Quantity,this.SalesPrice1,this.SalesPrice2,
    this.SalesPrice3,this.Nodes,this.GroupId,this.LeId});

  ITEM_Model.fromJson(Map<String, dynamic> json) {
    ITEM_ID  = json['ItemId'];
    ITEM_NAME = json['ItemName'];
    BARCODE = json['Barcode'];
    SalesPrice1 = json['SalesPrice1'];
    SalesPrice2 = json['SalesPrice2'];
    SalesPrice3 = json['SalesPrice3'];
    Nodes = json['Nodes'];
    GroupId = json['GroupItemId'];
    LeId = json['LeId'];
    Quantity = json['Quantity'];
    status = json['status'];
    UserId = json['UserId'];

  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ItemId'] = this.ITEM_ID ;
    data['ItemName'] = this.ITEM_NAME;
    data['Barcode'] = this.BARCODE;
    data['SalesPrice1'] = this.SalesPrice1;
    data['SalesPrice2'] = this.SalesPrice2;
    data['SalesPrice3'] = this.SalesPrice3;
    data['Nodes'] = this.Nodes;
    data['GroupItemId'] = this.GroupId;
    data['UserId'] = this.UserId;
    data['status'] = this.status;
    data['Quantity'] = this.Quantity;
    data['LeId'] = this.LeId;
    return data;
  }

}




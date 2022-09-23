
class InvTransferIn {
  List<InvTransferIn_Model> items=[];

  InvTransferIn.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      json['items'].forEach((v) {
        items.add(new InvTransferIn_Model.fromJson(v));
      });
    }
  }
}

class InvTransferIn_Model {
  dynamic ? TransferId ;
  String ? DocDate;
  dynamic ? ItemId;
  dynamic ? StockId;
  dynamic ? Quantity ;
  dynamic ? LeId;
  dynamic ? PkId;
  dynamic ? GroupId;
  String ? status  ;

  InvTransferIn_Model({this.TransferId ,this.DocDate,this.ItemId,this.StockId,
    this.Quantity ,this.LeId});

  InvTransferIn_Model.fromJson(Map<String, dynamic> json) {
    TransferId  = json['TransferId'];
    DocDate = json['DocDate'];
    ItemId = json['ItemId'];
    StockId = json['Stockid'];
    Quantity  = json['Quantity'];
    LeId = json['LeId'];
    PkId = json['PkId'];
    GroupId = json['GroupId'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TransferId'] = this.TransferId ;
    data['DocDate'] = this.DocDate;
    data['ItemId'] = this.ItemId;
    data['Stockid'] = this.StockId;
    data['Quantity'] = this.Quantity ;
    data['status'] = "new";
    data['GroupId'] = this.GroupId;
    data['PkId'] = this.PkId;
    data['LeId'] = this.LeId;
    return data;
  }

}




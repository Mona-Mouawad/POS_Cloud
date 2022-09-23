//     Qr TEXT , status TEXT ,Quantity INTEGER , UserId INTEGER ,LeId INTEGER ,'
class InventoryCount {
  dynamic ? InventoryCountId ;
  dynamic ? InventoryCountDate;
  dynamic ? StockId;
  dynamic ? Barcode;
  dynamic ? Qr;
  dynamic ? Quantity;
  dynamic ? LeId;
  dynamic ? status  ;
  dynamic ? UserId;

  InventoryCount({this.InventoryCountId ,this.InventoryCountDate,this.StockId,this.Barcode,this.Qr,this.Quantity,
    this.LeId,this.UserId,this.status});

  InventoryCount.fromJson(Map<String, dynamic> json) {
    InventoryCountId  = json['InventoryCountId'];
    InventoryCountDate = json['InventoryCountDate'];
    StockId = json['StockId'];
    Barcode = json['Barcode'];
    Qr = json['Qr'];
    Quantity = json['Quantity'];
    LeId = json['LeId'];
    status = json['status'];
    UserId = json['UserId'];

  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['InventoryCountId'] = this.InventoryCountId ;
    data['InventoryCountDate'] = this.InventoryCountDate;
    data['StockId'] =this.StockId  ;
    data['Barcode'] = this.Barcode;
    data['Qr'] = this.Qr;
    data['Quantity'] = this.Quantity;
    data['LeId'] = this.LeId;
    data['UserId'] = this.UserId;
    // data['InvoicePk'] = null;
    return data;
  }

}




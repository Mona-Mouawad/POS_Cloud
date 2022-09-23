
class Stock_Details_Model {

  dynamic ? StockInOutId;
  dynamic ? ItemId;
  dynamic ? StockId;
  dynamic ? Quantity ;
  dynamic ? LeId;
  dynamic ? GroupId;
  String ? StockName ;
  String ? ItemName ;
  String ? BARCODE;
  dynamic ? SalesPrice1;
  dynamic ? SalesPrice2;
  dynamic ? SalesPrice3;


  Stock_Details_Model({this.ItemId,this.StockId,
    this.Quantity ,this.LeId,this.ItemName});

  Stock_Details_Model.fromJson(Map<String, dynamic> json) {
    ItemId = json['ItemId'];
    GroupId = json['GroupId'];
    StockId = json['StockId'];
    Quantity  = json['Quantity'];
    LeId = json['LeId'];
    StockInOutId = json['StockInOutId'];
    ItemName = json['ItemName'];
    StockName = json['StockName'];
    BARCODE = json['Barcode'];
    SalesPrice1 = json['SalesPrice1'];
    SalesPrice2 = json['SalesPrice2'];
    SalesPrice3 = json['SalesPrice3'];
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['GroupId'] = this.GroupId;
    data['ItemId'] = this.ItemId;
    data['StockId'] = this.StockId;
    data['Quantity'] = this.Quantity ;
    data['SalesPrice3'] = this.SalesPrice3;
    data['SalesPrice2'] = this.SalesPrice2;
    data['SalesPrice1'] = this.SalesPrice1;
    data['Barcode'] = this.BARCODE;
    data['StockName'] = this.StockName;
    data['ItemName'] = this.ItemName;
    data['StockInOutId'] = this.StockInOutId;
    data['LeId'] = this.LeId;
    return data;
  }

}






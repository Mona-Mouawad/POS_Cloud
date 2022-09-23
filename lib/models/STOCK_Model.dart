class STOCK {
  List<STOCK_Model> items=[];

  STOCK.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      json['items'].forEach((v) {
        items.add(new STOCK_Model.fromJson(v));
      });
    }
  }
}

class STOCK_Model {
  int ? STOCK_ID;
  String ? STOCK_NAME;
  int ? LeId;
  String ? status  ;


  STOCK_Model({this.STOCK_ID,this.STOCK_NAME,this.LeId});

  STOCK_Model.fromJson(Map<String, dynamic> json) {
    STOCK_ID = json['StockId'];
    STOCK_NAME = json['StockName'];
    LeId = json['LeId'];
    status = json['status'];

  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['StockId'] = this.STOCK_ID;
    data['StockName'] = this.STOCK_NAME;
    data['status'] = this.status;
    data['LeId'] = this.LeId;
    return data;
  }

}




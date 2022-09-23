

class InvoiceItemModel
 {
  int ? InvoiceItemId ;
  int ? ITEM_ID ;
  int ? GroupId ;
  String ? ITEM_NAME;
  String ? status;
  String ? Barcode;
  dynamic ? TOTAL;
  dynamic ? Price;
  dynamic ? UomId;
  double ? UomQuantity;
  dynamic ? UomName;
  dynamic ? StandConvFactor;
  dynamic ? Quantity;
  dynamic ? InvoiceId ;
  dynamic ? LeId ;
  dynamic ? UserId ;
  // dynamic ? T1_QUANTITY;
  // dynamic ? T2_QUANTITY;
  // dynamic ? T3_QUANTITY;
  dynamic ? SALES_PRICE1;
  dynamic ? SalesPrice2;
  dynamic ? SalesPrice3;
  dynamic ? QUANTITY_IN_STOCK;

//  bool ? check  ;

  InvoiceItemModel
({this.ITEM_ID ,this.ITEM_NAME,this.Quantity,this.SALES_PRICE1,this.TOTAL,this.QUANTITY_IN_STOCK,this.LeId,required this.GroupId,
    this.InvoiceId,this.SalesPrice2,this.Barcode,this.SalesPrice3,this.Price,this.UomId,this.UomQuantity,this.StandConvFactor
    , this.UomName
});

  InvoiceItemModel
.fromJson(Map<String, dynamic> json) {
    ITEM_ID  = json['ItemId'];
    InvoiceItemId  = json['InvoiceItemId'];
    GroupId  = json['GroupId'];
    ITEM_NAME = json['ItemName'];
    SALES_PRICE1 = json['SalesPrice1'];
    TOTAL = json['Total'];
    Quantity = json['Quantity'];
    QUANTITY_IN_STOCK = json['QuantityInStock'];
    InvoiceId = json['InvoiceId'];
    Barcode = json['Barcode'];
    LeId = json['LeId'];
    UserId = json['UserId'];
    SalesPrice3 = json['SalesPrice3'];
    SalesPrice2 = json['SalesPrice2'];
    Price = json['Price'];
    UomId = json['UomId'];
    UomQuantity = json['UomQuantity'];
    UomName = json['UomName'];
  //  check = json['check'];
    status = json['status'];
    StandConvFactor = json['StandConvFactor'];

  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
     data['ItemId'] = this.ITEM_ID ;
     data['Total'] = this.TOTAL;
     data['Price'] = this.Price;
     data['UserId'] = this.UserId;
     data['LeId'] = this.LeId;
     data['Barcode'] = this.Barcode;
     data['InvoiceId'] = this.InvoiceId;
     data['Quantity'] = this.Quantity;
    data['UomQuantity'] = this.UomQuantity;
    data['UomId'] = this.UomId;
    return data;
  }

}




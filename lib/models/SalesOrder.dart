
class SalesOrders {
  dynamic ? INVOICE_ID ;
  dynamic ? CUST_VEN_ID;
  dynamic ? INVOICE_DATE;
  dynamic ? PAYMENT_METHOD_ID;
  dynamic ? TREASURY_ID;
  dynamic ? STOCK_ID;
  dynamic ? PRICE ;
  dynamic ? Discount ;
  dynamic ? VALUE ;
  dynamic ? LE_ID;
  dynamic ? status  ;
  dynamic ?  Name  ;
  dynamic  ? INVOICE_TYPE  ;
  dynamic ? Paid ;
  dynamic ? Remaind ;
  dynamic ? UserId;
  dynamic ? InvoiceNo;

  SalesOrders({this.INVOICE_ID ,this.CUST_VEN_ID,this.INVOICE_DATE,this.PAYMENT_METHOD_ID,this.TREASURY_ID,this.STOCK_ID,
    this.PRICE ,this.LE_ID,this.Discount,this.VALUE,this.Name,this.UserId,this.status,this.InvoiceNo,this.Remaind,this.Paid,this.INVOICE_TYPE});


  SalesOrders.fromJson(Map<String, dynamic> json) {
    INVOICE_ID  = json['SalesOrderId'];
    CUST_VEN_ID = json['CustVenId'];
    INVOICE_DATE = json['SalesOrderDate'];
    PAYMENT_METHOD_ID = json['PaymentMethodId'];
    TREASURY_ID = json['TreasuryId'];
    STOCK_ID = json['StockId'];
    Discount = json['Discount'];
    PRICE  = json['Price'];
    VALUE  = json['Value'];
    LE_ID = json['LeId'];
    status = json['status'];
    INVOICE_TYPE = json['SalesOrderType'];
    Paid  = json['Paid'];
    Remaind  = json['Remaind'];
    UserId = json['UserId'];
    InvoiceNo = json['SalesOrderNo'];
    Name = json['Name'];

  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SalesOrderId'] = this.INVOICE_ID ;
    data['CustVenId'] = this.CUST_VEN_ID;
    data['SalesOrderDate'] =this.INVOICE_DATE  ;
    data['PaymentMethodId'] = this.PAYMENT_METHOD_ID;
    data['TreasuryId'] = this.TREASURY_ID;
    data['StockId'] = this.STOCK_ID;
    data['Price'] = this.PRICE ;
    data['Discount'] = this.Discount ;
    data['Value'] = this.VALUE ;
    data['SalesOrderType'] = this.INVOICE_TYPE;
    data['LeId'] = this.LE_ID;
    data['Paid'] = "${this.Paid}" ;
    data['Remaind'] = this.Remaind;
    data['SalesOrderNo'] = this.InvoiceNo;
    data['UserId'] = this.UserId;
    // data['InvoicePk'] = null;
    return data;
  }

}




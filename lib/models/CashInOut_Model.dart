
class CashInOut_Model {
  dynamic ? CashInOutId ;
  dynamic ? CustVenId;
  dynamic ? DocDate;
  int ? DocDate_INT;
  dynamic ? PaymentMethodId;
  dynamic ? TreasuryId;
  dynamic ? Amount ;
  dynamic ? AmountAfterOperation ;
  String ? TransType ;
  String ? Remark ;
  dynamic ? LeId;
  dynamic ? InvoiceId;
  dynamic ? ExpenseId;
  String ? status  ;
  String ? TreasuryName  ;
  String ? Name  ;
  String ? PaymentMethodName  ;
  String ? ExpenseName  ;
  dynamic ? UserId;
  dynamic ? PkId;

  CashInOut_Model({this.CashInOutId ,this.CustVenId,this.DocDate,this.PaymentMethodId,this.TreasuryId,
    this.Amount ,this.LeId,this.TransType,this.Remark,this.AmountAfterOperation ,});

  CashInOut_Model.fromJson(Map<String, dynamic> json) {
    CashInOutId  = json['CashInOutId'];
    CustVenId = json['CustVenId'];
    DocDate = json['DocDate'];
    PaymentMethodId = json['PaymentMethodId'];
    TreasuryId = json['TreasuryId'];
    TransType = json['TransType'];
    Amount  = json['Amount'];
    Remark  = json['Remark'];
    LeId = json['LeId'];
    AmountAfterOperation = json['AmountAfterOperation'];
    status = json['status'];
    InvoiceId = json['InvoiceId'];
    ExpenseId = json['ExpenseId'];
    TreasuryName = json['TreasuryName'];
    Name = json['Name'];
    PaymentMethodName = json['PaymentMethodName'];
    ExpenseName = json['ExpenseName'];
    UserId = json['UserId'];
    PkId = json['PkId'];
    DocDate_INT = json['DocDate_INT'];
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
     data['CashInOutId'] = this.CashInOutId ;
     data['DocDate'] =this.DocDate;
     data['TreasuryId'] = this.TreasuryId;
     data['Amount'] = this.Amount ;
     data['TransType'] = this.TransType ;
     data['Remark'] = this.Remark ;
     data['InvoiceId'] = this.InvoiceId;
     data['CustVenId'] = this.CustVenId;
     data['PaymentMethodId'] = this.PaymentMethodId;
    data['LeId'] = this.LeId;
    data['ExpenseId'] = this.ExpenseId;
    data['UserId'] = this.UserId;
    data['AmountAfterOperation'] = this.AmountAfterOperation;
  // data['DocDate_INT'] = this.DocDate_INT;
    return data;
  }

}




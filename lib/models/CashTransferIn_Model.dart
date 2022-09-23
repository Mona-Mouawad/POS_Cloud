
class CashTransferIn {
  List<CashTransferIn_Model> items=[];

  CashTransferIn.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      json['items'].forEach((v) {
        items.add(new CashTransferIn_Model.fromJson(v));
      });
    }
  }
}

class CashTransferIn_Model {
  int ? TransferId ;
  String ? DocDate;
  int ? TreasuryId;
  dynamic ? Amount ;
  int ? LeId;
  int ? PkId;
  String ?  status  ;
  String ?  TransType  ;
  int ? DocDate_INT;

  CashTransferIn_Model({this.TransferId ,this.DocDate,this.TreasuryId,
    this.Amount ,this.LeId,this.DocDate_INT});

  CashTransferIn_Model.fromJson(Map<String, dynamic> json) {
    TransferId  = json['TransferId'];
    DocDate = json['DocDate'];
    TreasuryId = json['TreasuryId'];
    Amount  = json['Amount'];
    LeId = json['LeId'];
    status = json['status'];
    PkId = json['PkId'];
    TransType = json['TransType'];
    DocDate_INT = json['DocDate_INT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TransferId'] = this.TransferId ;
    data['DocDate'] = this.DocDate;
    data['TreasuryId'] = this.TreasuryId;
    data['Amount'] = this.Amount ;
    data['TransType'] = 'اضافة';
    data['PkId'] = this.PkId;
    data['status'] = this.status;
    data['LeId'] = this.LeId;
    data['DocDate_INT'] = this.DocDate_INT;
    data['status'] = "new";
    return data;
  }

}






class AnalCustAccount {
  List<AnalCustAccount_Model> items=[];

  AnalCustAccount.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      json['items'].forEach((v) {
        items.add(new AnalCustAccount_Model.fromJson(v));
      });
    }
  }
}

class AnalCustAccount_Model {
  int ? CustVenId;
  int ? CustVenCode;
  String ? DocDate;
  String ? Name;
  int ? DocNo;
  dynamic ? Credit;
  dynamic ? Debit;
  dynamic ? Sub_D_C ;
  double ? Balance ;
  int ? LeId;
  String ? Remark;
  String ? DocTypeAr;

  AnalCustAccount_Model({this.CustVenId,this.DocDate,this.Remark,
    this.DocNo,this.Credit,this.Debit,this.LeId});

  AnalCustAccount_Model.fromJson(Map<String, dynamic> json) {
    CustVenId = json['CustVenId'];
    CustVenCode = json['CustVenCode'];
    DocDate = json['DocDate'];
    Name = json['Name'];
    DocNo = json['DocNo'];
    Credit = json['Credit'];
    Debit = json['Debit'];
    LeId = json['LeId'];
   Remark = json['Remark'];
   DocTypeAr = json['DocTypeAr'];
   Sub_D_C = json['Sub_D_C'];
   Balance = json['Balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CustVenCode'] = this.CustVenCode;
    data['CustVenId'] = this.CustVenId;
    data['DocDate'] = this.DocDate;
    data['DocNo'] = this.DocNo;
    data['Credit'] = this.Credit;
    data['Debit'] = this.Debit;
    data['LeId'] = this.LeId;
    data['Balance'] = this.Balance;
    data['Sub_D_C'] = this.Sub_D_C;
    data['DocTypeAr'] = this.DocTypeAr;
    data['Remark'] = this.Remark;
    return data;
  }

}




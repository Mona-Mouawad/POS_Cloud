
class Treasury {
  List<TREASURY_Model> items=[];

  Treasury.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      json['items'].forEach((v) {
        items.add(new TREASURY_Model.fromJson(v));
      });
    }
  }
}

class TREASURY_Model {
  int ? TreasuryId;
  int ? BranchId;
  String ? TreasuryName;
  int?  TreasuryType ;
  int ? LeId;
  int ? PaymentMethodId;


  TREASURY_Model({this.TreasuryId,this.BranchId,this.TreasuryName,this.LeId,
    this.PaymentMethodId,this.TreasuryType,});

  TREASURY_Model.fromJson(Map<String, dynamic> json) {
    TreasuryId = json['TreasuryId'];
    BranchId = json['BranchId'];
    TreasuryType = json['Treasurytype'];
    LeId = json['LeId'];
    TreasuryName = json['TreasuryName'];
    PaymentMethodId = json['PaymentMethodId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TreasuryId'] = this.TreasuryId;
   // data['BranchId'] = this.BranchId;
    data['Treasurytype'] = this.TreasuryType;
    data['LeId'] = this.LeId;
    data['PaymentMethodId'] = this.PaymentMethodId;
    data['TreasuryName'] = this.TreasuryName;
    return data;
  }

}




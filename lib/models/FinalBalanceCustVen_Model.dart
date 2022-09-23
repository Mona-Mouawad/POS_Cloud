
class FinalBalanceCustVen {
  List<FinalBalanceCustVen_Model> items=[];

  FinalBalanceCustVen.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      json['items'].forEach((v) {
        items.add(new FinalBalanceCustVen_Model.fromJson(v));
      });
    }
  }
}

class FinalBalanceCustVen_Model {
  int ? CustVenId;
  int ? CustVenCode;
  String ? Name;
  dynamic ? Balance;
  int ? LeId;

  FinalBalanceCustVen_Model({this.CustVenId,this.Balance,this.LeId});

  FinalBalanceCustVen_Model.fromJson(Map<String, dynamic> json) {
    CustVenId = json['CustVenId'];
    CustVenCode = json['CustVenCode'];
    Balance = json['Balance'];
    Name = json['Name'];
    LeId = json['LeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CustVenCode'] = this.CustVenCode;
    data['CustVenId'] = this.CustVenId;
    data['Balance'] = this.Balance;
    data['LeId'] = this.LeId;
    return data;
  }

}




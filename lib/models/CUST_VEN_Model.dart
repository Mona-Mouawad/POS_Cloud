
class CUST_VEN {
  List<CUST_VEN_Model> items=[];

  CUST_VEN.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      json['items'].forEach((v) {
        items.add(new CUST_VEN_Model.fromJson(v));
      });
    }
  }
}


class CUST_VEN_Model {
  int ? CUST_VEN_ID;
  String ? NAME;
  int ? CUST_VEN_CODE;
  String ? Phone1;
  String ? Phone2;
  String ? Phone3;
  String ? Phone4;
  String ? CityName;
  dynamic ? CityId;
  dynamic ? RegionId;
  String ? CityRegionName;
  dynamic ? LeId;
  dynamic ? UserId;
  dynamic ? AmountPaid;
  dynamic ? MaxDebtLimt;
  String ? Notes;
  String ? status  ;
  String ? Address  ;
  String ? PkId  ;

  CUST_VEN_Model({this.CUST_VEN_ID,this.NAME,this.AmountPaid,this.CityName,this.Notes,this.Address,this.UserId,
    this.CUST_VEN_CODE,this.Phone1,this.Phone2,this.LeId,this.MaxDebtLimt,this.CityRegionName});

  CUST_VEN_Model.fromJson(Map<String, dynamic> json) {
    CUST_VEN_ID = json['CustVenId'];
    NAME = json['Name'];
    CUST_VEN_CODE = json['CustVenCode'];
    Phone1 = json['Phone1'];
    Phone2 = json['Phone2'];
    LeId = json['LeId'];
    CityName = json['CityName'];
    CityRegionName = json['CityRegionName'];
    AmountPaid = json['AmountPaid'];
    MaxDebtLimt = json['MaxDebtLimt'];
    Notes = json['Remark'];
    Address = json['Address'];
    status = json['status'];
    UserId = json['UserId'];
    Phone4 = json['Phone4'];
    Phone3 = json['Phone3'];
    PkId = json['PkId'];
    CityId = json['CityId'];
    RegionId = json['RegionId'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CustVenId'] = this.CUST_VEN_ID;
     data['Name'] = this.NAME;
     data['CustVenCode'] = this.CUST_VEN_CODE;
     data['Phone1'] = this.Phone1;
     data['Phone2'] = this.Phone2;
     data['UserId'] = this.UserId;
     data['Phone4'] = this.Phone4;
     data['AmountPaid'] = this.AmountPaid;
    data['LeId'] = this.LeId;
     data['RegionId'] = this.RegionId;
     data['CityId'] = this.CityId;
     data['PkId'] = this.PkId;
    data['Phone3'] = this.Phone3;
    data['MaxDebtLimt'] = this.MaxDebtLimt;
     data['Address'] = this.Address;
   //  data['Notes'] = this.Notes;
 //    data['Remark'] = this.Notes;
   //  data['KinId'] = 2;
  //  data['CreationDate'] ="";
    return data;
  }

}




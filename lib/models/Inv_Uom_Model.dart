
class Inv_Uom {
  List<Inv_Uom_Model> items=[];

  Inv_Uom.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      json['items'].forEach((v) {
        items.add(Inv_Uom_Model.fromJson(v));
      });
    }
  }
}

class Inv_Uom_Model {
  dynamic ? UomId ;
  dynamic ? UomName;
  dynamic ? UomNameL;
  dynamic ? UomAbbreviation;
  dynamic ? StandConvFactor ;
  dynamic ? BaseUnit ;
  dynamic ? Inactive;
  dynamic ? UserId;
  dynamic ? LeId  ;

  Inv_Uom_Model({this.UomId ,this.UomName,this.UomNameL,this.UomAbbreviation,
    this.StandConvFactor ,this.BaseUnit,this.Inactive});

  Inv_Uom_Model.fromJson(Map<String, dynamic> json) {
    UomId  = json['UomId'];
    UomName = json['UomName'];
    UomNameL = json['UomNameL'];
    UomAbbreviation = json['UomAbbreviation'];
    StandConvFactor  = json['StandConvFactor'];
    BaseUnit = json['BaseUnit'];
    Inactive = json['Inactive'];
    UserId = json['UserId'];
    LeId = json['LeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UomId'] = this.UomId ;
    data['UomName'] = this.UomName;
    data['UomNameL'] = this.UomNameL;
    data['UomAbbreviation'] = this.UomAbbreviation;
    data['StandConvFactor'] = this.StandConvFactor ;
    data['LeId'] =this.LeId ;
    data['UserId'] = this.UserId;
    data['Inactive'] = this.Inactive;
    data['BaseUnit'] = this.BaseUnit;
    return data;
  }

}




class Inv_Uom {
  List<Inv_Uom_Model> items = [];

  Inv_Uom.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      json['items'].forEach((v) {
        items.add(Inv_Uom_Model.fromJson(v));
      });
    }
  }
}

class Inv_Uom_Model {
  dynamic? UomId;

  dynamic? UomName;
  dynamic? UomNameL;
  dynamic? UomAbbreviation;
  dynamic? StandConvFactor;

  dynamic? BaseUnit;

  dynamic? Inactive;
  dynamic? UserId;
  dynamic? LeId;

  Inv_Uom_Model(
      {
        this.UomId = 1,
      this.UomName = "قطعه",
      this.UomNameL = "قطعه",
      this.UomAbbreviation = 1,
      this.StandConvFactor = 1,
      this.BaseUnit = 1,
      this.Inactive = 1}) {

    this.UomId = 1;
    this.UomName = "قطعه";
    this.UomNameL = "قطعه";
    this.UomAbbreviation = 1;
    this.StandConvFactor = 1;
    this.BaseUnit = 1;
    this.Inactive = 1;
  }

  Inv_Uom_Model.fromJson(Map<String, dynamic> json) {
    UomId = json['UomId'] ?? 1;
    UomName = json['UomName'] ?? "قطعه";
    UomNameL = json['UomNameL'] ?? "قطعه";
    UomAbbreviation = json['UomAbbreviation'] ?? 1;
    StandConvFactor = json['StandConvFactor'] ?? 1;
    BaseUnit = json['BaseUnit'] ?? 1;
    Inactive = json['Inactive'] ?? 1;
    UserId = json['UserId']  ?? UserId;
    LeId = json['LeId']   ??  LeId;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UomId'] = this.UomId ?? 1;
    data['UomName'] = this.UomName ?? "قطعه";
    data['UomNameL'] = this.UomName ?? "قطعه";
    data['UomAbbreviation'] = this.UomAbbreviation ?? 1;
    data['StandConvFactor'] = this.StandConvFactor ?? 1;
    data['LeId'] = this.LeId ?? LeId;
    data['UserId'] = this.UserId ?? UserId;
    data['Inactive'] = this.Inactive ?? 1;
    data['BaseUnit'] = this.BaseUnit ?? 1;
    return data;
  }
}

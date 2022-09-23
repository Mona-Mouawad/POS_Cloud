class City {
  List<CITYModel> items=[];

  City.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      json['items'].forEach((v) {
        items.add(new CITYModel.fromJson(v));
      });
    }
  }
}

class CITYModel {
  int ? CITY_ID;
  int ? REGION_ID;
  String ? CITY_NAME;
String ? CITY_ACTIVE ;
  int ? USER_ID;
  int ? CITY_NO;
  int ? LeId;
  int ? PkId;


  CITYModel({this.CITY_ID,this.REGION_ID,this.CITY_NAME,this.USER_ID,this.CITY_ACTIVE,this.CITY_NO});

  CITYModel.fromJson(Map<String, dynamic> json) {
    CITY_ID = json['CityId'];
    REGION_ID = json['RegionId'];
    CITY_ACTIVE = json['CityActive'];
    USER_ID = json['UserId'];
    CITY_NAME = json['CityName'];
    CITY_NO = json['CityNo'];
    LeId = json['LeId'];
    PkId = json['PkId'];

  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CityId'] = this.CITY_ID;
    data['RegionId'] = this.REGION_ID;
    data['CityActive'] = this.CITY_ACTIVE;
    data['UserId'] = this.USER_ID;
    data['CityNo'] = this.CITY_NO;
    data['CityName'] = this.CITY_NAME;
    data['PkId'] = this.PkId;
    data['LeId'] = this.LeId;
    return data;
  }

}




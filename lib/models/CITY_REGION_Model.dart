class CityRegion {
  List<CITY_REGION_Model> items=[];

  CityRegion.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      json['items'].forEach((v) {
        items.add(new CITY_REGION_Model.fromJson(v));
      });
    }
  }
}
class CITY_REGION_Model {
  int ? RegionId;
  int ? CITY_ID;
  String ? CITY_REGION_NAME;
  String ? CITY_REGION_ACTIVE ;
  int ? LeId;
  String ? CITY_REGION_NO;


  CITY_REGION_Model({this.RegionId,this.CITY_ID,this.CITY_REGION_NAME,this.LeId,this.CITY_REGION_ACTIVE,this.CITY_REGION_NO});

  CITY_REGION_Model.fromJson(Map<String, dynamic> json) {
    RegionId = json['CityRegionId'];
    CITY_ID = json['CityId'];
    CITY_REGION_ACTIVE = json['CityRegionActive'];
    LeId = json['LeId'];
    CITY_REGION_NAME = json['CityRegionName'];
    CITY_REGION_NO = json['CityRegionNo'];

  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CityRegionId'] = this.RegionId;
    data['CityId'] = this.CITY_ID;
    data['CityRegionActive'] = this.CITY_REGION_ACTIVE;
    data['LeId'] = this.LeId;
    data['CityRegionNo'] = this.CITY_REGION_NO;
    data['CityRegionName'] = this.CITY_REGION_NAME;
    return data;
  }

}




//
import 'dart:core';


class Location_Model {
  int ? GpsId;
  int ? UserId;
  int ? LeId;
  String ? DeviceId;
  String ? Tim;
  dynamic ? X;
  dynamic ? Y;
  String ? status;


  Location_Model({this.UserId,this.DeviceId,this.Tim,this.X,this.Y});

  Location_Model.fromJson(Map<String, dynamic> json) {
    GpsId = json['GpsId'];
    UserId = json['UserId'];
    DeviceId = json['DeviceId'];
    Tim = json['Tim'];
    X = json['X'];
    Y = json['Y'];
    status = json['status'];
    LeId = json['LeId'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserId'] = this.UserId;
    data['DeviceId'] = this.DeviceId;
    data['Tim'] = this.Tim;
    data['X'] = this.X ;
    data['Y'] = this.Y ;
    data['LeId'] = this.LeId;
    return data;
  }

}




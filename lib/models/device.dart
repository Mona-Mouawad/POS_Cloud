class Device {
  List<Device_Model> items=[];

  Device.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      json['items'].forEach((v) {
        items.add(new Device_Model.fromJson(v));
      });
    }
  }
}
class Device_Model {
  int ? UserId;
  String ? DeviceId;
  String ? status;
  int ? Active;
  int ? LeId;


  Device_Model({this.UserId,this.DeviceId,this.Active,this.LeId});

  Device_Model.fromJson(Map<String, dynamic> json) {
    UserId = json['UserId'];
    DeviceId = json['DeviceId'];
    Active = json['Active'];
    LeId = json['LeId'];
    status = json['status'];
    }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserId'] = this.UserId;
    data['DeviceId'] = this.DeviceId;
    data['LeId'] = this.LeId;
    data['Active'] = this.Active;
    return data;
  }

}




class PaymentMethod {
  List<PAYMENT_METHOD_Model> items=[];

  PaymentMethod.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      json['items'].forEach((v) {
        items.add(new PAYMENT_METHOD_Model.fromJson(v));
      });
    }
  }
}

class PAYMENT_METHOD_Model {
  int ? PAYMENT_METHOD_ID;
  String ? PAYMENT_METHOD_NAME;
  int ? LE_ID;
  String ? status  ;


  PAYMENT_METHOD_Model({this.PAYMENT_METHOD_ID,this.PAYMENT_METHOD_NAME,this.LE_ID});

  PAYMENT_METHOD_Model.fromJson(Map<String, dynamic> json) {
    PAYMENT_METHOD_ID = json['PaymentMethodId'];
    PAYMENT_METHOD_NAME = json['PaymentMethodName'];
    LE_ID = json['LeId'];
    status = json['status'];

  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PaymentMethodId'] = this.PAYMENT_METHOD_ID;
    data['PaymentMethodName'] = this.PAYMENT_METHOD_NAME;
    data['status'] = this.status;
    data['LeId'] = this.LE_ID;
    return data;
  }

}




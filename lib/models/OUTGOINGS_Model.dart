
class Expense {
  List<OUTGOINGS_Model> items=[];

  Expense.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      json['items'].forEach((v) {
        items.add(new OUTGOINGS_Model.fromJson(v));
      });
    }
  }
}

class OUTGOINGS_Model {
  int ? OUTGOINGS_ID;
  String ? OUTGOINGS_NAME;
  int ? LE_ID;
  String ?  status ;


  OUTGOINGS_Model({this.OUTGOINGS_ID,this.OUTGOINGS_NAME,this.LE_ID});

  OUTGOINGS_Model.fromJson(Map<String, dynamic> json) {
    OUTGOINGS_ID = json['ExpenseId'];
    OUTGOINGS_NAME = json['ExpenseName'];
    LE_ID = json['LeId'];
    status = json['status'];

  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ExpenseId'] = this.OUTGOINGS_ID;
    data['ExpenseName'] = this.OUTGOINGS_NAME;
    data['status'] = this.status;
    data['LeId'] = this.LE_ID;
    return data;
  }

}




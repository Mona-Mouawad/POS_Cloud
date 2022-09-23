//  INTEGER PRIMARY KEY NOT NULL , TEXT NOT NULL ,  INTEGER '
//             ' Barcode TEXT , Qr TEXT , status TEXT , UserId INTEGER ,LeId INTEGER ,DocNo  INTEGER

class SellOrderDelivery {
  dynamic ? DocId ;
  dynamic ? DocDate;
  dynamic ? DocType;
  dynamic ? Barcode;
  dynamic ? Qr;
  dynamic ? DocNo;
  dynamic ? LeId;
  dynamic ? status  ;
  dynamic ? UserId;

  SellOrderDelivery({this.DocId ,this.DocDate,this.DocType,this.Barcode,this.Qr,this.DocNo,
    this.LeId,this.UserId,this.status});

  SellOrderDelivery.fromJson(Map<String, dynamic> json) {
    DocId  = json['DocId'];
    DocDate = json['DocDate'];
    DocType = json['DocType'];
    Barcode = json['Barcode'];
    Qr = json['Qr'];
    DocNo = json['DocNo'];
    LeId = json['LeId'];
    status = json['status'];
    UserId = json['UserId'];

  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DocId'] = this.DocId ;
    data['DocDate'] = this.DocDate;
    data['DocType'] =this.DocType  ;
    data['Barcode'] = this.Barcode;
    data['Qr'] = this.Qr;
    data['DocNo'] = this.DocNo;
    data['LeId'] = this.LeId;
    data['UserId'] = this.UserId;
    // data['InvoicePk'] = null;
    return data;
  }

}




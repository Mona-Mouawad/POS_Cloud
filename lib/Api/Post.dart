import 'package:pos/DataBase/DataBase.dart';
import 'package:pos/models/device.dart';
import 'package:pos/models/location_Model.dart';
import '../models/CUST_VEN_Model.dart';
import '../models/CashInOut_Model.dart';
import '../models/INVOICE_Model.dart';
import '../models/InvoiceItemModel.dart';
import '../shared/Content.dart';
import '../shared/helper/Dio_Helper.dart';
import 'get.dart';

// 'http://185.219.134.68:7008/REST/rest/v0/'
// /describe

CUST_VEN_Model? CUST_VEN_model;
CUST_VEN_Post()
async {print('value.data  ////////////////*********CUST_VEN_Post******///////////+++++++++++++++++++&&&&&&&&');
  //await getCUST(database);
database.rawQuery('SELECT * '
    'FROM MobPosCustVen Where status = "new" '
).then((value) async{
  value.forEach((element) async {
    CUST_VEN_Model CUST_VENModel = CUST_VEN_Model.fromJson(element);
    print('CUST_VENModel.status   '+CUST_VENModel.status.toString());
    if (CUST_VENModel.status == 'new') {
      Dio_Helper.PostData( //${URlCustVen?finder=RowFinder;pLeId=1,pKinId=2
        url: '${URl}MobPosCustVen',// '${URlMobPosCustVen',
        data:
        (CUST_VENModel.toJson()),
      ).then((value) async {
        await database.rawUpdate(
            'UPDATE MobPosCustVen SET status = ?  WHERE CustVenId =? ',
            ['',CUST_VENModel.CUST_VEN_ID]);
        CUST_VEN_model = CUST_VEN_Model.fromJson(value.data);
        print(value.data);
        print(
            'value.data  ////////////////***************///////////+++++++++++++++++++&&&&&&&&^^^^^^^^^^^^%%%%%%%%%%%%@@@@@@@@@@@@@@!!!!!!!!~~~~~#############');
        print(CUST_VEN_model!.NAME);
      }).catchError((error) {
        print(error.toString());
      });
    }
  });
});
 }

INVOICE_Model? _INVOICE_Model;
INVOICE_Post()
async {print('value.data  ////////////////********INVOICE_ModelList*******///////////+++++++++++++++++++&&&&&&&&');
//await getINVOICE(database);
database.rawQuery('SELECT  *   FROM MobPosInvoice '
    ' Where status = "new" ').then((value) {
  value.forEach((element) {
    INVOICE_Model INVOICEModel =INVOICE_Model.fromJson(element);
    print('INVOICEModel.status   '+INVOICEModel.status.toString());
    if(INVOICEModel.status == 'new') {
      Dio_Helper.PostData(
        url: '${URl}MobPosInvoice',
        data: (INVOICEModel.toJson()),
      ).then((value) async {
        print('INVOICE_ModelList      ${value.statusCode}');
        //   print(value.data);
        await database.rawUpdate('UPDATE MobPosInvoice SET status = ?  WHERE InvoiceId = ? ',
            ['',INVOICEModel.INVOICE_ID]);
        _INVOICE_Model = INVOICE_Model.fromJson(value.data);
        print(value.data);
        print(
            'value.data  ////////////////***************///////////++++INVOICE_ModelList^^^^^^^^^%%%%%%%%%%%%@@@@@@@@@@@@@@!!!!!!!!~~~~~#############');
        print(_INVOICE_Model!.INVOICE_ID);
      }).catchError((error) {
        print(error.toString());
      });
    }
  });
});
}




InvoiceItemModel? InvoiceItem_model;
InvoiceItem_Post()
async {print('value.data  ////////////////********InvoiceItemModelList*******///////////+++++++++++++++++++&&&&&&&&');
database.rawQuery('SELECT * FROM MobPosInvoiceItem  Where status = "new" ').then((value) async {
   value.forEach((element) {
    //  print(element);
    InvoiceItemModel InvoiceItem_Model = InvoiceItemModel.fromJson(element);
    print('InvoiceItem_Model.status   '+InvoiceItem_Model.status.toString());
    if(InvoiceItem_Model.status == 'new' ) {
      Dio_Helper.PostData(
        url: '${URl}MobPosInvoiceItem',
        data: (InvoiceItem_Model.toJson()),
      ).then((value) async {
        print('InvoiceItem_ModelList      ${value.statusCode}');
        await database.rawUpdate('UPDATE MobPosInvoiceItem SET status = ?  WHERE InvoiceItemId =? ', ['',InvoiceItem_Model.InvoiceItemId]);

        InvoiceItem_model = InvoiceItemModel.fromJson(value.data);
        print(value.data);
        print(
            'value.data  ////////////////***************///////////++++InvoiceItemModelList^^^^^^^^^%%%%%%%%%%%%@@@@@@@@@@@@@@!!!!!!!!~~~~~#############');
        print(InvoiceItem_model!.InvoiceItemId);
      }).catchError((error) {
        print(error.toString());
      });

    }
  });
}).catchError((onError){print('ee    InvoiceItemModelList   '+onError.toString());});
}

CashInOut_Model? CashInOut_model;
CashInOut_Post()
async {print('value.data  ////////////////********CashInOut_ModelList*******///////////+++++++++++++++++++&&&&&&&&');
//await getCashInOut(database);
database.rawQuery('SELECT * FROM MobPosCashInOut Where status = "new" '
).then((value) {
  value.forEach((element) {
    //  print(element);
    CashInOut_Model CashInOutModel = CashInOut_Model.fromJson(element);
    print('CashInOutModel.status   '+CashInOutModel.status.toString());
    if(CashInOutModel.status == 'new' ) {
      Dio_Helper.PostData(
        url: '${URl}MobPosCashInOut',
        data: (CashInOutModel.toJson()),
      ).then((value) async {
        print('CashInOut_ModelList      ${value.statusCode}');
        await database.rawUpdate('UPDATE MobPosCashInOut SET status = ?  WHERE CashInOutId =? ', ['',CashInOutModel.CashInOutId]);

        CashInOut_model = CashInOut_Model.fromJson(value.data);
        print(value.data);
        print(
            'value.data  ////////////////***************///////////++++CashInOut_ModelList^^^^^^^^^%%%%%%%%%%%%@@@@@@@@@@@@@@!!!!!!!!~~~~~#############');
        print(CashInOut_model!.CashInOutId);
      }).catchError((error) {
        print(error.toString());
      });
    }
  });
});
}

Location_Model? Location_model;
Gps_Post()
async {print('value.data  ////////////////********GpsModelList*******///////////+++++++++++++++++++&&&&&&&&');
database.rawQuery('SELECT * FROM MobPosGps Where status = "new" '
).then((value) {
  value.forEach((element) {
    Location_Model GpsModel =Location_Model.fromJson(element);
    print('GpsModel.status   '+GpsModel.status.toString());
    if(GpsModel.status == 'new' ) {
      Dio_Helper.PostData(
        url: '${URl}MobGps',
        data: (GpsModel.toJson()),
      ).then((value) async {
        print('GpsModelList      ${value.statusCode}');
        await database.rawUpdate('UPDATE MobPosGps SET status = ?  WHERE GpsId =? ', ['',GpsModel.GpsId]);
        // await database.
        Location_model = Location_Model.fromJson(value.data);
        print(value.data);
        print(
            'value.data  ////////////////***************///////////++++GpsModelList^^^^^^^^^%%%%%%%%%%%%@@@@@@@@@@@@@@!!!!!!!!~~~~~#############');
        print(Location_model!.X);
      }).catchError((error) {
        print(error.toString());
      });
    }
  });
});

}

Device_Model? Device_model;
UserSec_Post()
{print('value.data  ////////////////********UserSec_ModelList*******///////////+++++++++++++++++++&&&&&&&&');
    Dio_Helper.PostData(
      url: '${URl}MobUserSec',
      data: UsrSec!.toJson() , //(UsrSec_List[UsrSec_List.length -1].toJson()),
    ).then((value) async {
      print (value.statusCode);
          Device_model = Device_Model.fromJson(value.data);
          print(value.data);
          print('value.data  ////////////////***************///////////++++UserSec_ModelList^^^^^^^^^%%%%%%%%%%%%@@@@@@@@@@@@@@!!!!!!!!~~~~~#############');
          print(Device_model!.DeviceId);
          await Future.delayed(const Duration(seconds: 13), () async {
            await getdevicedata(deviceId: deviceId!,UserId: UserId!);
          });
      //  }
      }).catchError((error) {
      print(error.toString());
    });
}

PostAllApiTable()
async {
  await Gps_Post() ;
  await  InvoiceItem_Post();
  await  INVOICE_Post();
  await CUST_VEN_Post() ;
  await  CashInOut_Post();
}
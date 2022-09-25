import 'dart:convert';
import 'package:pos/DataBase/Insert_City&Region.dart';
import 'package:pos/models/CUST_VEN_Model.dart';
import 'package:pos/models/PAYMENT_METHOD_Model.dart';
import 'package:pos/shared/helper/cach_Helper.dart';
import '../DataBase/DataBase.dart';
import '../DataBase/INSERTS.dart';
import '../models/CITYModel.dart';
import '../models/CITY_REGION_Model.dart';
import '../models/CashTransferIn_Model.dart';
import '../models/CashTransferOut_Model.dart';
import '../models/ITEM_GROUP_Model.dart';
import '../models/ITEM_Model.dart';
import '../DataBase/getDB.dart';
import '../models/InvTransferIn_Model.dart';
import '../models/InvTransferOut_Model.dart';
import '../models/Inv_Uom_Model.dart';
import '../models/STOCK_Model.dart';
import '../models/TREASURY_Model.dart';
import '../models/UserModel.dart';
import '../models/OUTGOINGS_Model.dart';
import '../models/device.dart';
import '../shared/Content.dart';
import '../shared/helper/Dio_Helper.dart';

//String URl ='http://192.168.1.71:7006/REST/rest/v0/';
 String URl ='http://185.219.134.68:7008/REST/rest/v0/';

// String Local_URl ='http://185.219.134.68:7008/REST/rest/v0/';

//http://192.168.1.71:7006/REST/rest/v0/describe

getUserdata({required int LeId })
{
  User model ;  //'http://185.219.134.68:7008/REST/rest/v0/SmUser?finder=RowFinder;pLeId=${LeId}'
  Dio_Helper.getData(url: '${URl}SmUser?q=finder=RowFinder;LeId=${LeId}').then((value) async {
    print(value);
    String v =value.toString().trim().replaceAll('\r\n', '').replaceAll('^', '');
    model=User.fromJson(jsonDecode(v));
    print('//////////////////');
    print(model.items[0].UserId.toString());
    await database.transaction((txn)async {
      await txn.delete('MobPosUser');});
    model.items.forEach((element)  async {
      await   database.insert('MobPosUser', element.toJson());
    });
    await  getPOS_USER(database);
    LeName =Cach_helper.GetData(key: 'LeName');
    print(model.items.length);
    print('**********************  items  ++++++++++++-------------=====================');
  } ).catchError((Error)
  { print("eee   "+Error.toString());
  });
}

getItemdata({required int LeId })
{
  ITEMS model ;
  Dio_Helper.getData(url: '${URl}Item?q=finder=RowFinder;LeId=${LeId}').then((value) async {
    print(value);
    String v =value.toString().trim().replaceAll('\r\n', '').replaceAll('^', '');
    model=ITEMS.fromJson(jsonDecode(v));
    print('//////////////////');
    print(model.items[0].ITEM_ID.toString());
     await database.transaction((txn)async {
      await txn.delete('MobPosItem');});
    model.items.forEach((element)  async {
      await insertItems (
          ItemId: element.ITEM_ID! , ITEM_NAME: element.ITEM_NAME!,
          BARCODE: element.BARCODE, QUANTITY: element.Quantity ?? 0 , SALES_PRICE1: element.SalesPrice1 ?? 0 ,
          GROUP_ID: element.GroupId  , NODES: element.Nodes, SALES_PRICE3: element.SalesPrice3  ?? 0 , SALES_PRICE2: element.SalesPrice2 ?? 0 ,
        UserId: element.UserId!  ,status: '' ,LE_ID: element.LeId!
          );
    });
    print('**********************  getItemdata  ++++++++++++-------------=====================');
  } ).catchError((Error)
  { print("eee  getItemdata  "+Error.toString());
  });
}

getGroupItemdata({required int LeId })
{
  ITEM_GROUP model ;
  Dio_Helper.getData(url: '${URl}GroupItem?q=finder=RowFinder;LeId=${LeId}').then((value) async {
    print(value);
    String v =value.toString().trim().replaceAll('\r\n', '').replaceAll('^', '');
    model=ITEM_GROUP.fromJson(jsonDecode(v));
    print('//////////   ITEM_GROUP.fromJson    ////////');
    print(model.items[0].ITEM_GROUP_ID.toString());
       await database.transaction((txn)async {
      await txn.delete('MobPosItemGroup');});
    model.items.forEach((element)  async {
      await   database.insert('MobPosItemGroup', element.toJson());
    });
    await  getGroup(database);
    print('  model.items.length.toString()  '+model.items.length.toString());
    print('**********************  items  ++++++++++++-------------=====================');
  } ).catchError((Error)
  { print("eee   "+Error.toString());
  });
}


getTreasurydata({required int LeId ,required int UserId })
{
  Treasury model ;
  Dio_Helper.getData(url: '${URl}MobPosTreasuryV?q=LeId=${LeId};Userid=${UserId}').then((value) async {
    print(value);
    String v =value.toString().trim().replaceAll('\r\n', '').replaceAll('^', '');
    model=Treasury.fromJson(jsonDecode(v));
    print('//////////   Treasury.fromJson    ////////');
    print(model.items[0].TreasuryId.toString());
       await database.transaction((txn)async {
      await txn.delete('MobPosTreasury');});
    model.items.forEach((element)  async {
      await   database.insert('MobPosTreasury', element.toJson());
    });
    await  getPOS_TREASURY(database: database ,getCashTransfer: true);
    print('  model.items.length.toString()  '+model.items.length.toString());
    print('**********************  items  ++++++++++++-------------=====================');
  } ).catchError((Error)
  { print("eee   "+Error.toString());
  });
}


getCashTransferIndata({required int LeId })
async {
  await database.transaction((txn) async {
    await txn.delete('MobPosCashTransferIn');
  });
  TREASURY_ModelList.forEach((element) {
    CashTransferIn model;
    Dio_Helper.getData(
        url: '${URl}MobPosCashTransferIn?q=LeId=${LeId};TreasuryId=${element.TreasuryId}')
        .then((value) async {
      print(value);
      String v = value.toString().trim().replaceAll('\r\n', '').replaceAll(
          '^', '');
      model = CashTransferIn.fromJson(jsonDecode(v));
      print('//////////   CashTransferIn.fromJson    ////////');
      print(model.items[0].TransferId.toString());
      model.items.forEach((element) async {
        element.DocDate_INT =int.parse(element.DocDate.toString().replaceAll('-', ''));
        await database.insert('MobPosCashTransferIn', element.toJson());
      });
      print(
          '  model.items.length.toString()  MobPosCashTransferIn  ' + model.items.length.toString());
        }).catchError((Error) {
      print("eee MobPosCashTransferIn  " + Error.toString());
    });
  });
}

getCashTransferOutdata({required int LeId })
async {
  await database.transaction((txn)async {
    await txn.delete('MobPosCashTransferOut');});
  TREASURY_ModelList.forEach((element) {
    CashTransferOut model ;
    Dio_Helper.getData(url: '${URl}MobPosCashTransferOut?q=LeId=${LeId};TreasuryId=${element.TreasuryId}').then((value) async {
      print(value);
      String v =value.toString().trim().replaceAll('\r\n', '').replaceAll('^', '');
      model=CashTransferOut.fromJson(jsonDecode(v));
      print('//////////   CashTransferOut.fromJson    ////////');
      print(model.items[0].TransferId.toString());

      model.items.forEach((element)  async {
        element.DocDate_INT =int.parse(element.DocDate.toString().replaceAll('-', ''));
        await   database.insert('MobPosCashTransferOut', element.toJson());
      });
      print('  model.items.length.toString()  MobPosCashTransferOut '+model.items.length.toString());
    } ).catchError((Error)
    { print("eee  MobPosCashTransferOut  "+Error.toString());
    });
  });
}


getCustVendata({required int LeId })
{
  CUST_VEN model ;
  Dio_Helper.getData(url: '${URl}CustVen?q=finder=RowFinder;KinId=2;LeId=${LeId}').then((value) async {
    print(value);
    String v =value.toString().trim().replaceAll('\r\n', '').replaceAll('^', '');
    model=CUST_VEN.fromJson(jsonDecode(v));
    print('//////////   getCustVendata.fromJson    ////////');
    print(model.items[0].CUST_VEN_ID.toString());
       await database.transaction((txn)async {
      await txn.delete('MobPosCustVen');});
    model.items.forEach((element)  async {
      await
      database.insert('MobPosCustVen', element.toJson());
    });
    await  getCUST(database);
    print('  model.items.length.toString()  '+model.items.length.toString());
    print('**********************  items  ++++++++++++-------------=====================');
  } ).catchError((Error)
  { print("eee   "+Error.toString());
  });
}


getStockdata({required int LeId ,required int UserId })
{
  STOCK model ;
  Dio_Helper.getData(url: '${URl}MobPosStockV?q=finder=RowFinder;LeId=${LeId};Userid=${UserId}').then((value) async {
    print(value);
    String v =value.toString().trim().replaceAll('\r\n', '').replaceAll('^', '');
    model=STOCK.fromJson(jsonDecode(v));
    print('//////////   STOCK.fromJson    ////////');
    print(model.items[0].STOCK_ID.toString());
       await database.transaction((txn)async {
      await txn.delete('MobPosStock');});
    model.items.forEach((element)  async {
      await
      database.insert('MobPosStock', element.toJson());
    });
    await  getSTOCK(database: database ,get_InvTransfer: true);
    print('  model.items.length.toString()  '+model.items.length.toString());
    print('**********************  items  ++++++++++++-------------=====================');
  } ).catchError((Error)
  { print("eee   "+Error.toString());
  });
}

getInvTransferIndata({required int LeId })
async {      await database.transaction((txn) async {
  await txn.delete('MobPosInvTransferIn');
});
  STOCK_ModelList.forEach((element) {
    InvTransferIn model;
    Dio_Helper.getData(
        url: '${URl}MobPosInvTransferIn?q=LeId=${LeId};Stockid=${element.STOCK_ID}')
        .then((value) async {
      print(value);
      String v = value.toString().trim().replaceAll('\r\n', '').replaceAll(
          '^', '');
      model = InvTransferIn.fromJson(jsonDecode(v));
      print('//////////   InvTransferIn.fromJson    ////////');
      print(model.items[0].TransferId.toString());
      model.items.forEach((element) async {
        await database.insert('MobPosInvTransferIn', element.toJson());
      });
      print(
          '  model.items.length.toString()  MobPosInvTransferIn ' + model.items.length.toString());
     }).catchError((Error) {
      print("eee   " + Error.toString());
    });
  });
await getInvTransferIn(database);
}

getInvTransferOutdata({required int LeId })
async {
  await database.transaction((txn)async {
    await txn.delete('MobPosInvTransferOut');});
  STOCK_ModelList.forEach((element) {
    InvTransferOut model ;
    Dio_Helper.getData(url: '${URl}MobPosInvTransferOut?q=LeId=${LeId};Stockid=${element.STOCK_ID}').then((value) async {
      print(value);
      String v =value.toString().trim().replaceAll('\r\n', '').replaceAll('^', '');
      model=InvTransferOut.fromJson(jsonDecode(v));
      print('//////////   InvTransferOut.fromJson    ////////');
      print(model.items[0].TransferId.toString());
      model.items.forEach((element)  async {
        await   database.insert('MobPosInvTransferOut', element.toJson());
      });
      print('  model.items.length.toString() MobPosInvTransferOut '+model.items.length.toString());
    } ).catchError((Error)
    { print("eee   "+Error.toString());
    });
  });
  await  getInvTransferOut(database);
}

////////////////////////////////////////////////// No   Data  in APi
getExpensedata({required int LeId })
{
  Expense model ;
  Dio_Helper.getData(url: '${URl}MobPosExpenseV?pLeId=${LeId}').then((value) async {
    print(value);
    String v =value.toString().trim().replaceAll('\r\n', '').replaceAll('^', '');
    model=Expense.fromJson(jsonDecode(v));
    print('//////////   Expense.fromJson    ////////');
    print(model.items[0].OUTGOINGS_ID.toString());
       await database.transaction((txn)async {
      await txn.delete('MobPosExpense');});
    model.items.forEach((element)  async {
      await
      database.insert('MobPosExpense', element.toJson());
    });
    await  getOUTGOINGS(database);
    print('  model.items.length.toString()  '+model.items.length.toString());
    print('**********************  items  ++++++++++++-------------=====================');
  } ).catchError((Error)
  { print("eee   "+Error.toString());
  });
}

getPaymentMethoddata({required int LeId })
{
  PaymentMethod model ;
  Dio_Helper.getData(url: '${URl}MobPosPaymentMethod?q=finder=RowFinder;LeId=${LeId}').then((value) async {
    print(value);
    String v =value.toString().trim().replaceAll('\r\n', '').replaceAll('^', '');
    model=PaymentMethod.fromJson(jsonDecode(v));
    print('//////////   MobPosPaymentMethod.fromJson    ////////');
    print(model.items[0].PAYMENT_METHOD_ID.toString());
       await database.transaction((txn)async {
      await txn.delete('MobPosPaymentMethod');});
    model.items.forEach((element)  async {
      await database.insert('MobPosPaymentMethod', element.toJson());
      //await database.update('MobPosPaymentMethod', element.toJson(),model.items[0].PAYMENT_METHOD_ID==);
    });
    await  getPOS_PAYMENT_METHOD(database);
    print('  model.items.length.toString()  '+model.items.length.toString());
    print('**********************  items  ++++++++++++-------------=====================');
  } ).catchError((Error)
  { print("eee   "+Error.toString());
  });
}

getCitydata({required int LeId })
async {
  City model ;
  Dio_Helper.getData(url: '${URl}MobPosCity?q=finder=RowFinder;LeId=${LeId}').then((value) async {
    print(value);
    String v =value.toString().trim().replaceAll('\r\n', '').replaceAll('^', '');
    model=City.fromJson(jsonDecode(v));
    print('//////////   MobPosCity.fromJson    ////////');
    print(model.items[0].CITY_ID.toString());
       await database.transaction((txn)async {
      await txn.delete('MobPosCity');});
    model.items.forEach((element)  async {
      await
      database.insert('MobPosCity', element.toJson());
    });
    await  getMobPosCity(database);
    print('  model.items.length.toString()  '+model.items.length.toString());
    print('**********************  items  ++++++++++++-------------=====================');
  } ).catchError((Error)
  { print("eee   "+Error.toString());
  });
}

getCityRegionedata({required int LeId })
{
  CityRegion model ;
  Dio_Helper.getData(url: '${URl}MobPosCityRegion?q=finder=RowFinder;LeId=${LeId}').then((value) async {
    print(value);
    String v =value.toString().trim().replaceAll('\r\n', '').replaceAll('^', '');
    model=CityRegion.fromJson(jsonDecode(v));
    print('//////////   CityRegion    ////////');
    await database.transaction((txn)async {
      await txn.delete('MobPosCityRegion');});
    model.items.forEach((element)  async {
      await
      database.insert('MobPosCityRegion', element.toJson());
    });
    await  getMobPosCity_REGION(database);
    print(model.items[0].RegionId.toString());
    print('**********************  items  ++++++++++++-------------=====================');
  } ).catchError((Error)
  { print("eee   "+Error.toString());
  });
}

Device_Model ? device  ;

Future<int> getdevicedata({required String deviceId ,required int UserId })async
{
  Device model ;
  Dio_Helper.getData(url: '${URl}MobUserSec?q=UserId=${UserId};DeviceId=${deviceId}').then((value) async {
    print(value.statusCode);
    print(value);
    String v =value.toString().trim().replaceAll('\r\n', '').replaceAll('^', '');
    model=Device.fromJson(jsonDecode(v));
    device=model.items[0];
    print('//////////   Device    ////////');
    Cach_helper.SaveData(key: 'Active', value: model.items[0].Active);
    Active = model.items[0].Active;
    print(model.items[0].DeviceId.toString());
    return(model.items[0].Active) ;
    print('**********************  items  ++++++++++++-------------=====================');
  } ).catchError((Error)
  {
    device = null ;
    Active = 0 ;
    print("eee   getdevicedata  "+Error.toString());
  });
 return 0 ;
}

getInvUomdata({required int LeId })
{
  Inv_Uom model ;
  Inv_Uom_Model inv_Uom_Model  =new Inv_Uom_Model();
  Dio_Helper.getData(url: '${URl}InvUom?q=LeId=${LeId}').then((value) async {
    print(value);
    String v =value.toString().trim().replaceAll('\r\n', '').replaceAll('^', '');
    model=Inv_Uom.fromJson(jsonDecode(v));
    print('//////////   MobPosInv_Uom    ////////');
    await database.transaction((txn)async {
      await txn.delete('MobPosInv_Uom');});
    model.items.forEach((element)  async {
      if(element.Inactive != 1) {
        await database.insert('MobPosInv_Uom', element.toJson());
      }
    });
    if (model.items.isEmpty )
      { database.insert('MobPosInv_Uom', inv_Uom_Model.toJson());}
     await getInv_Uom(database);
    print(model.items[0].UomId.toString());
    print('**********************  MobPosInv_Uom  ++++++++++++-------------=====================');
  } ).catchError((Error)
  async {
    database.insert('MobPosInv_Uom', inv_Uom_Model.toJson());
    await getInv_Uom(database);
    print("eee rrrr ooo rrrr  MobPosInv_Uom  "+Error.toString());
  });
}


GetAllApiTable({required LeId , required UserId})
async {
  await getUserdata(LeId: LeId) ;
  await  getCitydata(LeId: LeId!);
  await getInvUomdata(LeId: LeId!);
  await  getCityRegionedata(LeId: LeId! );
  await getItemdata(LeId: LeId) ;
  await  getGroupItemdata(LeId: LeId );
 // await  getCustVendata(LeId: LeId );
  await  getExpensedata(LeId: LeId );
  await  getPaymentMethoddata(LeId: LeId );
  await  getStockdata(LeId: LE_ID! ,UserId: UserId);
  await  getTreasurydata(LeId: LE_ID! ,UserId: UserId );

}
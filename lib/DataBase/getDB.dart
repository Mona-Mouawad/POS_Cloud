import 'package:audioplayers/audioplayers.dart';
import 'package:pos/DataBase/DataBase.dart';
import 'package:pos/models/CUST_VEN_Model.dart';
import 'package:pos/models/CashInOut_Model.dart';
import 'package:pos/models/CashTransferIn_Model.dart';
import 'package:pos/models/CashTransferOut_Model.dart';
import 'package:pos/models/ITEM_GROUP_Model.dart';
import 'package:pos/models/ITEM_Model.dart';
import 'package:pos/models/INVOICE_Model.dart';
import 'package:pos/models/InvTransferIn_Model.dart';
import 'package:pos/models/InvTransferOut_Model.dart';
import 'package:pos/models/InvoiceItemModel.dart';
import 'package:pos/models/OUTGOINGS_Model.dart';
import 'package:pos/models/PAYMENT_METHOD_Model.dart';
import 'package:pos/models/STOCK_Model.dart';
import 'package:pos/models/Stock_Details_Model.dart';
import 'package:pos/models/TREASURY_Model.dart';
import 'package:pos/models/UserModel.dart';
import 'package:pos/shared/Content.dart';
import 'package:pos/cubit/cubit.dart';
import '../Api/get.dart';
import '../models/Inv_Uom_Model.dart';
import '../models/InventoryCount_Model.dart';
import '../models/SalesOrder.dart';
import '../models/SellOrderDelivery_Model.dart';
import '../models/location_Model.dart';
import '../modules/registerscreen.dart';
import '../modules/showCustomer.dart';
import '../shared/component.dart';
import 'Insert_City&Region.dart';


List<ITEM_GROUP_Model> ITEM_GROUPList = [];
List<String> ITEM_GROUP_Names = [];
getGroup(database) async {
  ITEM_GROUPList = [];
  ITEM_GROUP_Names = [];
  database.rawQuery('SELECT * FROM MobPosItemGroup').then((value) {
    value.forEach((element) {
      ITEM_GROUP_Model itemModel = ITEM_GROUP_Model.fromJson(element);
      ITEM_GROUPList.add(itemModel);
      ITEM_GROUP_Names.add(element['GrpName']);
  });
    print(ITEM_GROUPList[0]);
    print('iiiiii ITEM_GROUPList ii ' + ITEM_GROUPList.length.toString());
   });
}

int GROUP_ID = 0;
int getGroupID({
  required String NAME,
}) {
  ITEM_GROUPList.forEach((element) {
    print(element);
    if (element.GROUP_NAME == NAME) {
      GROUP_ID = element.ITEM_GROUP_ID!;
    }
  });
  print('       GROUP_ID         ' + GROUP_ID.toString());
  return GROUP_ID;
}


// List<ITEM_Model> ITEM_ModelList = [];
// getItems(database) async {
//   ITEM_ModelList = [];
//   print('     ITEM_ModelList.length ' + ITEM_ModelList.length.toString());
//   database.rawQuery('SELECT * FROM MobPosItem').then((value) {
//     value.forEach((element) {
//       ITEM_Model itemModel = ITEM_Model.fromJson(element);
//       ITEM_ModelList.add(itemModel);
//     });
//     print('   ITEM_ModelList.length   ' + ITEM_ModelList.length.toString());
//   });
// }
//


bool updateCUSTDone =false ;
 updateCUST({
  required String? NAME,
  required context,
  String? PHONE_1,
  String? PHONE_2,
  String? PHONE_3,
  String? PHONE_4,
  String? NOTES = '',
  int? CITY,
  int? REGION,
   String? CityName  ,
   String CityRegionName ='' ,
  String? Address,
  AMOUNT_PAID = 0.0,
  MAX_DEBT_LIMT = 0.0,
  required int id
})async
{updateCUSTDone =false ;
  await database.rawUpdate('UPDATE MobPosCustVen SET status = ? , AmountPaid =? ,Name =? ,Phone1 =? ,Phone2 =? ,Phone3 =?,Phone4 =?, Address =? ,'
      'Remark =? ,CityId =? ,RegionId =? ,MaxDebtLimt =? , CityName = ? ,CityRegionName = ?  WHERE CustVenId =? ',
      ['new',AMOUNT_PAID,NAME , PHONE_1 , PHONE_2 , PHONE_3, PHONE_4, Address, NOTES, CITY , REGION , MAX_DEBT_LIMT , CityName , CityRegionName ,id])
      .then((value)
  {
    getCUST(database);
    updateCUSTDone =true ;
    Future.delayed(const Duration(milliseconds: 30), () async {
      posCubit.get(context).Search_CUST(CUSTNAME: '');
    });
    posCubit.get(context).Search_CUST(CUSTNAME: '');
    openmessageEditSuccess(context);
    Cache.play('m.mp3',mode: PlayerMode.LOW_LATENCY) ;
    NavigatorAndFinish(context , showCustomer());
  }).catchError((onError){
    print ('onError  INSERT MobPosCustVen   ${onError}');
    if(onError.toString().contains('failed: MobPosCustVen.Name')) {
      openmessageEXistNameSuccess(context);
    }
    if(onError.toString().contains('failed: MobPosCustVen.Phone1')) {
      openmessageEXistPhoneSuccess(context);
    }
  });
}


List<CUST_VEN_Model> CUST_ModelList = [];
CUST_VEN_Model ? Cust_Model ;
getCUST(database) async {
  CUST_ModelList = [];//CUST_ModelName = ['اضغط لتحديد عميل'];
  database.rawQuery('SELECT * FROM MobPosCustVen'
  ).then((value) async{
    value.forEach((element) async {
      CUST_VEN_Model itemModel = CUST_VEN_Model.fromJson(element);
      CUST_ModelList.add(itemModel);
    });
    print('iiiiii CUST_ModelList  ii ' + CUST_ModelList.length.toString());
    Cust_Model = CUST_ModelList [CUST_ModelList.length-1] ;
  });
}


List<STOCK_Model> STOCK_ModelList = [];
List<String> STOCK_ModelName = [];
getSTOCK({database ,bool get_InvTransfer = false }) async {
  database.rawQuery('SELECT * FROM MobPosStock').then((value) async {
    STOCK_ModelName = [];
    STOCK_ModelList = [];
    value.forEach((element) {
      STOCK_Model itemModel = STOCK_Model.fromJson(element);
      STOCK_ModelList.add(itemModel);
      STOCK_ModelName.add(itemModel.STOCK_NAME.toString());
      });
    if(get_InvTransfer) {
      await getInvTransferOutdata(LeId: LE_ID!);
      await getInvTransferIndata(LeId: LE_ID!);
    }
    print(STOCK_ModelList[0]);
    print('STOCK_ModelList  ii ' + STOCK_ModelList.length.toString());

  });
}

List<OUTGOINGS_Model> OUTGOINGS_ModelList = [];
getOUTGOINGS(database) async {
  OUTGOINGS_ModelList = [];
  database.rawQuery('SELECT * FROM MobPosExpense').then((value) {
    value.forEach((element) {
      OUTGOINGS_Model itemModel = OUTGOINGS_Model.fromJson(element);
      OUTGOINGS_ModelList.add(itemModel);
      // print('////////////////////////// //////////////////////        ///////////////////////////      ///////////////////////'
      //     '     /////  OUTGOINGS_ID         ' + itemModel.OUTGOINGS_ID.toString() );
    });
    print(OUTGOINGS_ModelList[0]);
    print('OUTGOINGS_ModelList  ii ' + OUTGOINGS_ModelList.length.toString());
  });
}

List<TREASURY_Model> TREASURY_ModelList = [];
getPOS_TREASURY({database,bool getCashTransfer = false}) async {
  TREASURY_ModelList = [];
  database.rawQuery('SELECT * FROM MobPosTreasury').then((value) async {
    value.forEach((element) {
      TREASURY_Model itemModel = TREASURY_Model.fromJson(element);

      TREASURY_ModelList.add(itemModel);
      // print('////////////////////////// //////////////////////        ///////////////////////////      ///////////////////////'
      //     '     /////  TREASURY_ID         ' + itemModel.TreasuryId.toString() );

    });
    if(getCashTransfer){
      await getCashTransferOutdata(LeId: LE_ID!);
      await getCashTransferIndata(LeId: LE_ID!);
    }
    print(TREASURY_ModelList[0]);
    print('TREASURY_ModelList  ii ' + TREASURY_ModelList.length.toString());
  });
}


List<PAYMENT_METHOD_Model> PAYMENT_METHOD_ModelList = [];
getPOS_PAYMENT_METHOD(database) async {
  PAYMENT_METHOD_ModelList = [];
  database.rawQuery('SELECT * FROM MobPosPaymentMethod').then((value) {
    value.forEach((element) {
      PAYMENT_METHOD_Model itemModel = PAYMENT_METHOD_Model.fromJson(element);

      PAYMENT_METHOD_ModelList.add(itemModel);
      print('////////////////////////// //////////////////////        ///////////////////////////      ///////////////////////'
          '     /////  PAYMENT_METHOD_ID         ' + itemModel.PAYMENT_METHOD_ID.toString() );
    });
    print(PAYMENT_METHOD_ModelList);
    print(
        'MobPosPaymentMethod  ii ' + PAYMENT_METHOD_ModelList.length.toString());
  });
}


List<InvoiceItemModel>? ITEM_Modle=[];

INVOICE_Model ? INVOICE_model  ;
List<INVOICE_Model> INVOICE_ModelList = [];
List<INVOICE_Model> INVOICE_ModelListReversed = [];
getINVOICE({database, context}) async {
  database.rawQuery('SELECT  MobPosInvoice.*  , MobPosCustVen.Name  FROM MobPosInvoice '
      'JOIN  MobPosCustVen ON MobPosInvoice.CustVenId = MobPosCustVen.CustVenId').then((value) {
    INVOICE_ModelList = [];
    value.forEach((element) {
     INVOICE_Model itemModel =INVOICE_Model.fromJson(element);
       INVOICE_ModelList.add(itemModel);
       print(element);
    });
    if(INVOICE_ModelList.length > 0)
       INVOICE_model = INVOICE_ModelList[INVOICE_ModelList.length-1] ;
    print(INVOICE_ModelList[0].INVOICE_DATE);
    print('   INVOICE_ModelList.length  ' + INVOICE_ModelList.length.toString());
    INVOICE_ModelListReversed = INVOICE_ModelList.reversed.toList();
  });
  if( context != null ) {
    posCubit.get(context).insertInvoiceItems();
  }
}


List<InvoiceItemModel> MobPosInvoiceItemModelList = [];
getInvoiceItem(database) async {
  print('  MobPosInvoiceItemModelList  ' + MobPosInvoiceItemModelList.length.toString());
  database.rawQuery('SELECT MobPosInvoiceItem.* , MobPosInv_Uom.UomName , MobPosInv_Uom.StandConvFactor  FROM MobPosInvoiceItem'
      ' JOIN  MobPosInv_Uom ON MobPosInvoiceItem.UomId = MobPosInv_Uom.UomId').then((value) async {
    MobPosInvoiceItemModelList = [];
    await value.forEach((element) {
      print('element MobPosInvoiceItem '+' ${element}');
      InvoiceItemModel itemModel = InvoiceItemModel.fromJson(element);
      MobPosInvoiceItemModelList.add(itemModel);
    });
    print('MobPosInvoiceItemModelList   ' + MobPosInvoiceItemModelList.length.toString());
  });
}


List<UserModel> POS_USER_ModelList = [];
getPOS_USER(database) async {
  POS_USER_ModelList = [];
  database.rawQuery('SELECT * FROM MobPosUser').then((value) {
    value.forEach((element) {
      UserModel itemModel = UserModel.fromJson(element);
      POS_USER_ModelList.add(itemModel);
    });
    print('  POS_USER_ModelList.length  ' + POS_USER_ModelList.length.toString());
  });
}


List<InvTransferIn_Model> InvTransferIn_ModelList = [];
getInvTransferIn(database) async {
  InvTransferIn_ModelList = [];
  database.rawQuery('SELECT * FROM MobPosInvTransferIn').then((value) {
    value.forEach((element) async {
      print(element);
      InvTransferIn_Model invTransferInModel = InvTransferIn_Model.fromJson(element);
      InvTransferIn_ModelList.add(invTransferInModel);
     });
    print('  InvTransferIn_ModelList.length  ' + InvTransferIn_ModelList.length.toString());
  });
}


List<InvTransferOut_Model> InvTransferOut_ModelList = [];
getInvTransferOut(database) async {
  InvTransferOut_ModelList = [];
  database.rawQuery('SELECT * FROM MobPosInvTransferOut').then((value) async {
    value.forEach((element) async {
      print(element);
      InvTransferOut_Model InvTransferOutModel = InvTransferOut_Model.fromJson(element);
      InvTransferOut_ModelList.add(InvTransferOutModel);
       });
    print('    InvTransferOut_ModelList.length   ' + InvTransferOut_ModelList.length.toString());
  });
}


List<CashTransferIn_Model> CashTransferIn_ModelList = [];
getCashTransferIn(database) async {
  CashTransferIn_ModelList = [];
  print('  CashTransferIn_ModelList.length ' + CashTransferIn_ModelList.length.toString());
  // emit(Loading_getdatabase());
  database.rawQuery('SELECT * FROM MobPosCashTransferIn').then((value) {
    value.forEach((element) async {
    //  print(element);
      CashTransferIn_Model CashTransferInModel = CashTransferIn_Model.fromJson(element);
      CashTransferIn_ModelList.add(CashTransferInModel);
    });
    print('  CashTransferIn_ModelList.length  ii ' + CashTransferIn_ModelList.length.toString());
  });
}


List<CashTransferOut_Model> CashTransferOut_ModelList = [];
getCashTransferOut(database) async {
  database.rawQuery('SELECT * FROM MobPosCashTransferOut').then((value) {
    CashTransferOut_ModelList = [];
    value.forEach((element) async {
     // print(element);
      CashTransferOut_Model itemModel = CashTransferOut_Model.fromJson(element);
      CashTransferOut_ModelList.add(itemModel);
    });
    print('   CashTransferOut_ModelList.length   ' + CashTransferOut_ModelList.length.toString());
   // getCach_transDetails(database);
  });
}

List<CashInOut_Model> CashInOut_ModelList = [];
getCashInOut(database) async {
  CashInOut_ModelList = [];
  print('iiiiii  CashInOut_ModelList  ' + CashInOut_ModelList.length.toString());
  database.rawQuery('SELECT MobPosCashInOut.* ,  MobPosPaymentMethod.PaymentMethodName , MobPosTreasury.TreasuryName '
    'FROM MobPosCashInOut '
      ' JOIN  MobPosTreasury ON MobPosCashInOut.TreasuryId = MobPosTreasury.TreasuryId '
      ' JOIN  MobPosPaymentMethod ON MobPosCashInOut.PaymentMethodId = MobPosPaymentMethod.PaymentMethodId '
   ).then((value) {
    CashInOut_ModelList = [];
    value.forEach((element) {
    //  print(element);
      CashInOut_Model itemModel = CashInOut_Model.fromJson(element);
      CashInOut_ModelList.add(itemModel);
    });
   print('            CashInOut_ModelList.length             ' + CashInOut_ModelList.length.toString());
  });
}


List<CashInOut_Model> CashTransInOut_ModelList = [];
List<CashInOut_Model> CashTransInOut_ModelList_Invers = [];
getCach_transDetails({database,required String TreasuryName, context,text}) async {
  dynamic  V_AmountAfterOperation =0 ;
  getCount_Cach_transDetails(database);
  CashTransInOut_ModelList = [];
  database.rawQuery('SELECT  amount as Amount  ,TreasuryId ,TreasuryName ,DocDate , Remark , TransType ,  CustVenId ,  DocDate_INT'
      '   FROM Cach_trans_v  where  TreasuryName = "${TreasuryName}"  order by DocDate_INT ' //,sum(amount)AmountAfterOperation // group by TreasuryId ,DocDate, TransType , Remark , CustVenId ,InvoiceId,ExpenseId,TreasuryName
  ).then((value) async {  //  ExpenseId,  CustVenId ,InvoiceId ,
   // CashTransInOut_ModelList = [];
   await   value.forEach((element) {
          print(element);
        CashInOut_Model itemModel =CashInOut_Model.fromJson(element);
        if(itemModel.TransType == 'اضافة' || itemModel.TransType == 'IN') {
        V_AmountAfterOperation += (itemModel.Amount as double);
      }
        else  V_AmountAfterOperation -= (itemModel.Amount as double);
            itemModel.AmountAfterOperation = V_AmountAfterOperation ;
           print(itemModel.AmountAfterOperation);
        CashTransInOut_ModelList.add(itemModel);
      });
      print('         CashTransInOut_ModelList.length           ' + CashTransInOut_ModelList.length.toString());
      CashTransInOut_ModelList_Invers = CashTransInOut_ModelList.reversed.toList();
    if(context != null || text !=  null)
    {
      await    posCubit.get(context).getCashInOutSearch(TREASURYNme:posCubit.get(context).valBanks_TreasuryReport,date:text );
    }
  }
  );
}

getCount_Cach_transDetails(database) async {
  CashTransInOut_ModelList = [];
  database.rawQuery('SELECT  Count (amount) FROM Cach_trans_v ' //
  ).then((value) {
    print('Count (amount) ${value[0]['Count (amount)']}');
      });
      print('            CashTransInOut_ModelList.length            ' + CashTransInOut_ModelList.length.toString());
      CashTransInOut_ModelList_Invers = CashTransInOut_ModelList.reversed.toList();
}

List<Stock_Details_Model>  Stock_Details_List =[] ;
getStock_Details({database,required String StockName ,required context }) async {
  database.rawQuery('SELECT  StockName , ItemName ,SalesPrice1 , sum(qty) Quantity   '
      'FROM Stock_trans_v  Where  StockName = "$StockName"  group by  StockName , ItemName ,SalesPrice1  '
  ).then((value) {
    Stock_Details_List = [];
    value.forEach((element) {
      Stock_Details_Model itemModel =Stock_Details_Model.fromJson(element);
      Stock_Details_List.add(itemModel);
      //  print(element);
    });
    posCubit.get(context).changevalStock_DetailsDropdown(StockName);
    print('iiiiii sum(qty) Quantity  eeeeeeeee ' + Stock_Details_List.length.toString());
  }
  );
}


String ExpenseName ='' ;
getCashInOut_ExpenseName(id) async {
  database.rawQuery('SELECT ExpenseName FROM MobPosExpense '
       'WHERE ExpenseId = ${id}'  ).then((value) {
         print (value[0]['ExpenseName']);
         ExpenseName= value[0]['ExpenseName'] as String ;
  });
}


String CustVenName ='' ;
getCashInOut_CustVenName(id) async {
  database.rawQuery('SELECT Name FROM MobPosCustVen '
   ' WHERE CustVenId = ${id}' ).then((value) {
     print(value[0]['Name']);
     CustVenName = value[0]['Name'] as String ;
    });
}


List<Location_Model>  Gps_List =[] ;
getGps(database) async {
  database.rawQuery('SELECT * FROM MobPosGps '
  ).then((value) {
    Gps_List = [];
    value.forEach((element) {
      Location_Model itemModel =Location_Model.fromJson(element);
      Gps_List.add(itemModel);
      print(element);
    });
    print('iiiiii  Gps_List ' + Gps_List.length.toString());
  });
}

List<Inv_Uom_Model>  Inv_Uom_List =[] ;
Inv_Uom_Model ? Uom_BaseUnit = Inv_Uom_Model()  ;
getInv_Uom(database)
async {
  database.rawQuery('SELECT * FROM MobPosInv_Uom '
  ).then((value) {
    Inv_Uom_List = [];
    value.forEach((element) {
      Inv_Uom_Model itemModel =Inv_Uom_Model.fromJson(element);
      if(itemModel.BaseUnit == 1 ) {
        Uom_BaseUnit =  itemModel ;
      }
      Inv_Uom_List.add(itemModel);
      print(element);
    });
    print('iiiiii  Inv_Uom_List ' + Inv_Uom_List.length.toString());
  });
}


List<InventoryCount>  InventoryCount_List =[] ;
getInventoryCount(database) async {

  database.rawQuery('SELECT * FROM MobPosInventoryCount '
  ).then((value) {
    InventoryCount_List = [];
    value.forEach((element) {
      InventoryCount itemModel =InventoryCount.fromJson(element);
      InventoryCount_List.add(itemModel);
      print(element);
    });
    print('iiiiii  InventoryCount_List ' + InventoryCount_List.length.toString());
  });
}

List<SellOrderDelivery>  SellOrderDelivery_List =[] ;
getSellOrderDelivery(database) async {

  database.rawQuery('SELECT * FROM MobPosSellOrderDelivery '
  ).then((value) {
    SellOrderDelivery_List = [];
    value.forEach((element) {
      SellOrderDelivery itemModel =SellOrderDelivery.fromJson(element);
      SellOrderDelivery_List.add(itemModel);
      print(element);
    });
    print('iiiiii  SellOrderDelivery_List ' + SellOrderDelivery_List.length.toString());
  });
}

SalesOrders ? SalesOrder  ;
List<SalesOrders> SalesOrderList = [];
getSalesOrder({database, context}) async {
  database.rawQuery('SELECT  MobPosInvoice.*  , MobPosCustVen.Name  FROM MobPosSalesOrder '
      'JOIN  MobPosCustVen ON MobPosSalesOrder.CustVenId = MobPosCustVen.CustVenId ').then((value) {
    SalesOrderList = [];
    value.forEach((element) {
      SalesOrders itemModel =SalesOrders.fromJson(element);
      SalesOrderList.add(itemModel);
      // print('               eeeeeee            ');
      print(element);
    });
    if(SalesOrderList.length > 0)
      SalesOrder = SalesOrderList[SalesOrderList.length-1] ;
    print(SalesOrderList[0].INVOICE_DATE);
    print('iiiiii  ii ' + SalesOrderList.length.toString());
  });
  if( context != null ) {
    posCubit.get(context).insertInvoiceItems_SO(S_O: 'S_O');
  }
}


GetAllData_DB()async
{
  // await getStockInOut(database);
  await getInv_Uom(database);
  await getMobPosCity(database);
  await getMobPosCity_REGION(database);
  await getGroup(database);
//  await getItems(database);
  await getCUST(database);
  await getPOS_PAYMENT_METHOD(database);
  await getPOS_USER(database);
  await getPOS_TREASURY(database: database);
  await getOUTGOINGS(database);
  await getINVOICE(database: database);
  await getSTOCK(database: database);
  await getCashInOut(database);
  await getCashTransferOut(database);
  await getCashTransferIn(database);
  await getInvTransferIn(database);
  await getInvTransferOut(database);
  await getInvoiceItem(database);
  // Future.delayed(Duration(seconds: 4),() async {
  //   //await getStock_Details(database);
  //   //  await getCach_transDetails(database);
  // });
}

import 'package:intl/intl.dart';
import 'package:pos/DataBase/DataBase.dart';
import 'package:pos/DataBase/getDB.dart';

import '../modules/registerscreen.dart';
import '../shared/Content.dart';

bool insertGroupS = false;

insertGroup(
    {required String GROUP_NAME,
    GroupItemId,
    String? status,
    UserId,
    LE_ID}) async {
  insertGroupS = false;

  await database.transaction((txn) => txn
          .rawInsert(
              'INSERT INTO MobPosItemGroup(GroupItemId,GrpName,LeId,UserId,status) VALUES($GroupItemId,"$GROUP_NAME",$LE_ID,$UserId,"$status")')
          .then((value) {
        print('$value inserted');
        insertGroupS = true;
        print(insertGroupS);
        //  getGroup(database);
      }));
}

bool insertItemsS = false;

insertItems({
  required String? ITEM_NAME,
  String? BARCODE = '  ',
  required SALES_PRICE1,
  SALES_PRICE2,
  SALES_PRICE3,
  String? NODES = '  ',
  required String status,
  GROUP_ID,
  ItemId,
  required QUANTITY,
  required LE_ID,
  required UserId,
}) async {
  insertItemsS = false;
  if (ItemId == null) {
    var result = await database.rawQuery('SELECT MAX(ItemId) FROM  MobPosItem');
    print(result);
    result[0]["MAX(ItemId)"] == null
        ? ItemId = 1
        : ItemId = (result[0]["MAX(ItemId)"] as int) + 1;
  }
  await database.transaction((txn) => txn
          .rawInsert(
              'INSERT INTO MobPosItem(ItemId,ItemName,Barcode,SalesPrice1,SalesPrice2,SalesPrice3,Nodes,GroupItemId,LeId,Quantity,status,UserId) '
              'VALUES($ItemId , "$ITEM_NAME","$BARCODE",$SALES_PRICE1,$SALES_PRICE2,$SALES_PRICE3,"$NODES",$GROUP_ID,$LE_ID,$QUANTITY,"$status",$UserId)')
          .then((value) {
        print('$value inserted');

        insertItemsS = true;
        //  getItems(database);
      }));
}

bool insertCUSTS = false;

insertCUST(
    {required String? NAME,
    required context,
    int? CUST_VEN_CODE,
    String? PHONE_1,
    String? PHONE_2,
    String? PHONE_3,
    String? PHONE_4,
    String? NOTES = '  ',
    int? CITY,
    int? REGION,
    String? Address,
    AMOUNT_PAID = 0.0,
    MAX_DEBT_LIMT = 0.0}) async {
  insertCUSTS = false;
  String CityName = '';
  String CityRegionName = '';
  if (CITY != null) {
    await database
        .rawQuery('SELECT CityName FROM MobPosCity WHERE CityId =${CITY}')
        .then((v) {
      print(v);
      CityName = v[0]['CityName'] as String;
    });
  }
  if (REGION != null) {
    await database
        .rawQuery(
            'SELECT CityRegionName FROM MobPosCityRegion  WHERE CityRegionId =${REGION}')
        .then((v) {
      print(v);
      CityRegionName = v[0]['CityRegionName'] as String;
    });
  }
  var result =
      await database.rawQuery('SELECT MAX(CustVenCode) FROM  MobPosCustVen');
  print(result);
  result[0]["MAX(CustVenCode)"] == null
      ? CUST_VEN_CODE = 1
      : CUST_VEN_CODE = (result[0]["MAX(CustVenCode)"] as int) + 1;

  await database
      .transaction((txn) => txn
              .rawInsert(
                  'INSERT INTO MobPosCustVen(Name,CityName,CityRegionName,CustVenCode,Phone1,Phone2,Phone3,Phone4,Address,Remark,CityId,LeId,RegionId,AmountPaid,MaxDebtLimt,UserId,status) '
                  'VALUES("$NAME" , "$CityName" , "$CityRegionName" , $CUST_VEN_CODE,"$PHONE_1","$PHONE_2","$PHONE_3","$PHONE_4","$Address","$NOTES",$CITY,$LE_ID,$REGION,$AMOUNT_PAID,$MAX_DEBT_LIMT,$UserId,"new")')
              .then((value) async {
            print('$value inserted');

            insertCUSTS = true;
            print(insertCUSTS);
            openmessageCustSuccess(context);
            await getCUST(database);
          }))
      .catchError((onError) {
    print('onError  INSERT MobPosCustVen   ${onError}');
    if (onError.toString().contains('failed: MobPosCustVen.Name')) {
      openmessageEXistNameSuccess(context);
    }
    if (onError.toString().contains('failed: MobPosCustVen.Phone1')) {
      openmessageEXistPhoneSuccess(context);
    }
  });
}

bool insertINVOICES = false;

insertINVOICE(
    {context,
    int? CustVenId,
    required String? INVOICE_DATE,
    int? TREASURY_ID,
    int? PAYMENT_METHOD_ID,
    int? InvoiceType,
    int? STOCK_ID,
    double? PRICE,
    double? OFFER,
    double? Remaind,
    Paid = 0.0,
    double? VALUE}) async {
  insertINVOICES = false;
  String INVOICEDATE = DateFormat('dd/MM/yyyy')
      .format(DateTime.now())
      .toString(); //'dd/MM/yyyy hh:mm:ss a'
  print(INVOICEDATE);
  var InvoiceNo;

  var result =
      await database.rawQuery('SELECT MAX(InvoiceNo) FROM  MobPosInvoice ');
  print(result);
  InvoiceNo = result[0]["MAX(InvoiceNo)"];
  if (InvoiceNo == null)
    InvoiceNo = 1;
  else
    InvoiceNo += 1;
  print(InvoiceNo);

  await database.transaction((txn) => txn
          .rawInsert(
              'INSERT INTO MobPosInvoice(InvoiceDate,CustVenId,PaymentMethodId,TreasuryId,StockId,InvoiceType,LeId,Price,Discount,Value,Paid,Remaind,UserId,InvoiceNo,status) '
              'VALUES("$INVOICEDATE",$CustVenId,$PAYMENT_METHOD_ID,$TREASURY_ID,$STOCK_ID,$InvoiceType,$LE_ID,$PRICE,$OFFER,$VALUE,$Paid,$Remaind,$UserId,${InvoiceNo},"new")')
          .then((value) async {
        print('$value inserted');
        insertINVOICES = true;
        print('insertINVOICES  ' + insertINVOICES.toString());
        await getINVOICE(database: database, context: context);
      }));
}

bool inout = false;

insertCashInOut({
  int? CustVenId,
  String? DocDate,
  int? PaymentMethodId,
  int? TreasuryId,
  double? Amount,
  String? TransType,
  String? Remark,
  String? status,
  int? ExpenseId,
  int? InvoiceId,
  required bool Add,
}) async {
  inout = false;
  String Doc_Date =
      DateFormat('yyyy-MM-dd').format(DateTime.parse(DocDate!)).toString();
  int DocDate_INT = int.parse(Doc_Date.toString().replaceAll('-', ''));
  print('Doc_Date   $Doc_Date');
  await database.transaction((txn) => txn
          .rawInsert(
              'INSERT INTO MobPosCashInOut(DocDate_INT,DocDate,CustVenId,TreasuryId,ExpenseId,InvoiceId,PaymentMethodId,Amount,TransType,Remark,status,LeId,UserId) '
              'VALUES($DocDate_INT,"$Doc_Date",$CustVenId,$TreasuryId,$ExpenseId,$InvoiceId,$PaymentMethodId,$Amount,"$TransType","$Remark","$status",$LE_ID,$UserId)')
          .then((value) {
        print('${InvoiceId} inserted  MobPosCashInOut');
        print('$value inserted  MobPosCashInOut');
        inout = true;
      }));
  getCashInOut(database);
}

insertGps({
  int? UserId,
  String? DeviceId,
  String? Tim,
  String? X,
  String? Y,
}) async {
  await database.transaction((txn) => txn
          .rawInsert(
              'INSERT INTO MobPosGps(DeviceId,Tim,UserId,X,Y,LeId,status) '
              'VALUES("$DeviceId","$Tim",$UserId,"$X","$Y",$LE_ID,"new")')
          .then((value) async {
        print('$value inserted');

        await getGps(database);
      }));
}

bool insertInvCount = false;

insertInventoryCount({
  String? InventoryCountDate,
  int? StockId,
  String? Barcode,
  int? Quantity,
}) async {
  insertInvCount = false;
  await database.transaction((txn) => txn
          .rawInsert(
              'INSERT INTO MobPosInventoryCount(InventoryCountDate,StockId,UserId,Barcode,Quantity,LeId,status) '
              'VALUES("$InventoryCountDate",$StockId,$UserId,"$Barcode",$Quantity,$LE_ID,"new")')
          .then((value) async {
        insertInvCount = true;
        print('$value inserted');
        await getInventoryCount(database);
      }));
}

bool insertSellDelivery = false;

insertSellOrderDelivery({
  String? DocDate,
  int? DocType, // 1 invoice - 2 sellesOrder
  String? Barcode,
}) async {
  insertSellDelivery = false;
  await database.transaction((txn) => txn
          .rawInsert(
              'INSERT INTO MobPosSellOrderDelivery(DocDate,DocType,UserId,Barcode,LeId,status) '
              'VALUES("$DocDate",$DocType,$UserId,"$Barcode",$LE_ID,"new")')
          .then((value) async {
        insertSellDelivery = true;
        print('$value inserted');
        await getSellOrderDelivery(database);
      }));
}

//
bool insertSalesOrderS = false;

insertSalesOrder(
    {context,
    int? CustVenId,
    required String? SalesOrder_DATE,
    int? TREASURY_ID,
    int? PAYMENT_METHOD_ID,
    int? SalesOrderType,
    int? STOCK_ID,
    double? PRICE,
    double? OFFER,
    double? Remaind,
    Paid = 0.0,
    double? VALUE}) async {
  insertSalesOrderS = false;
  String SalesOrderDATE = DateFormat('dd/MM/yyyy')
      .format(DateTime.now())
      .toString(); //'dd/MM/yyyy hh:mm:ss a'
  print(SalesOrderDATE);
  var SalesOrderNo;

  var result = await database
      .rawQuery('SELECT MAX(SalesOrderNo) FROM  MobPosSalesOrder ');
  print(result);
  SalesOrderNo = result[0]["MAX(SalesOrderNo)"];
  if (SalesOrderNo == null)
    SalesOrderNo = 1;
  else
    SalesOrderNo += 1;
  print(SalesOrderNo);

  await database.transaction((txn) => txn
          .rawInsert(
              'INSERT INTO MobPosSalesOrder(SalesOrderDate,CustVenId,PaymentMethodId,TreasuryId,StockId,SalesOrderType,LeId,Price,Discount,Value,Paid,Remaind,UserId,SalesOrderNo,status) '
              'VALUES("$SalesOrderDATE",$CustVenId,$PAYMENT_METHOD_ID,$TREASURY_ID,$STOCK_ID,$SalesOrderType,$LE_ID,$PRICE,$OFFER,$VALUE,$Paid,$Remaind,$UserId,${SalesOrderNo},"new")')
          .then((value) async {
        print('$value inserted');

        insertSalesOrderS = true;
        print(insertSalesOrderS);
        //MobPosSalesOrder
        await getSalesOrder(database: database, context: context);
      }));
}

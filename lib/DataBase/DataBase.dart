import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
late Database database;
createdatabase()async

{
  database = await openDatabase(
      'pos.db',
      version: 1,
      onCreate: (database,version)
      async {
        await database.execute('CREATE TABLE MobPosCustVen (CustVenId INTEGER PRIMARY KEY NOT NULL,'
            ' Name TEXT  type UNIQUE NOT NULL ,CustVenCode INTEGER ,Phone1 TEXT type UNIQUE , Phone2 TEXT ,Address TEXT , CityName TEXT , CityRegionName TEXT ,'
            ' Phone3 TEXT , Phone4 TEXT , CityId INTEGER , RegionId INTEGER, Remark TEXT , AmountPaid REAL, MaxDebtLimt REAL,'
            ' LeId INTEGER, status TEXT , UserId INTEGER , PkId INTEGER ,'
            'FOREIGN KEY(UserId)REFERENCES MobPosUser (Userid) ,'
            'FOREIGN KEY(CityId)REFERENCES MobPosCity (CityId) ,'
            'FOREIGN KEY(RegionId)REFERENCES MobPosCityRegion (CityRegionId) ) ').then(
                (value) => print('creat MobPosCustVen db'));


        await database.execute('CREATE TABLE MobPosTreasury (TreasuryId INTEGER PRIMARY KEY NOT NULL,'
            ' BranchId  INTEGER , TreasuryName TEXT NOT NULL ,TreasuryType INTEGER ,'
            'LeId INTEGER ,PaymentMethodId INTEGER , status TEXT ,'
            'FOREIGN KEY(PaymentMethodId) REFERENCES MobPosPaymentMethod (PaymentMethodId))').then(
                (value) => print('creat MobPosTreasury db'));



        await database.execute('CREATE TABLE MobPosStock (StockId INTEGER PRIMARY KEY NOT NULL, StockName TEXT NOT NULL'
            ' ,LeId INTEGER, status TEXT )').then(
                (value) => print('creat MobPosStock db'));



        await database.execute('CREATE TABLE MobPosItemGroup (GroupItemId INTEGER PRIMARY KEY NOT NULL, '
            'GrpName TEXT   ,LeId INTEGER , status TEXT , UserId INTEGER,'
            ' FOREIGN KEY(UserId) REFERENCES MobPosUser (Userid))').then(
                (value) => print('creat MobPosItemGroup db'));


        await database.execute('CREATE TABLE MobPosPaymentMethod (PaymentMethodId INTEGER PRIMARY KEY NOT NULL,'
            'PaymentMethodName TEXT NOT NULL ,LeId INTEGER , status TEXT)').then(
                (value) => print('creat MobPosPaymentMethod db'));


        await database.execute('CREATE TABLE MobPosExpense (ExpenseId INTEGER PRIMARY KEY NOT NULL,'
            'ExpenseName TEXT NOT NULL ,LeId INTEGER , status TEXT)').then(
                (value) => print('creat MobPosExpense db'));


        await database.execute('CREATE TABLE MobPosItem(ItemId INTEGER PRIMARY KEY NOT NULL, ItemName TEXT NOT NULL ,'
            'Barcode TEXT , SalesPrice1 REAL , status TEXT ,Quantity INTEGER , '
            'SalesPrice2 REAL, SalesPrice3 REAL , Nodes TEXT , GroupItemId INTEGER ,'
            'LeId INTEGER , UserId INTEGER , '
            'FOREIGN KEY(UserId)REFERENCES MobPosUser (Userid),'
            ' FOREIGN KEY(GroupItemId) REFERENCES MobPosItemGroup (GroupItemId))').then(
                (value) => print('creat MobPosItem db'));


        await database.execute('CREATE TABLE MobPosUser(Userid INTEGER PRIMARY KEY NOT NULL, UserName TEXT NOT NULL ,'
            'Password TEXT NOT NULL, CustVenMId INTEGER , status TEXT ,'
            ' Active INTEGER , LeId INTEGER, FOREIGN KEY(CustVenMId) REFERENCES MobPosCustVen (CustVenId))').then(
                (value) => print('creat MobPosUser db'));


        await database.execute('CREATE TABLE MobPosCity(CityId  INTEGER PRIMARY KEY NOT NULL ,RegionId INTEGER ,'
            'CityName TEXT , CityActive TEXT , PkId INTEGER , '
            ' CityNo  INTEGER ,UserId INTEGER , LeId INTEGER,'
            'FOREIGN KEY(UserId)REFERENCES MobPosUser (Userid))').then(
                (value) => print('creat MobPosCity db'));



        await database.execute('CREATE TABLE MobPosCityRegion(CityRegionId  INTEGER PRIMARY KEY NOT NULL ,'
            'CityId INTEGER , CityRegionName  TEXT NOT NULL,CityRegionActive TEXT,'
            'CityRegionNo TEXT , LeId INTEGER, PkId INTEGER , '
            'FOREIGN KEY(CityId) REFERENCES MobPosCity (CityId))').then(
                (value) => print('creat MobPosCityRegion db'));



        await database.execute('CREATE TABLE MobPosInvoice (InvoiceId  INTEGER PRIMARY KEY NOT NULL ,InvoiceDate TEXT NOT NULL ,'
            'CustVenId INTEGER , PaymentMethodId INTEGER ,TreasuryId INTEGER ,  StockId INTEGER , status TEXT , InvoiceNo  INTEGER ,'
            'Price  REAL, Value REAL , Discount REAL , Paid  REAL, Remaind REAL , UserId INTEGER ,LeId INTEGER , InvoiceType INTEGER ,'
            'FOREIGN KEY(TreasuryId) REFERENCES MobPosTreasury (TreasuryId),'
            'FOREIGN KEY(StockId) REFERENCES MobPosStock (StockId),'
            'FOREIGN KEY(UserId) REFERENCES MobPosUser (Userid),'
            'FOREIGN KEY(CustVenId) REFERENCES MobPosCustVen (CustVenId),'
             'FOREIGN KEY(PaymentMethodId) REFERENCES MobPosPaymentMethod (PaymentMethodId))').then(
                (value) => print('creat MobPosInvoice db')).catchError((onError){print('///////////////errors////////'+onError.toString());});

//امر بيع

        await database.execute('CREATE TABLE MobPosSalesOrder (SalesOrderId  INTEGER PRIMARY KEY NOT NULL ,SalesOrderDate TEXT NOT NULL ,'
            'CustVenId INTEGER , PaymentMethodId INTEGER ,TreasuryId INTEGER,  StockId INTEGER , status TEXT , SalesOrderNo  INTEGER ,'
            'Price  REAL, Value REAL , Discount REAL , Paid  REAL, Remaind REAL , UserId INTEGER ,LeId INTEGER , SalesOrderType INTEGER ,'
            'FOREIGN KEY(TreasuryId) REFERENCES MobPosTreasury (TreasuryId),'
            'FOREIGN KEY(StockId) REFERENCES MobPosStock (StockId),'
            'FOREIGN KEY(UserId) REFERENCES MobPosUser (Userid),'
            'FOREIGN KEY(CustVenId) REFERENCES MobPosCustVen (CustVenId),'
            'FOREIGN KEY(PaymentMethodId) REFERENCES MobPosPaymentMethod (PaymentMethodId))').then(
                (value) => print('creat MobPosSalesOrder db')).catchError((onError){print('///////////////errors////////'+onError.toString());});

//InventoryCount


        await database.execute('CREATE TABLE MobPosInventoryCount (InventoryCountId  INTEGER PRIMARY KEY NOT NULL ,InventoryCountDate TEXT NOT NULL ,'
              ' StockId INTEGER ,Barcode TEXT , Qr TEXT , status TEXT ,Quantity INTEGER , UserId INTEGER ,LeId INTEGER ,'
            'FOREIGN KEY(StockId) REFERENCES MobPosStock (StockId),'
            'FOREIGN KEY(UserId) REFERENCES MobPosUser (Userid))').then(
                (value) => print('creat MobPosInventoryCount db')).catchError((onError){print('///////////////errors////////'+onError.toString());});

//SellOrderDelivery  تسليم

        await database.execute('CREATE TABLE MobPosSellOrderDelivery (DocId  INTEGER PRIMARY KEY NOT NULL ,DocDate TEXT NOT NULL , DocType INTEGER '
            ' Barcode TEXT , Qr TEXT , status TEXT , UserId INTEGER ,LeId INTEGER ,DocNo  INTEGER )').then(
                (value) => print('creat MobPosDoc db')).catchError((onError){print('///////////////errors////////'+onError.toString());});



//InvoiceItem

        await database.execute('CREATE TABLE MobPosInvoiceItem ( InvoiceItemId INTEGER PRIMARY KEY NOT NULL ,ItemId  INTEGER , SalesOrderId INTEGER ,'
            'ItemName TEXT NOT NULL , Barcode TEXT , status TEXT  ,InvoiceId INTEGER , S_O TEXT , '
            'Price  REAL, Total REAL , UserId INTEGER ,LeId INTEGER , UomId INTEGER , UomQuantity REAL , Quantity INTEGER , '
            'FOREIGN KEY(UserId) REFERENCES MobPosUser (Userid),'
            'FOREIGN KEY(InvoiceId) REFERENCES MobPosInvoice (InvoiceId))').then(
                (value) => print('creat MobPosInvoiceItem db')).catchError((onError){print('///////////////errors////////'+onError.toString());});



        await database.execute('CREATE TABLE MobPosInvTransferIn (TransferId  INTEGER ,'
            'DocDate TEXT NOT NULL  , status TEXT  ,ItemId INTEGER ,GroupId INTEGER ,'
            ' Stockid INTEGER ,LeId INTEGER , Quantity INTEGER NOT NULL ,PkId INTEGER ,'
            'FOREIGN KEY(Stockid) REFERENCES MobPosStock (StockId),'
            'FOREIGN KEY(ItemId) REFERENCES MobPosItem (ItemId),'
            ' FOREIGN KEY(GroupId) REFERENCES MobPosItemGroup (GroupItemId))').then(
                (value) => print('creat MobPosInvTransferIn db')).catchError((onError){print('///////////////errors////////'+onError.toString());});



        await database.execute('CREATE TABLE MobPosInvTransferOut (TransferId  INTEGER ,'
            'DocDate TEXT NOT NULL  , status TEXT  ,ItemId INTEGER ,GroupId INTEGER ,'
            ' Stockid INTEGER ,LeId INTEGER , Quantity INTEGER NOT NULL , PkId INTEGER ,'
            'FOREIGN KEY(Stockid) REFERENCES MobPosStock (StockId),'
            'FOREIGN KEY(ItemId) REFERENCES MobPosItem (ItemId),'
            ' FOREIGN KEY(GroupId) REFERENCES MobPosItemGroup (GroupItemId))').then(
                (value) => print('creat MobPosInvTransferOut db')).catchError((onError){print('///////////////errors////////'+onError.toString());});




        await database.execute('CREATE TABLE MobPosCashTransferIn (TransferId  INTEGER ,'
            'DocDate TEXT NOT NULL  , status TEXT  ,Amount REAL NOT NULL , Remark TEXT ,ExpenseId INTEGER , DocDate_INT INTEGER,'
            ' TreasuryId INTEGER ,LeId INTEGER ,PkId INTEGER ,TransType TEXT ,CustVenId INTEGER , InvoiceId INTEGER , '
            'FOREIGN KEY(TreasuryId) REFERENCES MobPosTreasury (TreasuryId))').then(
                (value) => print('creat MobPosCashTransferIn db')).catchError((onError){print('///////////////errors////////'+onError.toString());});



        await database.execute('CREATE TABLE MobPosCashTransferOut (TransferId  INTEGER ,'
            'DocDate TEXT NOT NULL  , status TEXT  ,Amount REAL NOT NULL,TransType TEXT ,Remark TEXT ,ExpenseId INTEGER ,'
            ' TreasuryId INTEGER ,LeId INTEGER , PkId INTEGER ,CustVenId INTEGER , InvoiceId INTEGER ,DocDate_INT INTEGER,'
            'FOREIGN KEY(TreasuryId) REFERENCES MobPosTreasury (TreasuryId))').then(
                (value) => print('creat MobPosCashTransferOut db')).catchError((onError){print('///////////////errors////////'+onError.toString());});



        await database.execute('CREATE TABLE MobPosCashInOut (CashInOutId  INTEGER PRIMARY KEY NOT NULL ,'
            'DocDate TEXT NOT NULL , CustVenId INTEGER , PaymentMethodId INTEGER ,TreasuryId INTEGER ,'
            ' status TEXT , Amount  REAL , TransType TEXT , Remark  TEXT, LeId INTEGER ,AmountAfterOperation REAL,'
            ' ExpenseId INTEGER , InvoiceId  INTEGER , UserId INTEGER , PkId INTEGER , DocDate_INT INTEGER,'
            'FOREIGN KEY(TreasuryId) REFERENCES MobPosTreasury (TreasuryId), '
            'FOREIGN KEY(CustVenId) REFERENCES MobPosCustVen (CustVenId),'
            'FOREIGN KEY(InvoiceId) REFERENCES MobPosInvoice (InvoiceId),'
            'FOREIGN KEY(UserId) REFERENCES MobPosUser (Userid),'
            'FOREIGN KEY(ExpenseId) REFERENCES MobPosExpense (ExpenseId),'
            'FOREIGN KEY(PaymentMethodId) REFERENCES MobPosPaymentMethod (PaymentMethodId))').then(
                (value) => print('creat MobPosCashInOut db')).catchError((onError){print('///////////////errors////////'+onError.toString());});



        await database.execute('CREATE TABLE MobPosAccessButton (UserId  INTEGER PRIMARY KEY NOT NULL ,'
            'InvoiceSales  NOT NULL , Cash INTEGER ,  LeId INTEGER  ,'
            'FOREIGN KEY(UserId) REFERENCES MobPosUser (Userid))').then(
                (value) => print('creat MobPosAccessButton db')).catchError((onError){print('///////////////errors////////'+onError.toString());});



        await database.execute('CREATE TABLE MobPosStockInOut (StockInOutId  INTEGER PRIMARY KEY NOT NULL ,'
            '  ItemId INTEGER , StockId INTEGER ,LeId INTEGER , Quantity INTEGER , GroupId INTEGER , '
            'FOREIGN KEY(StockId) REFERENCES MobPosStock (StockId),'
            'FOREIGN KEY(ItemId) REFERENCES MobPosItem (ItemId),'
            ' FOREIGN KEY(GroupId) REFERENCES MobPosItemGroup (GroupItemId) )').then(
                (value) => print('creat MobPosStockInOut db')).catchError((onError){print('///////////////errors////////'+onError.toString());});


        await database.execute('CREATE TABLE MobPosUsrSec (UserId INTEGER NOT NULL ,'
            '   DeviceId  TEXT , Active INTEGER ,status TEXT , LeId INTEGER , '
            'FOREIGN KEY(UserId) REFERENCES MobPosUser (Userid))').then(
                (value) => print('creat MobPosUsrSec db')).catchError((onError){print('///////////////errors////////'+onError.toString());});



        await database.execute('CREATE TABLE MobPosGps (GpsId INTEGER PRIMARY KEY NOT NULL , UserId INTEGER NOT NULL ,'
            '   DeviceId  TEXT , Tim TEXT ,X TEXT , Y TEXT ,status TEXT , LeId INTEGER ,'
            'FOREIGN KEY(UserId) REFERENCES MobPosUser (Userid))').then(
                (value) => print('creat MobPosUsrSec db')).catchError((onError){print('///////////////errors////////'+onError.toString());});



        await database.execute('CREATE TABLE MobPosInv_Uom (UomId INTEGER PRIMARY KEY NOT NULL , UomName TEXT , UomNameL  TEXT'
            '  , UomAbbreviation  TEXT , StandConvFactor INTEGER ,BaseUnit INTEGER , Inactive INTEGER ,UserId INTEGER , LeId INTEGER ,'
            'FOREIGN KEY(UserId) REFERENCES MobPosUser (Userid))').then(
                (value) => print('creat MobPosInv_Uom db')).catchError((onError){print('///////////////errors////////'+onError.toString());});



        await database.execute('CREATE VIEW Stock_trans_v  as   SELECT Quantity *-1  as qty  ,ItemId , StockId,'
            ' (select ItemName from MobPosItem WHERE MobPosItem.ItemId = MobPosInvoiceItem.ItemId ) as ItemName '
            ', (select SalesPrice1 from MobPosItem WHERE MobPosItem.ItemId= MobPosInvoiceItem.ItemId ) as SalesPrice1 '
            ', (select StockName from MobPosStock WHERE MobPosStock.StockId= MobPosInvoice.StockId ) as StockName   from  MobPosInvoice , MobPosInvoiceItem '
            ' where MobPosInvoice.InvoiceId =MobPosInvoiceItem.InvoiceId AND  InvoiceType = 1 '
            'UNION ALL '
            'SELECT   Quantity as qty  ,ItemId , StockId , '
            '(select ItemName from MobPosItem WHERE  MobPosItem.ItemId= MobPosInvoiceItem.ItemId ) as ItemName  '
            ',(select SalesPrice1 from MobPosItem WHERE MobPosItem.ItemId= MobPosInvoiceItem.ItemId ) as SalesPrice1 '
            ' , (select StockName from MobPosStock WHERE MobPosStock.StockId= MobPosInvoice.StockId ) as StockName  from  MobPosInvoice , MobPosInvoiceItem  '
            'where MobPosInvoice.InvoiceId = MobPosInvoiceItem.InvoiceId  AND InvoiceType  = 2 '
            'UNION ALL '
            ' SELECT   Quantity as qty  ,ItemId , Stockid , '
            '(select ItemName from MobPosItem where MobPosItem.ItemId= MobPosInvTransferIn.ItemId ) as ItemName '
            ',(select SalesPrice1 from MobPosItem where MobPosItem.ItemId= MobPosInvTransferIn.ItemId ) as SalesPrice1 '
            ', (select StockName from MobPosStock where MobPosStock.StockId= MobPosInvTransferIn.StockId ) as StockName  from  MobPosInvTransferIn'
            ' UNION ALL '
            ' SELECT  Quantity*-1 as qty  ,ItemId , Stockid , '
            '(select ItemName from MobPosItem where MobPosItem.ItemId= MobPosInvTransferOut.ItemId ) as ItemName '
            ',(select SalesPrice1 from MobPosItem where MobPosItem.ItemId= MobPosInvTransferOut.ItemId ) as SalesPrice1 '
            ', (select StockName from MobPosStock where MobPosStock.StockId= MobPosInvTransferOut.StockId ) as StockName   from  MobPosInvTransferOut '
        ).then((value) {
          print('CREATE VIEW Stock_trans_v');
        });

        await database.rawQuery('CREATE VIEW Cach_trans_v  as  '
            ' SELECT Amount  as amount  ,TreasuryId ,DocDate,  TransType , Remark, CustVenId,InvoiceId,ExpenseId ,DocDate_INT'
            ',(select TreasuryName from MobPosTreasury where MobPosTreasury.TreasuryId = MobPosCashInOut.TreasuryId  ) as TreasuryName '
            '  from  MobPosCashInOut  '
            'UNION ALL '
            ' SELECT   Amount as amount  ,TreasuryId ,DocDate, TransType , Remark , CustVenId,InvoiceId,ExpenseId,DocDate_INT '
            ',(select TreasuryName from MobPosTreasury where MobPosTreasury.TreasuryId = MobPosCashTransferIn.TreasuryId  ) as TreasuryName'
            '  from  MobPosCashTransferIn'
            ' UNION ALL '
            ' SELECT  Amount as amount  ,TreasuryId ,DocDate,TransType , Remark, CustVenId,InvoiceId,ExpenseId ,DocDate_INT'
            ',(select TreasuryName from MobPosTreasury where MobPosTreasury.TreasuryId = MobPosCashTransferOut.TreasuryId  ) as TreasuryName'
            '  from  MobPosCashTransferOut '
        ).then((value) {
          print('CREATE VIEW Cach_trans_v');
        });


      },

      onOpen: (database)
      async {
        print('database opened');
      }).then((value){
    database = value;
    return value ;});
}
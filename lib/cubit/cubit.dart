import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos/DataBase/DataBase.dart';
import 'package:pos/DataBase/getDB.dart';
import 'package:pos/DataBase/Insert_City&Region.dart';
import 'package:pos/cubit/states.dart';
import 'package:pos/models/CITYModel.dart';
import 'package:pos/models/CUST_VEN_Model.dart';
import 'package:pos/models/INVOICE_Model.dart';
import 'package:pos/models/InvoiceItemModel.dart';
import 'package:pos/models/OUTGOINGS_Model.dart';
import 'package:pos/models/Stock_Details_Model.dart';
import 'package:pos/models/TREASURY_Model.dart';
import 'package:pos/modules/SearchITEMS_Dialog.dart';
import 'package:pos/modules/editProtectDialog.dart';
import 'package:pos/shared/Content.dart';
import 'dart:io';
import '../Api/Post.dart';
import '../Api/get.dart';
import '../models/AnalyticsCustAccount_Model.dart';
import '../models/CashInOut_Model.dart';
import '../models/FinalBalanceCustVen_Model.dart';
import '../models/ITEM_Model.dart';
import '../models/Inv_Uom_Model.dart';
import '../modules/Get_Post_Data_Screen.dart';
import '../modules/remainingMClient.dart';
import '../shared/helper/Dio_Helper.dart';

class posCubit extends Cubit<posStates> {
  posCubit() : super(posinitialState());

  static posCubit get(context) => BlocProvider.of(context);

  String valSupplier = 'اضغط لتحديد مورد';

  void changevalSupplierDropdown(String v) {
    valSupplier = v;
    emit(ChangeDropdownvalSupplierstate());
  }

  String valDeletSupplier = '';

  void changeDropdownDeletSupplier(String v) {
    valDeletSupplier = v;
    emit(ChangeDropdownDeletSupplierstate());
  }

  double AfterOffer = 0.0;
  double Discount = 0.0;
  int ROfferval = 1;
  void ChageRadioOffer({v, offer = 0.0}) {
    ROfferval = v;
    if (ROfferval == 1) {
      Discount = offer;
      AfterOffer = V_Total - offer;
    } else {
      AfterOffer = V_Total * (offer / 100);
      Discount = AfterOffer;
      AfterOffer = V_Total - AfterOffer;
    }
    emit(ChageRadioOfferstate());
  }

  int RInvoice = 1;
  void ChageRadioInvoice(v) {
    RInvoice = v;
    emit(ChageRadioInvoicestate());
  }
//SellOrderDelivery
  int RSellOrderDelivery = 1;
  void ChageRadioSellOrderDelivery(v) {
    RSellOrderDelivery = v;
    emit(ChageRadioSellOrderDeliverystate());
  }

  int RPrint = 1;
  void ChageRadioPrint(v) {
    RPrint = v;
    emit(ChageRadioPrintstate());
  }

  int RPrice = 1;
  void ChageRadioPrice(v) {
    RPrice = v;
    FristOpen = false;
    emit(ChageRadioPricestate());
  }

  void ChangeQunController() {
    emit(ChangeQunControllerstate());
  }

  String ButtonTextTreasury = 'خصم المبلغ من الخزينة';

  int RTreasuryval = 2;
  void ChageRadioTreasury(v) {
    RTreasuryval = v;
    if (RTreasuryval == 1) {
      ButtonTextTreasury = 'خصم المبلغ من الخزينة';
    } else {
      ButtonTextTreasury = 'اضافة المبلغ للخزينة';
    }
    emit(ChageRadioTreasurystate());
  }

  int Rval = 1;
  double remander = 0.0;
  void ChageRadioFollowing({v, double paid = 0.0}) {
    Rval = v;
    if (Rval == 2) {
      remander = AfterOffer - paid;
    }
    if (Rval == 1) {
      remander = 0.0;
    }

    emit(ChageRadioFollowingstate());
  }

  bool N_Q = false;

  UpdateFormItemsList(
      {required InvoiceItemModel item,
        required double UomQUANTITY,
        required double Price,
        // T1,
        // T2,
        // T3,bool? check,
        state = false,
        required context,
        }) {
    N_Q = false;
    // print(check);
    // print(T1);
    // print(T2);
    // print(T3);
    for (int i = 0; i < ItemsList.length; i++) {
      if (ItemsList[i].ITEM_ID == item.ITEM_ID) {
        print("++++++++++++++ QUANTITY_IN_STOCK   //  " +
            item.QUANTITY_IN_STOCK.toString());
        if (RInvoice == 1) {
          if (((ItemsList[i].Quantity) >= ( UomQUANTITY  as double )) || state) {
            print("++++++++++++++ UomQUANTITY  ____________________________ " +
                UomQUANTITY.toString());
          double   Quantity = Uom_UnitInvoiceItem.StandConvFactor * UomQUANTITY;
            double TOTAL = Price * Quantity;
            print("++++++++++++++ TOTAL   /////  ******* " + TOTAL.toString());
            _InvoiceItemModel = InvoiceItemModel(
              SALES_PRICE1: item.SALES_PRICE1 != null ? item.SALES_PRICE1 : null,
              ITEM_ID: item.ITEM_ID,
              SalesPrice2: item.SalesPrice2 != null ? item.SalesPrice2 : null,
              SalesPrice3: item.SalesPrice3 != null ? item.SalesPrice3 : null,
              Barcode: item.Barcode,
              ITEM_NAME: item.ITEM_NAME,
              Quantity: Quantity  ,
              QUANTITY_IN_STOCK: item.QUANTITY_IN_STOCK == null ? item.QUANTITY_IN_STOCK : 0,
              TOTAL: TOTAL,
              Price: Price,
             // check: check!,
              GroupId: item.GroupId,
              StandConvFactor: Uom_UnitInvoiceItem.StandConvFactor,
              UomName: Uom_UnitInvoiceItem.UomName,
              UomId: Uom_UnitInvoiceItem.UomId,
              UomQuantity: UomQUANTITY ,
              // T1_QUANTITY: T1 != '' ? int.parse(T1) : null,
              // T2_QUANTITY: T2 != '' ? int.parse(T2) : null,
              // T3_QUANTITY: T3 != '' ? int.parse(T3) : null,
            );
            ItemsList.insert(i, _InvoiceItemModel!);
            ItemsList.removeAt(i + 1);
            print(ItemsList[i]);
           // changeEditQuantityCheck(false);
            Quantitycontroller.text = '1';
            RPrice = 1;
            emit(SuccessUpdateFormItemsListState());
            SumTotal();
            break;
          } else {
            print("++++++++++++++ QUANTITY   ******* " + UomQUANTITY.toString());
            // openmessageMissQuantityE(context: context,ITEMmodel:  item);
            // openCalculteItem( context,  item);
            N_Q = true;
            print("++++++++++++++ UomQUANTITY   /////------------ " +
                UomQUANTITY.toString());

            //  emit(SuccessUpdateFormItemsListState());
          }
        }
        else if (RInvoice == 2) {
          print("++++++++++++++ UomQUANTITY  ____________________________ " +
              UomQUANTITY.toString());
          // print("++++++++++++++ T1  ____________________________ " +
          //     T1.toString());
          // print("++++++++++++++ T2  ____________________________ " +
          //     T2.toString());
          int Quantity = Uom_UnitInvoiceItem.StandConvFactor * UomQUANTITY;
          double TOTAL = Price * Quantity;
          print("++++++++++++++ TOTAL   /////  ******* " + TOTAL.toString());
          _InvoiceItemModel = InvoiceItemModel(
            SALES_PRICE1: item.SALES_PRICE1,
            ITEM_ID: item.ITEM_ID,
            SalesPrice2: item.SalesPrice2,
            SalesPrice3: item.SalesPrice3,
            Barcode: item.Barcode,
            ITEM_NAME: item.ITEM_NAME,
            Quantity: Quantity ,
            QUANTITY_IN_STOCK: item.QUANTITY_IN_STOCK,
            TOTAL: TOTAL,
            Price: Price,
           // check: check!,
            GroupId: item.GroupId ,
            StandConvFactor: Uom_UnitInvoiceItem.StandConvFactor,
            UomName: Uom_UnitInvoiceItem.UomName,
            UomId: Uom_UnitInvoiceItem.UomId,
            UomQuantity:UomQUANTITY ,

          );
          ItemsList.insert(i, _InvoiceItemModel!);
          ItemsList.removeAt(i + 1);
        //  print(ITEM_ModelList[i].ITEM_NAME);
        //  changeEditQuantityCheck(false);
          Quantitycontroller.text = '1';
          RPrice = 1;
          emit(SuccessUpdateFormItemsListState());
          SumTotal();
          break;
        }
      }
    }
  }

  String valBanks_TreasuryReport = '' ;
  changeDropdownBanks_TreasuryReport({required String v})  {
    valBanks_TreasuryReport = v;
    emit(ChangeDropdownBanks_TreasuryReportstate());
  }
  String valBanks_Treasury = '';
  Future<void> changeDropdownBanks_Treasury({required String v}) async {
    valBanks_Treasury = v;
    await GetTREASURY_ID(Name: v);
    emit(ChangeDropdownBanks_Treasurystate());
  }
  String valPAYMENT_METHOD = '';
  void changeDropdownPAYMENT_METHOD({required String v}) {
    valPAYMENT_METHOD = v;
    valBanks_Treasury = '';
    GetPAYMENT_METHOD_ID(Name: valPAYMENT_METHOD);
    emit(ChangeDropdownPAYMENT_METHODstate());
  }
  String valCurrency = 'جنية';
  void changeDropdownCurrency(String v) {
    valCurrency = v;
    emit(ChangeDropdownstate());
  }
  String valStock = '';
  void changevalStockDropdown(String v) {
    valStock = v;
    GetSTOCKID(Name: v);
    emit(ChangeDropdownvalStockstate());
  }
  String valCateg = '';
  Future<void> changeDropdownCateg(String v) async {
    valCateg = v;
    await getGroupID(NAME: v);
    await getItemsGroup();
    emit(ChangeCategDropdownstate());
  }
  String valStock_Details = '';
  void changevalStock_DetailsDropdown(String v) {
    valStock_Details = v;
    Search_ItemsInStock(Name: '', StockName: v);
    emit(ChangeDropdownvalStock_Detailsstate());
  }
 // String ? valInvUom = Uom_Unit!.UomName ?? '' ;

  Inv_Uom_Model   Uom_UnitInvoiceItem  = Uom_BaseUnit ?? Inv_Uom_List[0] ;
  changeDropdownInvUom({required String v ,required InvoiceItemModel ITEMmodel})  async {
//    valInvUom = v;
  await  database.rawQuery('SELECT * FROM MobPosInv_Uom  where UomName ="$v"'
      ).then((value) {
          Inv_Uom_Model itemModel =Inv_Uom_Model.fromJson(value.first);
          Uom_UnitInvoiceItem =  itemModel ;
          ITEMmodel.UomName  =  itemModel.UomName ;

      });
    emit(ChangeDropdownInvUomstate());
  }

  List<InvoiceItemModel> ITEM_ModelListGoup = [];
  getItemsGroup()  {
    ITEM_ModelListGoup = [];
    database.rawQuery('SELECT * FROM MobPosItem where GroupItemId = $GROUP_ID ').then((value) {
      value.forEach((element) {
        ITEM_Model itemGroupModel = ITEM_Model.fromJson(element);
        InvoiceItemModel _InvoiceItemModel=InvoiceItemModel(
          SALES_PRICE1: itemGroupModel.SalesPrice1,
          GroupId: itemGroupModel.GroupId,
          ITEM_ID:  itemGroupModel.ITEM_ID,
          ITEM_NAME: itemGroupModel.ITEM_NAME,
          UomQuantity: 1,
          Quantity: 1,
          UomId: Uom_BaseUnit!.UomId ,
          UomName: Uom_BaseUnit!.UomName ,
          StandConvFactor: Uom_BaseUnit!.StandConvFactor ,
          QUANTITY_IN_STOCK: itemGroupModel.Quantity ,
          TOTAL: itemGroupModel.SalesPrice1 ?? 0 ,
          SalesPrice3: itemGroupModel.SalesPrice3 ?? 0,
          SalesPrice2: itemGroupModel.SalesPrice2 ?? 0,
          Barcode: itemGroupModel.BARCODE,
          Price: itemGroupModel.SalesPrice1,
          //  check: false
        );
        ITEM_ModelListGoup.add(_InvoiceItemModel);
      });
      print('   ITEM_ModelListGoup.length   ' + ITEM_ModelListGoup.length.toString());
    });
    emit(getItemsGroupstate());
  }


  // bool checkEditQuantity = false;
  // void changeEditQuantityCheck(v) {
  //   checkEditQuantity = v;
  //   T1controller.text = '';
  //   T2controller.text = '';
  //   T3controller.text = '';
  //   emit(ChangeCheckEditQuantityButtonstate());
  // }
  // void EditQuantityCheck() {
  //   if (T1controller.text == '' || T1controller.text == null)
  //     T1controller.text = '1';
  //   if (T2controller.text == '' || T2controller.text == null)
  //     T2controller.text = '1';
  //   if (T3controller.text == '' || T3controller.text == null)
  //     T3controller.text = '1';
  //
  //   Quantity = (double.parse(T1controller.text) *
  //       double.parse(T2controller.text) *
  //       double.parse(T3controller.text))
  //       .toInt();
  //   Quantitycontroller.text = Quantity.toString();
  //   FristOpen = false;
  //   emit(EditQuantityButtonstate());
  // }

  double numText = 1;
  List<InvoiceItemModel> ItemsList = [];
  List<InvoiceItemModel> Search_ItemsList = [];
  InvoiceItemModel? _InvoiceItemModel;
  double V_Total = 0;
  List<int> itemID = [];
  insertInvoiceItems() async {
    ItemsList.forEach((element) async {
      String? Barcode ;
      Barcode = element.Barcode =="null" ||  element.Barcode ==null ? Barcode= '': Barcode=element.Barcode ;
      print('$Barcode       Barcode            Barcode');
      await database.transaction((txn) => txn
          .rawInsert(
          'INSERT INTO MobPosInvoiceItem(ItemId,ItemName,Barcode,Price,Total,Quantity,InvoiceId,LeId,UserId,status,UomId,UomQuantity) '
              'VALUES(${element.ITEM_ID},"${element.ITEM_NAME}","${Barcode}",${element.Price},${element.TOTAL},${element.Quantity},${INVOICE_model!.INVOICE_ID},'
              '$LE_ID,$UserId,"new",${element.UomId},${element.UomQuantity})')
          .then((value) {
        print('$value inserted');


      }));
    });
   await getInvoiceItem(database);
    ItemsList = [];
  }
  List<InvoiceItemModel> InvoiceItemsList = [];
  getInvoiceItems({InvoiceID}) async {
    InvoiceItemsList = [];
    print(InvoiceID);
  await  database.rawQuery('SELECT MobPosInvoiceItem.* , MobPosInv_Uom.UomName , MobPosInv_Uom.StandConvFactor FROM MobPosInvoiceItem'
        ' JOIN  MobPosInv_Uom ON MobPosInvoiceItem.UomId = MobPosInv_Uom.UomId where MobPosInvoiceItem.InvoiceId = ${InvoiceID} ').then((value) async {
    value.forEach((element) {
      InvoiceItemModel itemModel = InvoiceItemModel.fromJson(element);
      InvoiceItemsList.add(itemModel);
    print('element');
    print(element);
    });
    emit(SuccessgetInvoiceItemsState());
    });
  }
  insertInvoiceItems_SO({String ? S_O}) {
    String? Barcode ;
    ItemsList.forEach((element) async {
      Barcode = element.Barcode =="null" ? Barcode= '': Barcode=element.Barcode ;
      print('$Barcode       Barcode            Barcode');
      await database.transaction((txn) => txn
          .rawInsert(
          'INSERT INTO MobPosInvoiceItem(ItemId,ItemName,Barcode,Price,Total,Quantity,SalesOrderId,LeId,UserId,UomId,UomQuantity,status,S_O) '
              'VALUES(${element.ITEM_ID},"${element.ITEM_NAME}","${Barcode}",${element.Price},${element.TOTAL},${element.Quantity},'
              '"${INVOICE_model!.INVOICE_ID}",$LE_ID,$UserId,${element.UomId},${element.UomQuantity},"new","$S_O")')
          .then((value) {
        print('$value inserted');

        getInvoiceItem(database);
      }));
    });
    ItemsList = [];
  }

  Search_ItemsBARCODE({BARCODE}) {
    bool v = true;
    database.rawQuery('SELECT * FROM MobPosItem where Barcode = "$BARCODE"').then((value) {
      value.forEach((element) {
        ITEM_Model itemModel = ITEM_Model.fromJson(element);
        _InvoiceItemModel = InvoiceItemModel(
            SALES_PRICE1: itemModel.SalesPrice1,
            ITEM_ID: itemModel.ITEM_ID,
            ITEM_NAME: itemModel.ITEM_NAME,
            UomQuantity: 1,
            Quantity: 1,
            UomId: Uom_BaseUnit!.UomId ,
            UomName: Uom_BaseUnit!.UomName ,
            StandConvFactor: Uom_BaseUnit!.StandConvFactor ,
            GroupId: itemModel.GroupId,
            QUANTITY_IN_STOCK: itemModel.Quantity,
            TOTAL: itemModel.SalesPrice1,
            SalesPrice3: itemModel.SalesPrice3,
            SalesPrice2: itemModel.SalesPrice2,
            Barcode: itemModel.BARCODE,
            Price: itemModel.SalesPrice1,
            LeId: itemModel.LeId,
        //    check: false
        );
        ItemsList.add(_InvoiceItemModel!);
        emit(SuccessSearch_ItemsNamesState());
        //  if(Search_ItemsList.length >40) break;
        print(itemModel.LeId.toString());
        print(itemModel.ITEM_NAME);
        emit(SuccessSearch_ItemsNamesState());
      });
    });
            SumTotal();
  }

  Search_ItemsNames({Name}) {
    emit(loadingSearch_ItemsNamesState());
    Search_ItemsList = [];
    print(Name);
    database.rawQuery('SELECT * FROM MobPosItem where ItemName like "%$Name%"').then((value) {
      value.forEach((element) {
        ITEM_Model itemModel = ITEM_Model.fromJson(element);
        _InvoiceItemModel = InvoiceItemModel(
            SALES_PRICE1: itemModel.SalesPrice1,
            ITEM_ID: itemModel.ITEM_ID,
            ITEM_NAME: itemModel.ITEM_NAME,
            UomQuantity: 1,
            Quantity: 1,
          UomId: Uom_BaseUnit!.UomId ,
          UomName: Uom_BaseUnit!.UomName ,
          StandConvFactor: Uom_BaseUnit!.StandConvFactor ,
            GroupId: itemModel.GroupId,
            QUANTITY_IN_STOCK: itemModel.Quantity,
            TOTAL: itemModel.SalesPrice1,
            SalesPrice3: itemModel.SalesPrice3,
            SalesPrice2: itemModel.SalesPrice2,
            Barcode: itemModel.BARCODE,
            Price: itemModel.SalesPrice1,
            LeId: itemModel.LeId,
        //    check: false
        );
        Search_ItemsList.add(_InvoiceItemModel!);
        emit(SuccessSearch_ItemsNamesState());
        print(itemModel.LeId.toString());
        print(itemModel.ITEM_NAME);
        emit(SuccessSearch_ItemsNamesState());
      });
    });
  }

  // List<Inv_Uom_Model>  Inv_Uom_List =[] ;
  // Inv_Uom_Model ? Uom_BaseUnit  ;
  // getInv_Uom(database)
  // async {
  //   database.rawQuery('SELECT * FROM MobPosInv_Uom '
  //   ).then((value) {
  //     Inv_Uom_List = [];
  //     value.forEach((element) {
  //       Inv_Uom_Model itemModel =Inv_Uom_Model.fromJson(element);
  //       if(itemModel.BaseUnit == 1 ) {
  //         Uom_Unit =  itemModel ;
  //       }
  //       Inv_Uom_List.add(itemModel);
  //       print(element);
  //     });
  //     print('iiiiii  Inv_Uom_List ' + Inv_Uom_List.length.toString());
  //   });
  // }
  //

  SearchInInvoiceItems(ITEMmodel, context) {
    bool v = true;
    for (int i = 0; i < ItemsList.length; i++) {
      if (ItemsList[i].ITEM_ID == ITEMmodel!.ITEM_ID) {
        openmessageMissItem(context);
        v = false;
        break;
      }
    }
    if (v) {
      emit(SuccessAddInInvoiceItemsState());
      ItemsList.add(ITEMmodel!);
      Search_ItemsList = [];
      SumTotal();
    }

  }

  DeletFormItemsList({required InvoiceItemModel item}) {
    for (int i = 0; i < ItemsList.length; i++) {
      if (ItemsList[i].ITEM_ID == item.ITEM_ID) {
        ItemsList.remove(item);
        emit(SuccessDeletFormItemsListState());
        SumTotal();
        break;
      }
    }
  }

  SumTotal() {
    List<int> itemID = [];
    V_Total = 0;
    ItemsList.forEach((element) {
      V_Total += element.TOTAL!;
      print(element.ITEM_ID);
      itemID.add(element.ITEM_ID as int);
      print('itemID   **********************************************');
      print(itemID);
    });
    ChageRadioOffer(v: ROfferval);
    emit(SuccessSumTotalState());
  }

  int? V_TREASURY_ID;
  GetTREASURY_ID({Name}) {
    for (int i = 0; i < TREASURY_ModelList.length; i++) {
      if (TREASURY_ModelList[i].TreasuryName.toString() == Name) {
        V_TREASURY_ID = TREASURY_ModelList[i].TreasuryId;
        print(V_TREASURY_ID);
        emit(SuccessGetTREASURY_IDState());
        break;
      }
    }
  }
  int? V_PAYMENT_METHOD_ID;
  List<TREASURY_Model> TREASURY_RAYMENT = [];
  GetPAYMENT_METHOD_ID({Name}) {
    for (int i = 0; i < PAYMENT_METHOD_ModelList.length; i++) {
      if (PAYMENT_METHOD_ModelList[i].PAYMENT_METHOD_NAME.toString() == Name) {
        V_PAYMENT_METHOD_ID = PAYMENT_METHOD_ModelList[i].PAYMENT_METHOD_ID;
        print('////////V_PAYMENT_METHOD_ID   $V_PAYMENT_METHOD_ID');
        GetTREASURY_Names(ID: V_PAYMENT_METHOD_ID);
        emit(SuccessGetV_PAYMENT_METHOD_ID_IDState());
      }
    }
  }
  GetTREASURY_Names({ID}) {
    TREASURY_RAYMENT = [];
    TREASURY_ModelList.forEach((element) {
      if (element.PaymentMethodId == ID) {
        TREASURY_RAYMENT.add(element);
        emit(SuccessGetTREASURY_NamesState());
      }
    });
  }
  int? V_STOCKID;
  GetSTOCKID({Name}) {
    print(Name);
    for (int i = 0; i < STOCK_ModelList.length; i++) {
      print(STOCK_ModelList[i].STOCK_ID);
      if (STOCK_ModelList[i].STOCK_NAME.toString() == Name) {
        V_STOCKID = STOCK_ModelList[i].STOCK_ID;
        break;
      }
    }
  }

  List<CUST_VEN_Model> CUST_ModelListSearch = [];
  CUST_VEN_Model? CUST_ModelSearch;
  Search_CUST({CUSTNAME}) {
    CUST_ModelListSearch = [];
    CUST_ModelList.forEach((element) {
      print(element.NAME);
      if (element.NAME.toString().contains(CUSTNAME) ||
          element.Phone1.toString().contains(CUSTNAME) ||
          element.Phone2.toString().contains(CUSTNAME) ||
          element.Phone3.toString().contains(CUSTNAME) ||
          element.Phone4.toString().contains(CUSTNAME)) {
        CUST_ModelListSearch.add(element);
        emit(SuccessSearch_CUSTState());
        print(element.CUST_VEN_ID);
      }
    });
    print(CUST_ModelListSearch);
    print(CUST_ModelListSearch.length);
    emit(SuccessSearch_CUSTState());
  }

  List<Stock_Details_Model> Stock_Details_ListSearch = [];
  Search_ItemsInStock({Name, StockName}) {
    Stock_Details_ListSearch = [];
    print(Name);
    print(StockName);
    Stock_Details_List.forEach((element) {
      if (element.ItemName.toString().contains(Name)
          // || element.BARCODE == Name)
          &&  element.StockName == StockName) {
        print(element.ItemName);
        Stock_Details_ListSearch.add(element);
        emit(SuccessSearch_ItemsInStocksState());
      }
      emit(SuccessSearch_ItemsInStocksState());
    });
  }

  OUTGOINGS_Model? OUTGOINGS_model;
  List<OUTGOINGS_Model> OUTGOINGS_ModelListSearch = [];
  Search_OUTGOINGS({Outgoing}) {
    OUTGOINGS_ModelListSearch = [];
    OUTGOINGS_ModelList.forEach((element) {
      if (element.OUTGOINGS_NAME.toString().contains(Outgoing)) {
        OUTGOINGS_ModelListSearch.add(element);
        print(OUTGOINGS_ModelListSearch);
        emit(SuccessSearch_OUTGOINGSState());
      }
    });
  }

  List<CashInOut_Model> CashInOut_ModelListSearch = [];
  getCashInOutSearch({required date,required String  TREASURYNme}) async {
    emit(loadingCashInOutSearchState());
    print ('77777777 TREASURYNme $TREASURYNme ');
    CashInOut_ModelListSearch = [];
    print(TREASURYNme);
    print(date);
    //&& element.TreasuryName.toString().contains(TREASURYNme)
    CashTransInOut_ModelList_Invers.forEach((element) {
      print ("  element.DocDate_INT   ${element.DocDate_INT} ");
      if (int.parse((element.DocDate!.split(' ')[0]).replaceAll('-', '')) >=
          int.parse(date.toString().replaceAll('-', ''))  ) {
      //   if (element.DocDate_INT as int >=
      //       int.parse(date.toString().replaceAll('-', '')) ) {
        CashInOut_ModelListSearch.add(element);
      //  emit(SuccessgetCashInOutSearchState());
      }
    });
    //   print(CashInOut_ModelListSearch);0
    print('           CashInOut_ModelListSearch        iiiiii  ii                         ' +
        CashInOut_ModelListSearch.length.toString());
    emit(SuccessgetCashInOutSearchState());
  }

  List<INVOICE_Model> MobPosInvoiceSearchList = [];
  Search_InvoiceNo({InvoiceNo}) {
    MobPosInvoiceSearchList = [];
    INVOICE_ModelListReversed.forEach((element) {
      if ((InvoiceNo == '' &&
          element.InvoiceNo.toString().contains(InvoiceNo) ||
          element.InvoiceNo.toString() == InvoiceNo)) {
        print(element.InvoiceNo);
        MobPosInvoiceSearchList.add(element);
        emit(SuccessSearch_InvoiceNoState());
      }
      emit(SuccessSearch_InvoiceNoState());
    });
  }

  List<CITYModel> Search_CITY_REGIONList = [];
  Search_CITY({Name}) {
    Search_CITY_REGIONList = [];

    {
      MobPosCityList.forEach((element) {
        if (element.CITY_NAME.toString().contains(Name)) {
          print(element.CITY_NAME);
          Search_CITY_REGIONList.add(element);
          print(Search_CITY_REGIONList);
          emit(SuccessGetSearchCityState());
        }
      });
    }
    emit(SuccessGetSearchCityState());
  }

//////////       BalanceCustVen  ////////////////

  List<FinalBalanceCustVen_Model> FinalBalanceCust =[] ;
  getFinalBalanceCustdata({required int LeId , int ? CustId ,  String ? Name ,required context} )
  {
    emit(loadingFinalBalance_CUSTState());
    late  String url ;
    if(CustId != null)  url = '${URl}FinalBalanceCustVen?q=LeId=${LeId};KinId=2;finder=RowFinder;CustVenCode=${CustId}&orderBy=CustVenCode' ;
    else if(Name != null)  url = '${URl}FinalBalanceCustVen?finder=RowFinder;pLeId=${LeId},pKinId=2,pName=${Name}&orderBy=CustVenCode' ;

    FinalBalanceCust =[] ;
    FinalBalanceCustVen model ;
    Dio_Helper.getData(url: url ).then((value) async {
      print(value);
      String v =value.toString().trim().replaceAll('\r\n', '').replaceAll('^', '');
      model=FinalBalanceCustVen.fromJson(jsonDecode(v));
      print('//////////   FinalBalanceCustVen_Model    ////////');
      print(model.items[0].CustVenId.toString());
      model.items.forEach((element) {
        print(element.Name);
        FinalBalanceCust.add(element);
        emit(SuccessFinalBalance_CUSTState());
      });
      print(FinalBalanceCust.length);
      print('**********************  items  ++++++++++++-------------=====================');
    } ).catchError((Error)
    { print("eee   "+Error.toString());
    if(Error.toString() =='RangeError (index): Invalid value: Valid value range is empty: 0')   openmessageNOCustSuccess(context);
    if(Error.toString().contains('Connection failed (OS Error: Network is unreachable, errno = 101), address = 185.219.134.68,'))   openmessageNetworkSuccess(context);
    openmessageNOCustSuccess(context);
    emit(ErrorFinalBalance_CUSTState());
    });
  }
  List<AnalCustAccount_Model> CustSupp =[] ;
  List<AnalCustAccount_Model> CustSupp_Reversed =[] ;
 // List<AnalCustAccount_Model> CustSupp =[] ;
  getCustSuppBalancedata({required int LeId , int ? CustId ,  String ? Name , context } ){ emit(loadingGetCustSuppBalanceState());
    dynamic balance = 0;
    double Sub_D_C = 0;
  late  String url ;
  if(CustId != null)  url = '${URl}CustSuppBalanceV?q=LeId=${LeId};KinId=2;CustVenCode=${CustId}&orderBy=DocDate' ; //ASC  //Desc
  else if(Name != null)  url = '${URl}CustSuppBalanceV?q=finder=RowFinder;LeId=${LeId};KinId=2;Name=${Name}&orderBy=DocDate' ;
      //finder=RowFinder;pLeId=${LeId},pKinId=2,pName="${Name}"&orderBy=DocDate' ;
  CustSupp =[] ;//q=finder=RowFinder;LeId=${LeId};KinId=2;Name=${Name}&orderBy=DocDate
  AnalCustAccount model ;
  Dio_Helper.getData(url: url ).then((value) async {
    print(value);
    String v =value.toString().trim().replaceAll('\r\n', '').replaceAll('^', '');
    model=AnalCustAccount.fromJson(jsonDecode(v));
    print('//////////   AnalCustAccount_Model    ////////');
    print(model.items[0].CustVenId.toString());
    model.items.forEach((element) {
      AnalCustAccount_Model AnalCustAccount_model = element ;
      // AnalCustAccount_model.Sub_D_C = AnalCustAccount_model.Debit - AnalCustAccount_model.Credit ;
      // balance +=   AnalCustAccount_model.Sub_D_C! ;
      AnalCustAccount_model.Debit = AnalCustAccount_model.Debit ??  0.0 ;
      AnalCustAccount_model.Credit= AnalCustAccount_model.Credit ?? 0.0 ;
      Sub_D_C = (double.parse(AnalCustAccount_model.Debit.toString() )) - (double.parse(AnalCustAccount_model.Credit.toString())) ;
      print( ' Sub_D_C   $Sub_D_C');
      balance +=  Sub_D_C ;
      print( ' balance   $balance');
     // AnalCustAccount_model.Balance =double.parse(balance.toStringAsFixed(2)) ; //(balance as double) ;
      AnalCustAccount_model.Balance =balance ; //(balance as double) ;
      print(element.Name);
      CustSupp.add(AnalCustAccount_model);
   //   CustSupp.sort();  //int.parse(element.DocDate.replaceAll('-', ''))
      emit(SuccessGetCustSuppBalanceState());
    });
    CustSupp_Reversed =CustSupp.reversed.toList();
    print(CustSupp.length);
    print('**********************  items  ++++++++++++-------------=====================');
  } ).catchError((Error)
  { print("eee  getCustSuppBalancedata  "+Error.toString());
  if(Error.toString() =='RangeError (index): Invalid value: Valid value range is empty: 0')   openmessageNOCustSuccess(context);
  if(Error.toString().contains('Connection failed (OS Error: Network is unreachable, errno = 101), address = 185.219.134.68,'))   openmessageNetworkSuccess(context);
  emit(ErrorGetCustSuppBalanceState());
  });
  }


  //////////       All Data  ////////////////
  PostAllData (context) async {
    emit(loadingPostDataState());
    print(Active);
    if(Active == 1)
    {
      try{
        await Gps_Post() ;
        await  INVOICE_Post();
        await  InvoiceItem_Post();
        await CUST_VEN_Post() ;
        await  CashInOut_Post();
        await  UserSec_Post();
       // await PostAllApiTable();
        emit(SuccessgePostDataState());
        openmessageSuccessPost(context);
      }
      catch(error)
    { openmessageSuccessPost(context);
     // openmessageActive_0(context);
      emit(ErrorgePostDataState());
    }

    }
    else{
      openmessageActive_0(context);
      emit(ErrorgePostDataState());
    }
  }
  GetAllData (context) async {
    emit(loadingGetDataState());
    print(Active);
    if(Active == 1  )
    {
      try{
        await GetAllApiTable(LeId: LE_ID,UserId:  UserId);
        emit(SuccessgeGetDataState());
        openmessageSuccessGet(context);
      }catch(errer){
        openmessageActive_0(context);
        emit(ErrorgeGetDataState());
      }
    }
    else{
      openmessageActive_0(context);
      emit(ErrorgeGetDataState());
    }
  }

  //////////////////////////////       ImagePicker    ////////////////
  File? ProductImageCamera;
  File? ProductImageCallery;
  File? logoImageCamera;
  File? logoImageCallery;
  var picker = ImagePicker();
  Future<void> getProductImageCallery() async {
    final PickedFile =
    await picker.pickImage(source: ImageSource.gallery).then((value) {
      ProductImageCallery = File(value!.path);
      print(value.path);
      emit(SuccessGetCalleryImageProductState());
    }).catchError((onError) {
      print('No image selected');
      emit(ErrorGetCalleryImageProductState());
    });
  }
  Future<void> getProductImageCamera() async {
    final PickedFile =
    await picker.pickImage(source: ImageSource.camera).then((value) {
      ProductImageCamera = File(value!.path);
      print(value.path);
      emit(SuccessGetCameraImageProductState());
    }).catchError((onError) {
      print('No image selected');
      emit(ErrorGetCameraImageProductState());
    });
  }
  Future<void> getlogoImageCallery() async {
    final PickedFile =
    await picker.pickImage(source: ImageSource.gallery).then((value) {
      logoImageCallery = File(value!.path);
      print(value.path);
      emit(SuccessGetCalleryImagelogoState());
    }).catchError((onError) {
      print('No image selected');
      emit(ErrorGetCalleryImagelogoState());
    });
  }
  Future<void> getlogoImageCamera() async {
    final PickedFile =
    await picker.pickImage(source: ImageSource.camera).then((value) {
      logoImageCamera = File(value!.path);
      print(value.path);
      emit(SuccessGetCameraImagelogoState());
    }).catchError((onError) {
      print('No image selected');
      emit(ErrorGetCameraImagelogoState());
    });
  }

}

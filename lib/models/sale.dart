import 'package:equatable/equatable.dart';

class Sale extends Equatable {
  final int orderID;
  final String orderTitle;
  final String orderCode;
  final String dateOrder;
  final int sectionID;
  final int saleID;
  final int deliveryStaffID;
  final int customerID;
  final String userReceive;
  final String addressReceive;
  final String phoneReceive;
  final int vTotalAmount;
  final int totalAmountv;
  final int totalAmountDiscount;
  final int amountDelivery;
  final int totalAmountDebt;
  final String description;
  final int status;
  final int userCreate;
  final String nameUCreate;
  final String dateCreate;
  final int userUpdate;
  final String dateUpdate;
  final List<ListDetail> lstDetail;
  final List<ListApprove> lstApprove;

  const Sale({
    required this.orderID,
    required this.orderTitle,
    required this.orderCode,
    required this.dateOrder,
    required this.sectionID,
    required this.saleID,
    required this.deliveryStaffID,
    required this.customerID,
    required this.userReceive,
    required this.addressReceive,
    required this.phoneReceive,
    required this.vTotalAmount,
    required this.totalAmountv,
    required this.totalAmountDiscount,
    required this.amountDelivery,
    required this.totalAmountDebt,
    required this.description,
    required this.status,
    required this.userCreate,
    required this.nameUCreate,
    required this.dateCreate,
    required this.userUpdate,
    //required this.nameUUpdate,
    required this.dateUpdate,
    required this.lstApprove,
    required this.lstDetail,
  });

  factory Sale.fromJson(Map<String, dynamic> json) {
    final lstApprove = <ListApprove>[];
    final lstDetail = <ListDetail>[];

    if (json['lstApprove'] != null) {
      json['lstApprove'].forEach((v) {
        lstApprove.add(ListApprove.fromJson(v));
      });
    }

    if (json['lstDetail'] != null) {
      json['lstDetail'].forEach((v) {
        lstDetail.add(ListDetail.fromJson(v));
      });
    }

    return Sale(
      orderID: json['orderID'],
      orderTitle: json['orderTitle'] ?? '',
      orderCode: json['orderCode'],
      dateOrder: json['dateOrder'],
      sectionID: json['sectionID'],
      saleID: json['saleID'],
      deliveryStaffID: json['deliveryStaffID'],
      customerID: json['customerID'],
      userReceive: json['userReceive'],
      addressReceive: json['addressReceive'],
      phoneReceive: json['phoneReceive'],
      vTotalAmount: json['vTotalAmount'],
      totalAmountv: json['totalAmountv'],
      totalAmountDiscount: json['totalAmountDiscount'],
      amountDelivery: json['amountDelivery'],
      totalAmountDebt: json['totalAmountDebt'],
      description: json['description'],
      status: json['status'],
      userCreate: json['userCreate'],
      nameUCreate: json['nameUCreate'],
      dateCreate: json['dateCreate'],
      userUpdate: json['userUpdate'],
      //nameUUpdate: json['nameUUpdate'],
      dateUpdate: json['dateUpdate'],
      lstApprove: lstApprove,
      lstDetail: lstDetail,
    );
  }

  @override
  List<Object?> get props => [
    orderID,
    orderTitle,
    orderCode,
    dateOrder,
    sectionID,
    saleID,
    deliveryStaffID,
    customerID,
    userReceive,
    addressReceive,
    phoneReceive,
    vTotalAmount,
    totalAmountv,
    totalAmountDiscount,
    amountDelivery,
    totalAmountDebt,
    description,
    status,
    userCreate,
    nameUCreate,
    dateCreate,
    userUpdate,
    dateUpdate,
    lstApprove,
    lstDetail,
  ];
}

class ListApprove extends Equatable {
  final int orderApproveID;
  final int orderID;
  final int userApproveID;
  final String nameUApprove;
  final int numberApprove;
  final int isApprove;
  final String dateApprove;
  final int status;
  final int userCreate;
  final String dateCreate;
  final int userUpdate;
  final String dateUpdate;

  const ListApprove({
    required this.orderApproveID,
    required this.orderID,
    required this.userApproveID,
    required this.nameUApprove,
    required this.numberApprove,
    required this.isApprove,
    required this.dateApprove,
    required this.status,
    required this.userCreate,
    required this.dateCreate,
    required this.userUpdate,
    required this.dateUpdate,
  });

  factory ListApprove.fromJson(Map<String, dynamic> json) {
    return ListApprove(
      orderApproveID: json['orderApproveID'],
      orderID: json['orderID'],
      userApproveID: json['userApproveID'],
      nameUApprove: json['nameUApprove'],
      numberApprove: json['numberApprove'],
      isApprove: json['isApprove'],
      dateApprove: json['dateApprove'] ?? '',
      status: json['status'],
      userCreate: json['userCreate'],
      dateCreate: json['dateCreate'],
      userUpdate: json['userUpdate'],
      dateUpdate: json['dateUpdate'],
    );
  }

  @override
  List<Object?> get props => [
    orderApproveID,
    orderID,
    userApproveID,
    nameUApprove,
    numberApprove,
    isApprove,
    dateApprove,
    status,
    userCreate,
    dateCreate,
    userUpdate,
    dateUpdate,
  ];
}

class ListDetail extends Equatable {
  final int orderDetailID;
  final int orderID;
  final int productionID;
  final int quantityOrder;
  final int vPrice;
  final int pricev;
  final int vat;
  final int amountDiscount;
  final int vAmount;
  final int amountv;
  final String description;
  final int userCreate;
  final String dateCreate;
  final int userUpdate;
  final String dateUpdate;
  final int ordersOrderID;
  final int productionStatus;
  final String productName;
  final String specName;
  final String areaName;

  const ListDetail({
    required this.orderDetailID,
    required this.orderID,
    required this.productionID,
    required this.quantityOrder,
    required this.vPrice,
    required this.pricev,
    required this.vat,
    required this.amountDiscount,
    required this.vAmount,
    required this.amountv,
    required this.description,
    required this.userCreate,
    required this.dateCreate,
    required this.userUpdate,
    required this.dateUpdate,
    this.ordersOrderID = 0,
    required this.productionStatus,
    required this.productName,
    required this.specName,
    required this.areaName,
  });

  factory ListDetail.fromJson(Map<String, dynamic> json) {
    return ListDetail(
      orderDetailID: json['orderDetailID'],
      orderID: json['orderID'],
      productionID: json['productionID'],
      quantityOrder: json['quantityOrder'],
      vPrice: json['vPrice'],
      pricev: json['pricev'],
      vat: json['vat'],
      amountDiscount: json['amountDiscount'],
      vAmount: json['vAmount'],
      amountv: json['amountv'],
      description: json['description'],
      userCreate: json['userCreate'],
      dateCreate: json['dateCreate'],
      userUpdate: json['userUpdate'],
      dateUpdate: json['dateUpdate'],
      ordersOrderID: 0,
      productionStatus: json['productionStatus'],
      productName: json['productName'] ?? 'Không có tên sản phẩm',
      specName: json['specName'] ?? '',
      areaName: json['areaName'] ?? '',
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    orderDetailID,
    orderID,
    productionID,
    quantityOrder,
    vPrice,
    pricev,
    vat,
    amountDiscount,
    vAmount,
    amountv,
    description,
    userCreate,
    dateCreate,
    userUpdate,
    dateUpdate,
    ordersOrderID,
    productionStatus,
    productName,
    specName,
    areaName,
  ];
}

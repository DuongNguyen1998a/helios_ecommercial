import 'package:equatable/equatable.dart';

class Cart extends Equatable {
  final int shoppingCartID;
  final String shoppingCartCode;
  final String dateOrder;
  final int customerID;
  final int vTotalAmount;
  final int totalAmountv;
  final int totalAmountDiscount;
  final int amountDelivery;
  final int totalAmountDebt;
  final String description;
  final int status;
  final int userCreate;
  final String dateCreate;
  final int userUpdate;
  final String dateUpdate;
  final List<LstDetail> lstDetail;

  const Cart({
    required this.shoppingCartID,
    required this.shoppingCartCode,
    required this.dateOrder,
    required this.customerID,
    required this.vTotalAmount,
    required this.totalAmountv,
    required this.totalAmountDiscount,
    required this.amountDelivery,
    required this.totalAmountDebt,
    required this.description,
    required this.status,
    required this.userCreate,
    required this.dateCreate,
    required this.userUpdate,
    required this.dateUpdate,
    required this.lstDetail,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {

    List<LstDetail> lstDetail = <LstDetail>[];
    json['lstDetail'].forEach((v) {
      lstDetail.add(LstDetail.fromJson(v));
    });

    return Cart(
        shoppingCartID: json['shoppingCartID'],
        shoppingCartCode: json['shoppingCartCode'],
        dateOrder: json['dateOrder'],
        customerID: json['customerID'],
        vTotalAmount: json['vTotalAmount'],
        totalAmountv: json['totalAmountv'],
        totalAmountDiscount: json['totalAmountDiscount'],
        amountDelivery: json['amountDelivery'],
        totalAmountDebt: json['totalAmountDebt'],
        description: json['description'],
        status: json['status'],
        userCreate: json['userCreate'],
        dateCreate: json['dateCreate'],
        userUpdate: json['userUpdate'],
        dateUpdate: json['dateUpdate'],
        lstDetail: lstDetail,
    );
  }

  @override
  List<Object?> get props =>
      [
        shoppingCartID,
        shoppingCartCode,
        dateOrder,
        customerID,
        vTotalAmount,
        totalAmountv,
        totalAmountDiscount,
        amountDelivery,
        totalAmountDebt,
        description,
        status,
        userCreate,
        dateCreate,
        userUpdate,
        dateUpdate,
        lstDetail,
      ];
}

class LstDetail extends Equatable {
  final int shoppingCartDetailID;
  final int shoppingCartID;
  final int productionID;
  final int quantity;
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
  final String productName;
  final bool isChecked;
  final String productImage;

  const LstDetail({
    required this.shoppingCartDetailID,
    required this.shoppingCartID,
    required this.productionID,
    required this.quantity,
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
    required this.productName,
    required this.isChecked,
    required this.productImage,
  });

  factory LstDetail.fromJson(Map<String, dynamic> json) {
    return LstDetail(
      shoppingCartDetailID: json['shoppingCartDetailID'],
      shoppingCartID: json['shoppingCartID'],
      productionID: json['productionID'],
      quantity: json['quantity'],
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
      productName: json['productName'],
      isChecked: false,
      productImage: json['productImage'],
    );
  }

  @override
  List<Object?> get props =>
      [
        shoppingCartDetailID,
        shoppingCartID,
        productionID,
        quantity,
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
        productName,
        isChecked,
        productImage,
      ];

}
import 'package:equatable/equatable.dart';

class AddCartModel extends Equatable {
  final String productionID;
  final String quantity;
  final String vPrice;
  final String pricev;
  final String vAT;
  final String amountDiscount;
  final String vAmount;
  final String amountv;
  final String description;
  final String userCreate;
  final String dateCreate;
  final String userUpdate;
  final String dateUpdate;

  const AddCartModel({
    required this.productionID,
    required this.quantity,
    required this.vPrice,
    required this.pricev,
    required this.vAT,
    required this.amountDiscount,
    required this.vAmount,
    required this.amountv,
    required this.description,
    required this.userCreate,
    required this.dateCreate,
    required this.userUpdate,
    required this.dateUpdate,
  });

  factory AddCartModel.fromJson(Map<String, dynamic> json) {
    return AddCartModel(
      productionID: json['ProductionID'],
      quantity: json['Quantity'],
      vPrice: json['vPrice'],
      pricev: json['Pricev'],
      vAT: json['VAT'],
      amountDiscount: json['AmountDiscount'],
      vAmount: json['vAmount'],
      amountv: json['Amountv'],
      description: json['Description'],
      userCreate: json['UserCreate'],
      dateCreate: json['DateCreate'],
      userUpdate: json['UserUpdate'],
      dateUpdate: json['DateUpdate'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ProductionID'] = productionID;
    data['Quantity'] = quantity;
    data['vPrice'] = vPrice;
    data['Pricev'] = pricev;
    data['VAT'] = vAT;
    data['AmountDiscount'] = amountDiscount;
    data['vAmount'] = vAmount;
    data['Amountv'] = amountv;
    data['Description'] = description;
    data['UserCreate'] = userCreate;
    data['DateCreate'] = dateCreate;
    data['UserUpdate'] = userUpdate;
    data['DateUpdate'] = dateUpdate;
    return data;
  }

  @override
  List<Object?> get props => [
        productionID,
        quantity,
        vPrice,
        pricev,
        vAT,
        amountDiscount,
        vAmount,
        amountv,
        description,
        userCreate,
        dateCreate,
        userUpdate,
        dateUpdate,
      ];
}

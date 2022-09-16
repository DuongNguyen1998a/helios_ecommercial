import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int productID;
  final String productName;
  final int productTypeID;
  final double prorating;
  final String imagePath;
  final int brandID;
  final String brandCode;
  final String brandName;
  final int pricev;

  const Product({
    required this.productID,
    required this.productName,
    required this.productTypeID,
    required this.prorating,
    required this.imagePath,
    required this.brandID,
    required this.brandCode,
    required this.brandName,
    required this.pricev,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productID: json['productID'],
      productName: json['productName'],
      productTypeID: json['productTypeID'],
      prorating: json['prorating'],
      imagePath: json['imagePath'],
      brandID: json['brandID'],
      brandCode: json['brandCode'],
      brandName: json['brandName'],
      pricev: json['pricev'],
    );
  }

  @override
  List<Object?> get props => [
    productID,
    productName,
    productTypeID,
    prorating,
    imagePath,
    brandID,
    brandCode,
    brandName,
    pricev,
  ];
}

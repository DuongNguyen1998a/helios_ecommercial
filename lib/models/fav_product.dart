import 'package:equatable/equatable.dart';

class FavProduct extends Equatable {
  final int productID;
  final String productName;
  final int productStatus;
  final int productTypeID;
  final double productRating;
  final String imagePath;
  final int brandID;
  final String brandCode;
  final String brandName;
  final int pricev;
  final int customerID;

  const FavProduct({
    required this.productID,
    required this.productName,
    required this.productStatus,
    required this.productTypeID,
    required this.productRating,
    required this.imagePath,
    required this.brandID,
    required this.brandCode,
    required this.brandName,
    required this.pricev,
    required this.customerID,
  });

  factory FavProduct.fromJson(Map<String, dynamic> json) {
    return FavProduct(
      productID: json['productID'] ?? 0,
      productName: json['productName'] ?? '',
      productStatus: json['productStatus'] ?? 0,
      productTypeID: json['productTypeID'] ?? 0,
      productRating: json['productRating'] ?? 0,
      imagePath: json['imagePath'],
      brandID: json['brandID'] ?? 0,
      brandCode: json['brandCode'] ?? '',
      brandName: json['brandName'] ?? '',
      pricev: json['pricev'] ?? 0,
      customerID: json['customerID'] ?? 0,
    );
  }

  @override
  List<Object?> get props => [
    productID,
    productName,
    productStatus,
    productTypeID,
    productRating,
    imagePath,
    brandID,
    brandCode,
    brandName,
    pricev,
    customerID,
  ];
}

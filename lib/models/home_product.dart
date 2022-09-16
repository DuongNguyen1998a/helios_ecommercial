import 'package:equatable/equatable.dart';

class HomeProduct extends Equatable {
  final int productID;
  final String productName;
  final int productTypeID;
  final double prorating;
  final String imagePath;
  final int brandID;
  final String brandCode;
  final String brandName;
  final int pricev;
  final int quantityExport;

  const HomeProduct({
    required this.productID,
    required this.productName,
    required this.productTypeID,
    required this.prorating,
    required this.imagePath,
    required this.brandID,
    required this.brandCode,
    required this.brandName,
    required this.pricev,
    required this.quantityExport,
  });

  factory HomeProduct.fromJson(Map<String, dynamic> json) {
    return HomeProduct(
      productID: json['productID'],
      productName: json['productName'],
      productTypeID: json['productTypeID'],
      prorating: json['prorating'] ?? 0,
      imagePath: json['imagePath'],
      brandID: json['brandID'],
      brandCode: json['brandCode'],
      brandName: json['brandName'],
      pricev: json['pricev'],
      quantityExport: json['quantityExport'],
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
    quantityExport,
  ];
}

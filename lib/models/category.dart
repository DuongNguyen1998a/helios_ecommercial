import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final int productCategoryID;
  final String productCategoryCode;
  final String productCategoryName;

  const Category({
    required this.productCategoryID,
    required this.productCategoryCode,
    required this.productCategoryName,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      productCategoryID: json['productCategoryID'],
      productCategoryCode: json['productCategoryCode'],
      productCategoryName: json['productCategoryName'],
    );
  }

  @override
  List<Object?> get props => [
        productCategoryID,
        productCategoryCode,
        productCategoryName,
      ];
}

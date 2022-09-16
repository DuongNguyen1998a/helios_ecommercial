import 'package:equatable/equatable.dart';

class SubCategory extends Equatable {
  final int productTypeID;
  final int productTypeParentID;
  final String productTypeName;
  final int status;
  final String description;
  final int categoryID;

  const SubCategory({
    required this.productTypeID,
    required this.productTypeParentID,
    required this.productTypeName,
    required this.status,
    required this.description,
    required this.categoryID,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      productTypeID: json['productTypeID'],
      productTypeParentID: json['productTypeParentID'],
      productTypeName: json['productTypeName'],
      status: json['status'],
      description: json['description'],
      categoryID: json['categoryID'],
    );
  }

  @override
  List<Object?> get props => [
        productTypeID,
        productTypeParentID,
        productTypeName,
        status,
        description,
        categoryID,
      ];
}

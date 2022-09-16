import 'package:equatable/equatable.dart';

class ProductDetail extends Equatable {
  final int productID;
  final String productCode;
  final String productName;
  final int status;
  final String description;
  final int brandID;
  final int productTypeID;
  final String informationTech;
  final bool isFavorite;
  final List<ListData> lstData;

  const ProductDetail({
    required this.productID,
    required this.productCode,
    required this.productName,
    required this.status,
    required this.description,
    required this.brandID,
    required this.productTypeID,
    required this.informationTech,
    required this.isFavorite,
    required this.lstData,
  });

  factory ProductDetail.fromJson(Map<String, dynamic> json) {
    List<ListData> lstData = <ListData>[];
    json['lstData'].forEach((v) {
      lstData.add(ListData.fromJson(v));
    });

    return ProductDetail(
      productID: json['productID'],
      productCode: json['productCode'],
      productName: json['productName'],
      status: json['status'],
      description: json['description'],
      brandID: json['brandID'],
      productTypeID: json['productTypeID'],
      informationTech: json['informationTech'],
      isFavorite: json['isFavorite'],
      lstData: lstData,
    );
  }

  @override
  List<Object?> get props => [
        productID,
        productCode,
        productName,
        status,
        description,
        brandID,
        productTypeID,
        informationTech,
        isFavorite,
        lstData,
      ];
}

class ListData extends Equatable {
  final String strTyle;
  final String strTitle;
  final List<dynamic> dtData;

  const ListData({
    required this.strTyle,
    required this.strTitle,
    required this.dtData,
  });

  factory ListData.fromJson(Map<String, dynamic> json) {
    return ListData(
      strTyle: json['strTyle'],
      strTitle: json['strTitle'],
      dtData: json['dtData'],
    );
  }

  @override
  List<Object?> get props => [
        strTyle,
        strTitle,
        dtData,
      ];
}

class Area extends Equatable {
  final int areaId;
  final String areaName;

  const Area({
    required this.areaId,
    required this.areaName,
  });

  factory Area.fromJson(Map<String, dynamic> json) {
    return Area(
      areaId: json['areaID'],
      areaName: json['areaName'],
    );
  }

  @override
  List<Object?> get props => [
        areaId,
        areaName,
      ];
}

class ProductImage extends Equatable {
  final int productImageId;
  final String title;
  final String imagePath;
  final int isAdv;

  const ProductImage({
    required this.productImageId,
    required this.title,
    required this.imagePath,
    required this.isAdv,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      productImageId: json['productImageID'],
      title: json['title'],
      imagePath: json['imagePath'],
      isAdv: json['isAdv'],
    );
  }

  @override
  List<Object?> get props => [
        productImageId,
        title,
        imagePath,
        isAdv,
      ];
}

class ProductRatingModel extends Equatable {
  final double rating;
  final String customerName;
  final String dateUpdated;
  final String contentComment;

  const ProductRatingModel({
    required this.rating,
    required this.customerName,
    required this.dateUpdated,
    required this.contentComment,
  });

  factory ProductRatingModel.fromJson(Map<String, dynamic> json) {
    return ProductRatingModel(
      rating: json['rating'],
      customerName: json['customerName'],
      dateUpdated: json['dateUpdated'],
      contentComment: json['contentComment'],
    );
  }

  @override
  List<Object?> get props => [
        rating,
        customerName,
        dateUpdated,
        contentComment,
      ];
}

class ProductSpec extends Equatable {
  final String title;
  final int specId;
  final String specCode;
  final String specName;
  final String ordSpec;

  const ProductSpec({
    required this.title,
    required this.specId,
    required this.specCode,
    required this.specName,
    required this.ordSpec,
  });

  @override
  List<Object?> get props => [
        title,
        specId,
        specCode,
        specName,
        ordSpec,
      ];
}

class Production extends Equatable {
  final int productionID;
  final int areaID;
  final int brandID;
  final int spec1;
  final int spec2;
  final int spec3;
  final int spec4;
  final int spec5;
  final int price;

  const Production({
    required this.productionID,
    required this.areaID,
    required this.brandID,
    required this.spec1,
    required this.spec2,
    required this.spec3,
    required this.spec4,
    required this.spec5,
    required this.price,
  });

  factory Production.fromJson(Map<String, dynamic> json) {
    return Production(
      productionID: json['productionID'],
      areaID: json['areaID'],
      brandID: json['brandID'],
      spec1: json['spec1'],
      spec2: json['spec2'],
      spec3: json['spec3'],
      spec4: json['spec4'],
      spec5: json['spec5'],
      price: json['price'],
    );
  }

  @override
  List<Object?> get props => [
        productionID,
        areaID,
        brandID,
        spec1,
        spec2,
        spec3,
        spec4,
        spec5,
        price,
      ];
}

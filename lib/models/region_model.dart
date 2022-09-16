import 'package:equatable/equatable.dart';

class RegionModel extends Equatable {
  final int regionID;
  final int regionCode;
  final String regionyName;
  final int parentID;
  final String description;
  final int status;

  const RegionModel({
    required this.regionID,
    required this.regionCode,
    required this.regionyName,
    required this.parentID,
    required this.description,
    required this.status,
  });

  factory RegionModel.fromJson(Map<String, dynamic> json) {
    return RegionModel(
      regionID: json['regionID'],
      regionCode: json['regionCode'],
      regionyName: json['regionyName'],
      parentID: json['parentID'],
      description: json['description'],
      status: json['status'],
    );
  }

  @override
  List<Object?> get props => [
        regionID,
        regionCode,
        regionyName,
        parentID,
        description,
        status,
      ];
}

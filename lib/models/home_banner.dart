import 'package:equatable/equatable.dart';

class HomeBanner extends Equatable {
  final String imagePath;
  final int isAdv;

  const HomeBanner({
    required this.imagePath,
    required this.isAdv,
  });

  factory HomeBanner.fromJson(Map<String, dynamic> json) {
    return HomeBanner(
      imagePath: json['imagePath'],
      isAdv: json['isAdv'],
    );
  }

  @override
  List<Object?> get props => [
    imagePath,
    isAdv,
  ];
}

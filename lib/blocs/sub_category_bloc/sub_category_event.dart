part of 'sub_category_bloc.dart';

abstract class SubCategoryEvent extends Equatable {
  const SubCategoryEvent();
}

class FetchSubCategory extends SubCategoryEvent {
  final int categoryId;
  final List<SubCategory> subCategories;

  const FetchSubCategory({
    this.categoryId = 0,
    this.subCategories = const [],
  });

  @override
  List<Object?> get props => [categoryId, subCategories];
}
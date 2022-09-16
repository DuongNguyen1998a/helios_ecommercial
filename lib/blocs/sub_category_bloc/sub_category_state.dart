part of 'sub_category_bloc.dart';

abstract class SubCategoryState extends Equatable {
  const SubCategoryState();
}

class SubCategoryInitial extends SubCategoryState {
  @override
  List<Object> get props => [];
}

class SubCategoryLoading extends SubCategoryState {
  @override
  List<Object> get props => [];
}

class SubCategoryLoadedSuccess extends SubCategoryState {
  final List<SubCategory> subCategories;

  const SubCategoryLoadedSuccess({this.subCategories = const []});

  @override
  List<Object> get props => [subCategories];
}

class SubCategoryLoadedError extends SubCategoryState {
  @override
  List<Object> get props => [];
}

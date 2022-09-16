part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();
}

class CategoryInitial extends CategoryState {
  @override
  List<Object> get props => [];
}

class CategoryLoading extends CategoryState {
  @override
  List<Object> get props => [];
}

class CategoryLoadedSuccess extends CategoryState {
  final List<Category> mainCategories;

  const CategoryLoadedSuccess({this.mainCategories = const []});

  @override
  List<Object> get props => [mainCategories];
}

class CategoryLoadedError extends CategoryState {
  @override
  List<Object> get props => [];
}

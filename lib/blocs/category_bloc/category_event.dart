part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();
}

class FetchMainCategory extends CategoryEvent {
  final List<Category> mainCategories;

  const FetchMainCategory({
    this.mainCategories = const [],
  });

  @override
  List<Object?> get props => [mainCategories];
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Blocs
import '../../../blocs/category_bloc/category_bloc.dart';
import '../../../blocs/sub_category_bloc/sub_category_bloc.dart';

/// Models
import '../../../models/category.dart';

/// Responsive
import '../../../utils/responsive.dart';

class MainCategoryList extends StatelessWidget {
  const MainCategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<CategoryBloc, CategoryState>(
      listener: (context, state) {
        if (state is CategoryLoadedSuccess) {
          if (state.mainCategories.isNotEmpty) {
            context.read<SubCategoryBloc>().add(
                  FetchSubCategory(
                    categoryId: state.mainCategories[0].productCategoryID,
                  ),
                );
          }
        }
      },
      child: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CategoryLoadedSuccess) {
            return Container(
              alignment: Alignment.topCenter,
              color: const Color(0xFFF1B254),
              padding: EdgeInsets.symmetric(
                  horizontal: Responsive.isMobile(context) ? 2 : 4),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    state.mainCategories.length,
                    (index) => MainCategoryItem(
                        mainCategory: state.mainCategories[index]),
                  ),
                ),
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}

class MainCategoryItem extends StatelessWidget {
  final Category mainCategory;

  const MainCategoryItem({
    Key? key,
    required this.mainCategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(
        vertical: Responsive.isMobile(context) ? 8 : 16,
        horizontal: Responsive.isMobile(context) ? 8 : 16,
      ),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        onTap: () {
          context.read<SubCategoryBloc>().add(
                FetchSubCategory(
                  categoryId: mainCategory.productCategoryID,
                ),
              );
        },
        title: Text(
          mainCategory.productCategoryName,
          style: TextStyle(
            fontSize: Responsive.isMobile(context) ? 12 : 24,
            fontFamily: 'MyriadProRegular',
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
          maxLines: 3,
        ),
      ),
    );
  }
}

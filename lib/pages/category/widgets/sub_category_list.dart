import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Blocs
import '../../../blocs/sub_category_bloc/sub_category_bloc.dart';

/// Models
import '../../../models/sub_category.dart';

/// Routes
import '../../../routes/app_routes.dart';

/// Responsive
import '../../../utils/responsive.dart';

class SubCategoryList extends StatelessWidget {
  const SubCategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubCategoryBloc, SubCategoryState>(
      builder: (context, state) {
        if (state is SubCategoryLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SubCategoryLoadedSuccess) {
          return Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  state.subCategories.length,
                  (index) => SubCategoryItem(
                    subCategory: state.subCategories[index],
                    onItemClick: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.product,
                        arguments: state.subCategories[index],
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

class SubCategoryItem extends StatelessWidget {
  final SubCategory subCategory;
  final Function onItemClick;

  const SubCategoryItem({
    Key? key,
    required this.subCategory,
    required this.onItemClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(
        horizontal: Responsive.isMobile(context) ? 10 : 20,
        vertical: Responsive.isMobile(context) ? 10 : 20,
      ),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
          ),
        ),
      ),
      child: ListTile(
        onTap: () {
          onItemClick();
        },
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                subCategory.productTypeName,
                style: TextStyle(
                  fontFamily: 'MyriadProRegular',
                  fontWeight: FontWeight.w600,
                  fontSize: Responsive.isMobile(context) ? 12 : 24,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: Responsive.isMobile(context) ? 14 : 28,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}

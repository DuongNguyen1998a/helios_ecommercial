import 'package:flutter/material.dart';
/// Widgets
import 'widgets/main_category_list.dart';
import 'widgets/sub_category_list.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            color: const Color(0xFFF1B254),
           child: const MainCategoryList(),
          ),
        ),
        Expanded(
          flex: 5,
          child: Container(
            color: Colors.white,
            child: const SubCategoryList(),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Blocs
import 'blocs/home_bloc/home_bloc.dart';
import 'blocs/product_bloc/product_bloc.dart';
import 'blocs/product_detail_bloc/product_detail_bloc.dart';
import 'blocs/sub_category_bloc/sub_category_bloc.dart';
import 'blocs/category_bloc/category_bloc.dart';
import 'blocs/auth_bloc/auth_bloc.dart';
import 'blocs/favorite_bloc/favorite_bloc.dart';
import 'blocs/cart_bloc/cart_bloc.dart';
import 'blocs/contract_bloc/contract_bloc.dart';
import 'blocs/sale_bloc/sale_bloc.dart';

import 'blocs/user_approve_bloc/user_approve_bloc.dart';
/// Pages
import 'pages/main_wrapper_page.dart';

/// Colors
import 'colors/app_colors.dart';

/// Routes
import 'routes/app_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Keep application with screen portraitUp
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
      const MyApp(),
    );
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc()..add(const FetchHome()),
        ),
        BlocProvider<ProductDetailBloc>(
          create: (context) => ProductDetailBloc(),
        ),
        BlocProvider<CategoryBloc>(
          create: (context) => CategoryBloc()..add(const FetchMainCategory()),
        ),
        BlocProvider<SubCategoryBloc>(
          create: (context) => SubCategoryBloc(),
        ),
        BlocProvider<ProductBloc>(
          create: (context) => ProductBloc(),
        ),
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(),
        ),
        BlocProvider<FavoriteBloc>(
          create: (context) => FavoriteBloc()..add(const FetchFavProducts()),
        ),
        BlocProvider<CartBloc>(
          create: (context) => CartBloc()..add(const FetchCarts()),
        ),
        BlocProvider<SaleBloc>(
          create: (context) => SaleBloc()..add(const FetchSales()),
        ),
        BlocProvider<ContractBloc>(
          create: (context) => ContractBloc()..add(const FetchContracts()),
        ),
        BlocProvider<UserApproveBloc>(
          create: (context) => UserApproveBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Helios E-commerce Application',
        debugShowCheckedModeBanner: false,
        theme: Theme.of(context).copyWith(
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: primaryColor,
              ),
        ),
        home: const MainWrapperPage(),
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}

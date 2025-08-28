import 'package:clean_architecture/di/injection.dart';
import 'package:clean_architecture/domain/usecases/delete_product.dart';
import 'package:clean_architecture/domain/usecases/get_all_products.dart';
import 'package:clean_architecture/domain/usecases/save_product.dart';
import 'package:clean_architecture/presentation/bloc/product_bloc.dart';
import 'package:clean_architecture/presentation/bloc/product_event.dart';
import 'package:clean_architecture/presentation/pages/product_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Inventario PyME',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1565C0)),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(centerTitle: true),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      home: BlocProvider(
        create: (context) => ProductBloc(
          getAllProducts: sl<GetAllProducts>(),
          saveProduct: sl<SaveProduct>(),
          deleteProduct: sl<DeleteProduct>(),
          adjustStock: sl(),
          getLowStockProducts: sl(),
        )..add(LoadProducts()),
        child: const ProductListPage(),
      ),
    );
  }
}

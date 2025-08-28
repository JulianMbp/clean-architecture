import 'package:clean_architecture/data/repositories/product_repository_impl.dart';
import 'package:clean_architecture/domain/repositories/product_repository.dart';
import 'package:clean_architecture/domain/usecases/adjust_stock.dart';
import 'package:clean_architecture/domain/usecases/delete_product.dart';
import 'package:clean_architecture/domain/usecases/get_all_products.dart';
import 'package:clean_architecture/domain/usecases/get_low_stock_products.dart';
import 'package:clean_architecture/domain/usecases/save_product.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initInjection() async {
  // Repositories
  sl.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl());

  // Use cases
  sl.registerLazySingleton(() => GetAllProducts(sl()));
  sl.registerLazySingleton(() => SaveProduct(sl()));
  sl.registerLazySingleton(() => DeleteProduct(sl()));
  sl.registerLazySingleton(() => AdjustStock(sl()));
  sl.registerLazySingleton(() => GetLowStockProducts(sl()));
}



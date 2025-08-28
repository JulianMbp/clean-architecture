import 'package:clean_architecture/domain/entities/product.dart';
import 'package:clean_architecture/domain/repositories/product_repository.dart';

class GetLowStockProducts {
  final ProductRepository repository;

  GetLowStockProducts(this.repository);

  Future<List<Product>> call() async {
    return repository.getLowStockProducts();
  }
}



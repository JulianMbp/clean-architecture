import 'package:clean_architecture/domain/repositories/product_repository.dart';

class AdjustStock {
  final ProductRepository repository;

  AdjustStock(this.repository);

  Future<void> call({required String productId, required int delta}) async {
    if (delta == 0) return;
    await repository.adjustStock(productId: productId, delta: delta);
  }
}



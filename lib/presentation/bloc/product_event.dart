import 'package:clean_architecture/domain/entities/product.dart';

abstract class ProductEvent {}

class LoadProducts extends ProductEvent {}

class AddProduct extends ProductEvent {
  final Product product;
  AddProduct(this.product);
}

class DeleteProductEvent extends ProductEvent {
  final String id;
  DeleteProductEvent(this.id);
}

class AdjustStockEvent extends ProductEvent {
  final String productId;
  final int delta;
  AdjustStockEvent({required this.productId, required this.delta});
}

class LoadLowStock extends ProductEvent {}

class UpdateProductEvent extends ProductEvent {
  final Product product;
  UpdateProductEvent(this.product);
}
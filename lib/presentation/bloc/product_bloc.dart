import 'package:clean_architecture/domain/usecases/adjust_stock.dart';
import 'package:clean_architecture/domain/usecases/delete_product.dart';
import 'package:clean_architecture/domain/usecases/get_all_products.dart';
import 'package:clean_architecture/domain/usecases/get_low_stock_products.dart';
import 'package:clean_architecture/domain/usecases/save_product.dart';
import 'package:clean_architecture/presentation/bloc/product_event.dart';
import 'package:clean_architecture/presentation/bloc/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetAllProducts getAllProducts;
  final SaveProduct saveProduct;
  final DeleteProduct deleteProduct;
  final AdjustStock adjustStock;
  final GetLowStockProducts getLowStockProducts;

  ProductBloc({
    required this.getAllProducts,
    required this.saveProduct,
    required this.deleteProduct,
    required this.adjustStock,
    required this.getLowStockProducts,
  }) : super(ProductInitial()) {
    on<LoadProducts>(_onLoadProducts);
    on<AddProduct>(_onAddProduct);
    on<DeleteProductEvent>(_onDeleteProduct);
    on<AdjustStockEvent>(_onAdjustStock);
    on<LoadLowStock>(_onLoadLowStock);
    on<UpdateProductEvent>(_onUpdateProduct);
  }

  Future<void> _onLoadProducts(
    LoadProducts event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    try {
      final products = await getAllProducts.execute();
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> _onAddProduct(
    AddProduct event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    try {
      await saveProduct.execute(event.product);
      final products = await getAllProducts.execute();
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> _onDeleteProduct(
    DeleteProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    try {
      await deleteProduct.execute(event.id);
      final products = await getAllProducts.execute();
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> _onAdjustStock(
    AdjustStockEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    try {
      await adjustStock.call(productId: event.productId, delta: event.delta);
      final products = await getAllProducts.execute();
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> _onLoadLowStock(
    LoadLowStock event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    try {
      final products = await getLowStockProducts.call();
      emit(LowStockLoaded(products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> _onUpdateProduct(
    UpdateProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    try {
      await saveProduct.execute(event.product);
      final products = await getAllProducts.execute();
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}

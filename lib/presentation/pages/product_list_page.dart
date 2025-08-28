import 'package:clean_architecture/domain/entities/product.dart';
import 'package:clean_architecture/presentation/bloc/product_bloc.dart';
import 'package:clean_architecture/presentation/bloc/product_event.dart';
import 'package:clean_architecture/presentation/bloc/product_state.dart';
// import 'package:uuid/uuid.dart';
import 'package:clean_architecture/presentation/pages/low_stock_page.dart';
import 'package:clean_architecture/presentation/widgets/product_card.dart';
import 'package:clean_architecture/presentation/widgets/product_form_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventario'),
        actions: [
          IconButton(
            icon: const Icon(Icons.warning_amber_rounded),
            tooltip: 'Ver bajo stock',
            onPressed: () {
              context.read<ProductBloc>().add(LoadLowStock());
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (routeContext) => BlocProvider.value(
                    value: context.read<ProductBloc>(),
                    child: const LowStockPage(),
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<ProductBloc>().add(LoadProducts());
            },
          ),
        ],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ProductError) {
            return Center(child: Text(state.message));
          }
          if (state is ProductLoaded || state is LowStockLoaded) {
            final products = state is ProductLoaded ? state.products : (state as LowStockLoaded).products;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ProductCard(
                  product: product,
                  onDecrement: () => context.read<ProductBloc>().add(AdjustStockEvent(productId: product.id, delta: -1)),
                  onIncrement: () => context.read<ProductBloc>().add(AdjustStockEvent(productId: product.id, delta: 1)),
                  onDelete: () => context.read<ProductBloc>().add(DeleteProductEvent(product.id)),
                  onEdit: () async {
                    final updated = await showDialog<Product>(
                      context: context,
                      builder: (context) => ProductFormDialog(existing: product),
                    );
                    if (updated != null) {
                      context.read<ProductBloc>().add(UpdateProductEvent(updated));
                    }
                  },
                );
              },
            );
          }
          return const Center(child: Text('No products'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final created = await showDialog<Product>(
            context: context,
            builder: (context) => const ProductFormDialog(),
          );
          if (created != null) {
            context.read<ProductBloc>().add(AddProduct(created));
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Dialogo extraído a widgets/ProductFormDialog.dart

import 'package:clean_architecture/domain/entities/product.dart';
import 'package:clean_architecture/presentation/bloc/product_bloc.dart';
import 'package:clean_architecture/presentation/bloc/product_event.dart';
import 'package:clean_architecture/presentation/bloc/product_state.dart';
import 'package:clean_architecture/presentation/widgets/product_card.dart';
import 'package:clean_architecture/presentation/widgets/product_form_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LowStockPage extends StatelessWidget {
  const LowStockPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bajo stock')),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ProductError) {
            return Center(child: Text(state.message));
          }
          final List<Product> products = state is LowStockLoaded
              ? state.products
              : (state is ProductLoaded
                  ? state.products.where((p) => p.stockQuantity <= p.minStock).toList()
                  : <Product>[]);
          if (products.isEmpty) {
            return const Center(child: Text('Sin productos en bajo stock'));
          }
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
                    // Volver al listado de bajo stock tras editar
                    if (!context.mounted) return;
                    context.read<ProductBloc>().add(UpdateProductEvent(updated));
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}



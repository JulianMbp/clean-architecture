import 'package:clean_architecture/domain/entities/product.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const ProductCard({
    super.key,
    required this.product,
    required this.onDecrement,
    required this.onIncrement,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final isLow = product.stockQuantity <= product.minStock;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: Text(product.name.isNotEmpty ? product.name[0].toUpperCase() : '?'),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          product.name,
                          style: Theme.of(context).textTheme.titleMedium,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (isLow)
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Chip(
                            label: const Text('Bajo stock'),
                            visualDensity: VisualDensity.compact,
                            backgroundColor: Theme.of(context).colorScheme.errorContainer,
                            labelStyle: TextStyle(color: Theme.of(context).colorScheme.onErrorContainer),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text('SKU: ${product.sku}'),
                  const SizedBox(height: 2),
                  Text('Precio: \$${product.price.toStringAsFixed(2)}   Costo: \$${product.cost.toStringAsFixed(2)}'),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text('Stock: ${product.stockQuantity}', style: TextStyle(color: isLow ? Theme.of(context).colorScheme.error : null)),
                      const SizedBox(width: 8),
                      Text('Mín: ${product.minStock}', style: TextStyle(color: isLow ? Theme.of(context).colorScheme.error : null)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 192,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    tooltip: 'Quitar 1',
                    icon: const Icon(Icons.remove_circle_outline),
                    onPressed: onDecrement,
                  ),
                  IconButton(
                    tooltip: 'Agregar 1',
                    icon: const Icon(Icons.add_circle_outline),
                    onPressed: onIncrement,
                  ),
                  IconButton(
                    tooltip: 'Eliminar',
                    icon: const Icon(Icons.delete_outline),
                    onPressed: onDelete,
                  ),
                  IconButton(
                    tooltip: 'Editar',
                    icon: const Icon(Icons.edit_outlined),
                    onPressed: onEdit,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



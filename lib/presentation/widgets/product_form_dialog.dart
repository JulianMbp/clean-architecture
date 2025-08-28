import 'package:clean_architecture/domain/entities/product.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ProductFormDialog extends StatefulWidget {
  final Product? existing;
  const ProductFormDialog({super.key, this.existing});

  @override
  State<ProductFormDialog> createState() => _ProductFormDialogState();
}

class _ProductFormDialogState extends State<ProductFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _skuCtrl = TextEditingController();
  final _priceCtrl = TextEditingController(text: '0');
  final _costCtrl = TextEditingController(text: '0');
  final _stockCtrl = TextEditingController(text: '0');
  final _minCtrl = TextEditingController(text: '0');
  final _descCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    final p = widget.existing;
    if (p != null) {
      _nameCtrl.text = p.name;
      _skuCtrl.text = p.sku;
      _priceCtrl.text = p.price.toStringAsFixed(2);
      _costCtrl.text = p.cost.toStringAsFixed(2);
      _stockCtrl.text = p.stockQuantity.toString();
      _minCtrl.text = p.minStock.toString();
      _descCtrl.text = p.description;
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _skuCtrl.dispose();
    _priceCtrl.dispose();
    _costCtrl.dispose();
    _stockCtrl.dispose();
    _minCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.existing != null;
    return AlertDialog(
      title: Text(isEditing ? 'Editar producto' : 'Nuevo producto'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameCtrl,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (v) => (v == null || v.isEmpty) ? 'Requerido' : null,
              ),
              TextFormField(
                controller: _skuCtrl,
                decoration: const InputDecoration(labelText: 'SKU'),
                validator: (v) => (v == null || v.isEmpty) ? 'Requerido' : null,
              ),
              TextFormField(
                controller: _priceCtrl,
                decoration: const InputDecoration(labelText: 'Precio'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _costCtrl,
                decoration: const InputDecoration(labelText: 'Costo'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _stockCtrl,
                decoration: const InputDecoration(labelText: 'Stock inicial'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _minCtrl,
                decoration: const InputDecoration(labelText: 'Stock mínimo'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _descCtrl,
                decoration: const InputDecoration(labelText: 'Descripción'),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            if (!_formKey.currentState!.validate()) return;
            final baseId = widget.existing?.id ?? const Uuid().v4();
            final product = Product(
              id: baseId,
              sku: _skuCtrl.text.trim(),
              name: _nameCtrl.text.trim(),
              price: double.tryParse(_priceCtrl.text) ?? 0,
              cost: double.tryParse(_costCtrl.text) ?? 0,
              description: _descCtrl.text.trim(),
              stockQuantity: int.tryParse(_stockCtrl.text) ?? 0,
              minStock: int.tryParse(_minCtrl.text) ?? 0,
            );
            Navigator.of(context).pop(product);
          },
          child: Text(isEditing ? 'Guardar' : 'Crear'),
        ),
      ],
    );
  }
}



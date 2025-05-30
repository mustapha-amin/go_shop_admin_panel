import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_shop_admin_panel/consts/product_categories.dart';
import 'package:go_shop_admin_panel/consts/textstyle.dart';
import 'package:go_shop_admin_panel/features/products/controllers/product_controller.dart';
import 'package:go_shop_admin_panel/model/product.dart';
import 'package:sizer/sizer.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class Inventory extends ConsumerWidget {
  const Inventory({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryCounts = ref.watch(categoryCountsProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final filteredProducts = ref.watch(filteredProductsProvider);

    return ref
        .watch(productNotifierProvider)
        .when(
          data: (products) {
            return SizedBox(
              width: 60.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category Filter Chips
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ...['All', ...productCategories].map(
                            (category) => Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: FilterChip(
                                label: Text(
                                  '$category (${categoryCounts[category] ?? 0})',
                                  style: kTextStyle(
                                    14,
                                    color: selectedCategory == category
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                                selected: selectedCategory == category,
                                onSelected: (selected) {
                                  if (selected) {
                                    ref
                                            .read(
                                              selectedCategoryProvider.notifier,
                                            )
                                            .state =
                                        category;
                                  }
                                },
                                backgroundColor: Colors.grey[200],
                                selectedColor: Theme.of(context).primaryColor,
                                checkmarkColor: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Products List
                  Expanded(
                    child: ListView(
                      children: [
                        ...filteredProducts.map(
                          (product) => Card(
                            child: ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  product.imageUrls![0],
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: Text(
                                product.name,
                                style: kTextStyle(16, isBold: true),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Price: ${NumberFormat.simpleCurrency(name: "N", decimalDigits: 0).format(product.basePrice)}',
                                    style: kTextStyle(14),
                                  ),
                                  Text(
                                    'Stock: ${product.quantity}',
                                    style: kTextStyle(14),
                                  ),
                                  Text(
                                    'Brand: ${product.brand}',
                                    style: kTextStyle(14),
                                  ),
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () =>
                                        _showEditDialog(context, ref, product),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () => _showDeleteDialog(
                                      context,
                                      ref,
                                      product.id,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          error: (e, _) {
            return Center(
              child: Text(
                'Error: $e',
                style: kTextStyle(16, color: Colors.red),
              ),
            );
          },
          loading: () {
            return const Center(child: CircularProgressIndicator());
          },
        );
  }

  void _showDeleteDialog(
    BuildContext context,
    WidgetRef ref,
    String productId,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Product', style: kTextStyle(18, isBold: true)),
        content: Text(
          'Are you sure you want to delete this product?',
          style: kTextStyle(16),
        ),
        actions: [
          ShadButton(
            backgroundColor: Colors.transparent,
            hoverBackgroundColor: Colors.transparent,
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: kTextStyle(14)),
          ),
          ShadButton(
            onPressed: () {
              ref
                  .read(productNotifierProvider.notifier)
                  .deleteProduct(productId);
              Navigator.pop(context);
            },
            child: Text('Delete', style: kTextStyle(14, color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context, WidgetRef ref, Product product) {
    final nameController = TextEditingController(text: product.name);
    final descriptionController = TextEditingController(
      text: product.description,
    );
    final priceController = TextEditingController(
      text: product.basePrice.toString(),
    );
    final quantityController = TextEditingController(
      text: product.quantity.toString(),
    );
    final brandController = TextEditingController(text: product.brand);
    final discountController = TextEditingController(
      text: product.discountPercentage.toString(),
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Product', style: kTextStyle(18, isBold: true)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ShadInputFormField(
                controller: nameController,
                placeholder: Text('Name', style: kTextStyle(14)),
                decoration: ShadDecoration(
                  border: ShadBorder(
                    padding: const EdgeInsets.all(4),
                    radius: BorderRadius.circular(12),
                  ),
                  focusedBorder: ShadBorder(
                    padding: const EdgeInsets.all(4),
                    radius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ShadInputFormField(
                controller: descriptionController,
                placeholder: Text('Description', style: kTextStyle(14)),
                maxLines: 3,
                decoration: ShadDecoration(
                  border: ShadBorder(
                    padding: const EdgeInsets.all(4),
                    radius: BorderRadius.circular(12),
                  ),
                  focusedBorder: ShadBorder(
                    padding: const EdgeInsets.all(4),
                    radius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ShadInputFormField(
                controller: priceController,
                placeholder: Text('Base Price', style: kTextStyle(14)),
                keyboardType: TextInputType.number,
                decoration: ShadDecoration(
                  border: ShadBorder(
                    padding: const EdgeInsets.all(4),
                    radius: BorderRadius.circular(12),
                  ),
                  focusedBorder: ShadBorder(
                    padding: const EdgeInsets.all(4),
                    radius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ShadInputFormField(
                controller: quantityController,
                placeholder: Text('Quantity', style: kTextStyle(14)),
                keyboardType: TextInputType.number,
                decoration: ShadDecoration(
                  border: ShadBorder(
                    padding: const EdgeInsets.all(4),
                    radius: BorderRadius.circular(12),
                  ),
                  focusedBorder: ShadBorder(
                    padding: const EdgeInsets.all(4),
                    radius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ShadInputFormField(
                controller: brandController,
                placeholder: Text('Brand', style: kTextStyle(14)),
                decoration: ShadDecoration(
                  border: ShadBorder(
                    padding: const EdgeInsets.all(4),
                    radius: BorderRadius.circular(12),
                  ),
                  focusedBorder: ShadBorder(
                    padding: const EdgeInsets.all(4),
                    radius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ShadInputFormField(
                controller: discountController,
                placeholder: Text('Discount Percentage', style: kTextStyle(14)),
                keyboardType: TextInputType.number,
                decoration: ShadDecoration(
                  border: ShadBorder(
                    padding: const EdgeInsets.all(4),
                    radius: BorderRadius.circular(12),
                  ),
                  focusedBorder: ShadBorder(
                    padding: const EdgeInsets.all(4),
                    radius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          ShadButton(
            backgroundColor: Colors.transparent,
            hoverBackgroundColor: Colors.transparent,
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: kTextStyle(14)),
          ),
          ShadButton(
            onPressed: () {
              final updatedProduct = product.copyWith(
                name: nameController.text,
                description: descriptionController.text,
                basePrice:
                    double.tryParse(priceController.text) ?? product.basePrice,
                quantity:
                    int.tryParse(quantityController.text) ?? product.quantity,
                brand: brandController.text,
                discountPercentage:
                    double.tryParse(discountController.text) ??
                    product.discountPercentage,
              );
              ref
                  .read(productNotifierProvider.notifier)
                  .updateProduct(updatedProduct);
              Navigator.pop(context);
            },
            child: Text('Save', style: kTextStyle(14, color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

import 'dart:developer';
import 'dart:typed_data';

import 'package:another_flushbar/flushbar.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_shop_admin_panel/consts/textstyle.dart';
import 'package:go_shop_admin_panel/core/extensions.dart';
import 'package:go_shop_admin_panel/features/dashboard/widgets/drawer.dart';
import 'package:go_shop_admin_panel/features/products/controllers/product_controller.dart';
import 'package:go_shop_admin_panel/model/product.dart';
import 'package:go_shop_admin_panel/shared/k_flushbar.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:sizer/sizer.dart';
import 'package:uuid/uuid.dart';

final pickedImagesProvider = StateProvider<List<Uint8List>>((ref) {
  return [];
});
final productNameProvider = StateProvider<String>((ref) => '');
final descriptionProvider = StateProvider<String>((ref) => '');
final priceProvider = StateProvider<String>((ref) => '');
final discountProvider = StateProvider<String>((ref) => '');
final quantityProvider = StateProvider<String>((ref) => '');
final categoryProvider = StateProvider<String?>((ref) => null);
final brandProvider = StateProvider<String>((ref) => '');

final formIsValidProvider = StateProvider<bool>((ref) {
  return ref.watch(pickedImagesProvider).isNotEmpty &&
      ref.watch(productNameProvider).isNotEmpty &&
      ref.watch(descriptionProvider).isNotEmpty &&
      ref.watch(priceProvider).isNotEmpty &&
      ref.watch(quantityProvider).isNotEmpty &&
      ref.watch(categoryProvider)!.isNotEmpty &&
      ref.watch(brandProvider).isNotEmpty;
});

final List<String> productCategories = [
  'Appliances',
  'Phones and tablets',
  'Electronics',
  'Computing',
  'Clothing',
  'Other',
];

class AddProducts extends ConsumerStatefulWidget {
  const AddProducts({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddProductsState();
}

class _AddProductsState extends ConsumerState<AddProducts> {
  late TextEditingController productNameController,
      descriptionController,
      priceController,
      discountController,
      brandController,
      quantityController;

  String? selectedCategory;

  void pickImages(BuildContext context) async {
    List<Uint8List>? imageBytes = await ImagePickerWeb.getMultiImagesAsBytes();
    if (imageBytes != null) {
      final pickedImages = ref.read(pickedImagesProvider.notifier).state;
      if (ref.read(pickedImagesProvider).length == 5) {
        if (context.mounted) {
          displayFlushBar(
            context,
            "You cannot add more than five images",
            isError: true,
          );
        }
      }
      if (pickedImages.length < 5) {
        ref.read(pickedImagesProvider.notifier).state = [
          ...pickedImages,
          ...imageBytes.take((5 - pickedImages.length).abs()),
        ];
      }
    }
  }

  @override
  void initState() {
    super.initState();
    productNameController = TextEditingController(
      text: ref.read(productNameProvider),
    );
    descriptionController = TextEditingController(
      text: ref.read(descriptionProvider),
    );
    priceController = TextEditingController(text: ref.read(priceProvider));
    discountController = TextEditingController(
      text: ref.read(discountProvider),
    );
    quantityController = TextEditingController(
      text: ref.read(quantityProvider),
    );
    brandController = TextEditingController(text: ref.read(brandProvider));

    productNameController.addListener(() {
      ref.read(productNameProvider.notifier).state = productNameController.text;
    });
    descriptionController.addListener(() {
      ref.read(descriptionProvider.notifier).state = descriptionController.text;
    });
    priceController.addListener(() {
      ref.read(priceProvider.notifier).state = priceController.text;
    });
    discountController.addListener(() {
      ref.read(discountProvider.notifier).state = discountController.text;
    });
    quantityController.addListener(() {
      ref.read(quantityProvider.notifier).state = quantityController.text;
    });
    brandController.addListener(() {
      ref.read(brandProvider.notifier).state = brandController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 1000;
        return isMobile
            ? ListView(
                children: [
                  Expanded(child: _buildImagesSection()),
                  _buildInfoSection(full: false),
                  _uploadProductButton(),
                ],
              )
            : ListView(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoSection(),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildImagesSection(),
                            _uploadProductButton(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
      },
    );
  }

  Widget _uploadProductButton() {
    return Consumer(
      builder: (context, ref, _) {
        final formIsValid = ref.watch(formIsValidProvider);
        return ShadButton(
          enabled: formIsValid,
          child: Text("Upload product"),
          onPressed: () async {
            if (formIsValid) {
              final product = Product(
                id: Uuid().v4(),
                name: productNameController.text,
                description: descriptionController.text,
                quantity: int.parse(
                  quantityController.text.replaceAll(',', '').trim(),
                ),
                category: ref.watch(categoryProvider)!,
                basePrice: double.parse(
                  priceController.text.replaceAll(',', '').trim(),
                ),
                discountPercentage:
                    double.tryParse(
                      discountController.text.replaceAll(',', '').trim(),
                    ) ??
                    0,
                brand: brandController.text,
              );
              log(product.toString());
              await ref
                  .read(productNotifierProvider.notifier)
                  .addProducts(product, ref.read(pickedImagesProvider));
              ref.invalidate(pickedImagesProvider);
              ref.invalidate(productNameProvider);
              ref.invalidate(descriptionProvider);
              ref.invalidate(priceProvider);
              ref.invalidate(discountProvider);
              ref.invalidate(quantityProvider);
              ref.invalidate(categoryProvider);
              ref.invalidate(brandProvider);
              ref.invalidate(dashboardIndexProvider);
              ref.invalidate(productNotifierProvider);
            }
          },
        );
      },
    );
  }

  Widget _buildImagesSection() {
    final pickedImages = ref.watch(pickedImagesProvider);

    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 2,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildSectionTitle("Images"),
          Stack(
            children: [
              DottedBorder(
                borderType: BorderType.RRect,
                color: Colors.grey,
                radius: Radius.circular(12),
                child: SizedBox(
                  width: double.infinity,
                  height: 40.h,
                  child: pickedImages.isNotEmpty
                      ? Image.memory(pickedImages[0], fit: BoxFit.contain)
                      : Center(child: Icon(Iconsax.image_copy, size: 60)),
                ),
              ),
              Positioned(
                top: 3,
                right: 3,
                child: IconButton.filledTonal(
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.black.withValues(alpha: 0.1),
                  ),
                  onPressed: () {
                    ref.read(pickedImagesProvider.notifier).state = pickedImages
                        .where((image) => pickedImages.indexOf(image) > 0)
                        .toList();
                  },
                  icon: Icon(Icons.close),
                ),
              ),
            ],
          ),
          Row(
            spacing: 5,
            children: [
              ...pickedImages
                  .where((image) => pickedImages.indexOf(image) > 0)
                  .map(
                    (image) => Stack(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: MemoryImage(image),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 3,
                          right: 3,
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: InkWell(
                              onTap: () {
                                ref
                                    .read(pickedImagesProvider.notifier)
                                    .state = pickedImages
                                    .where((e) => image != e)
                                    .toList();
                              },
                              child: Container(
                                padding: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black.withValues(alpha: 0.1),
                                ),
                                child: Icon(Icons.close),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              InkWell(
                hoverColor: Colors.grey[100],
                onTap: () {
                  pickImages(context);
                },
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(child: Icon(Iconsax.add_copy, size: 30)),
                ),
              ),
            ],
          ).padY(10),
        ],
      ).padAll(8),
    );
  }

  Widget _buildInfoSection({bool full = true}) {
    return Expanded(
      flex: full ? 2 : 1,
      child: Column(
        children: [
          Column(
            spacing: 10,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 2,
                      blurStyle: BlurStyle.outer,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildSectionTitle('General Information'),
                    _buildTextField(
                      'Product Name',
                      textEditingController: productNameController,
                    ),
                    _buildTextField(
                      'Description',
                      maxLines: 10,
                      textEditingController: descriptionController,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            'Quantity',
                            textEditingController: quantityController,
                            textnputType: TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            formatter: ThousandsFormatter(),
                          ),
                        ),
                        Expanded(
                          child: _buildTextField(
                            'Brand',
                            textEditingController: brandController,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[300]!),
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.grey[200],
                            ),
                            child: DropdownButton<String>(
                              value: ref.watch(categoryProvider),
                              hint: Text(
                                'Select Category',
                                style: kTextStyle(14),
                              ),
                              underline: SizedBox(),
                              padding: EdgeInsets.symmetric(horizontal: 3),
                              items: productCategories.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value, style: kTextStyle(14)),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                ref.read(categoryProvider.notifier).state =
                                    newValue!;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ).padAll(8),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 2,
                      blurStyle: BlurStyle.outer,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildSectionTitle('Pricing'),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            'Base Price',
                            prefixIcon: Text('₦'),
                            textEditingController: priceController,
                            formatter: ThousandsFormatter(),
                            textnputType: TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildTextField(
                            'Discount Percentage (%)',
                            textnputType: TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            formatter: ThousandsFormatter(),
                            textEditingController: discountController,
                          ),
                        ),
                      ],
                    ),
                  ],
                ).padAll(8),
              ),
              const SizedBox(height: 16),
            ],
          ).padAll(8),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: title.style(fontSize: 25, isBold: true),
    );
  }

  Widget _buildTextField(
    String hint, {
    Widget? prefixIcon,
    IconData? suffixIcon,
    int maxLines = 1,
    TextEditingController? textEditingController,
    TextInputFormatter? formatter,
    TextInputType? textnputType,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: ShadInputFormField(
        maxLines: maxLines,
        inputFormatters: formatter == null ? null : [formatter!],
        controller: textEditingController,
        keyboardType: textnputType ?? TextInputType.text,
        style: kTextStyle(14),
        placeholder: hint.style(fontSize: 14, color: Colors.grey),
        leading: prefixIcon,
        trailing: suffixIcon != null ? Icon(suffixIcon) : null,
        decoration: ShadDecoration(
          border: ShadBorder.all(color: Colors.grey[300]),
          color: Colors.grey[200],
        ),
      ),
    );
  }

  @override
  void dispose() {
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    discountController.dispose();
    quantityController.dispose();
    brandController.dispose();
    super.dispose();
  }
}

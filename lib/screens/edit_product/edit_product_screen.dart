import 'package:ecommerce/common/button/custom_button.dart';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/models/product_manager.dart';
import 'package:ecommerce/screens/edit_product/components/images_form.dart';
import 'package:ecommerce/screens/edit_product/components/sizes_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatelessWidget {
  EditProductScreen({super.key, Product? product})
      : product = product != null ? product.cloneProduct() : Product();

  final Product? product;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    late final backScreen = Navigator.of(context).pop();

    return ChangeNotifierProvider.value(
      value: product,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
              product!.id != null ? 'Editar Produto' : 'Adicionar Produto'),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: Form(
          key: formKey,
          child: ListView(
            children: [
              ImagesForm(product: product),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      initialValue: product?.name,
                      decoration: const InputDecoration(
                          hintText: 'Título', border: InputBorder.none),
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.w600),
                      validator: (name) {
                        if (name!.length < 6) {
                          return 'Título muito curto';
                        }
                        return null;
                      },
                      onSaved: (name) => product?.name = name!,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        'A partir de: ',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Text(
                      'R\$ ...',
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text(
                        'Descrição',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextFormField(
                      initialValue: product?.description,
                      style: const TextStyle(fontSize: 16),
                      decoration: const InputDecoration(
                        hintText: 'Descrição',
                        border: InputBorder.none,
                      ),
                      maxLines: null,
                      validator: (desc) {
                        if (desc!.length < 10) {
                          return 'Descrição muito curta';
                        }
                        return null;
                      },
                      onSaved: (description) =>
                          product?.description = description!,
                    ),
                    SizesForm(product: product),
                    const SizedBox(
                      height: 20,
                    ),
                    Consumer2<Product, ProductManager>(
                        builder: (_, product, productManager, __) {
                      return CustomButton(
                          texto: 'Salvar',
                          onPressed: product.loading
                              ? null
                              : () async {
                                  if (formKey.currentState!.validate()) {
                                    formKey.currentState!.save();
                                    await product.saveProduct();

                                    productManager.updateProducts(product);
                                    backScreen;
                                  }
                                });
                    })
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

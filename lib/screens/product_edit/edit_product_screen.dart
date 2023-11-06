import 'package:brn_ecommerce/common/button/custom_button.dart';
import 'package:brn_ecommerce/common/button/custom_icon_button.dart';
import 'package:brn_ecommerce/common/button/custom_text_button.dart';
import 'package:brn_ecommerce/common/custom_messengers/custom_alert_dialog.dart';
import 'package:brn_ecommerce/common/custom_messengers/custom_scaffold_messenger.dart';
import 'package:brn_ecommerce/common/custom_text_form_field.dart';
import 'package:brn_ecommerce/models/product.dart';
import 'package:brn_ecommerce/models/product_manager.dart';
import 'package:brn_ecommerce/screens/product_edit/components/freight_form.dart';
import 'package:brn_ecommerce/screens/product_edit/components/images_form.dart';
import 'package:brn_ecommerce/screens/product_edit/components/sizes_form.dart';
import 'package:flutter/material.dart';
import 'package:markdown_editable_textinput/format_markdown.dart';
import 'package:markdown_editable_textinput/markdown_text_input.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatelessWidget {
  EditProductScreen({super.key, Product? product})
      : product = product != null ? product.cloneProduct() : Product();

  final Product? product;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    TextEditingController controller = TextEditingController();

    void saveProductError() => CustomScaffoldMessenger(
          context: context,
          message: 'Erro ao salvar/editar o Produto\n'
              'Revise os campos e tente novamente!\n'
              '\nSE O ERRO PERSISTIR CONTATE O SUPORTE',
        ).msn();

    void backScreen() => Navigator.of(context).pop();

    showAlertDialog() => showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomAlertDialog(
            titleText: 'Valores não correspondentes!',
            bodyText: product!.errorMessage,
            actions: [
              CustomTextButton(
                text: 'Ciente!',
                icon: null,
                onPressed: () {
                  backScreen();
                },
              ),
            ],
          );
        });

    return ChangeNotifierProvider.value(
      value: product,
      child: Scaffold(
        appBar: AppBar(
          title: Text(product!.id != null ? 'Editar Produto' : 'Adicionar Produto'),
          centerTitle: true,
          actions: [
            if (product!.id != null)
              CustomIconButton(
                iconData: Icons.delete,
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CustomAlertDialog(
                          titleText: 'Atenção!',
                          bodyText: 'Realmente deseja deletar este produto?\n'
                              '\nProduto: ${product!.name ?? ''};\n'
                              '\nQtd. ${product!.totalStock}\n'
                              '\n---ESTÁ AÇÃO NÃO PODERÁ SER DESFEITA---\n',
                          bodyAlign: TextAlign.start,
                          bodyWeight: FontWeight.normal,
                          titleWeight: FontWeight.normal,
                          actions: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomTextButton(
                                    text: 'Sim',
                                    icon: null,
                                    fontColor: Colors.red,
                                    onPressed: () {
                                      context.read<ProductManager>().requestDelete(product!);
                                      backScreen();
                                      backScreen();
                                    }),
                                CustomTextButton(
                                  text: 'NÃO',
                                  icon: null,
                                  fontSize: 18,
                                  fontColor: Colors.green,
                                  onPressed: () {
                                    backScreen();
                                  },
                                )
                              ],
                            )
                          ],
                        );
                      });
                },
              )
          ],
        ),
        backgroundColor: Colors.white,
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ImagesForm(product: product),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomTextFormField(
                        initialValue: product?.name,
                        hintText: 'Título do produto',
                        hintSize: 20,
                        textFormFieldSize: 22,
                        textFormFieldBold: true,
                        enabledBorder: InputBorder.none,
                        validator: (name) {
                          if (name!.length < 6) {
                            return 'Título muito curto';
                          }
                          return null;
                        },
                        onSaved: (name) => product?.name = name!,
                      ),
                      const SizedBox(height: 4),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              flex: 75,
                              child: CustomTextFormField(
                                initialValue: product?.brand ?? "",
                                labelText: 'Inserir a Marca (Opcional)',
                                hintText: 'Marca do Produto',
                                hintSize: 20,
                                textFormFieldSize: 20,
                                enabledBorder: InputBorder.none,
                                onSaved: (brand) {
                                  if (brand?.trim().isEmpty ?? true) {
                                    product?.brand = "";
                                  } else {
                                    product?.brand = brand!;
                                  }
                                },
                              ),
                            ),
                            const SizedBox(width: 10),
                            FreightForm(product: product),
                          ]),
                      const SizedBox(width: 10),
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
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          MarkdownTextInput(
                            (description) => product?.description = description,
                            product!.description ?? '',
                            label: 'Descrição',
                            maxLines: null,
                            actions: MarkdownType.values,
                            controller: controller,
                            textStyle: const TextStyle(fontSize: 16),
                            validators: (description) {
                              if (description!.trim().isEmpty) {
                                return 'A descrição é obrigatória';
                              }
                              if (description.length < 10) {
                                return 'A descrição deve ter no mínimo '
                                    '10 caracteres';
                              }
                              return null;
                            },
                          ),
                          TextButton(
                            onPressed: () {
                              controller.clear();
                            },
                            child: const Text('Limpar'),
                          ),
                          SizesForm(product: product),
                          const SizedBox(height: 20),
                          Consumer2<Product, ProductManager>(
                            builder: (_, product, productManager, __) {
                              return CustomButton(
                                  text: 'Salvar',
                                  onPressed: product.loading
                                      ? null
                                      : () async {
                                          if (formKey.currentState!.validate()) {
                                            formKey.currentState!.save();

                                            //TODO: verificação ...
                                            // (categoryOfProduct == null
                                            // || categoryOfProduct!.isEmpty)
                                            try {
                                              await product.saveProduct();
                                              productManager.updateProducts(product);

                                              // Check the consistency of
                                              // quantities and stocks
                                              await product.checkAmountsAndStocksConsistency(
                                                  product.id!, product.itemProducts!);
                                              if (product.isValid == false) {
                                                product.loading = false;
                                                showAlertDialog();
                                              } else {
                                                backScreen();
                                              }
                                            } catch (error) {
                                              product.loading = false;
                                              saveProductError();
                                            }
                                          }
                                        });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

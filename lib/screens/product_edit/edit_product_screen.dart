import 'package:brn_ecommerce/common/button/custom_button.dart';
import 'package:brn_ecommerce/common/button/custom_icon_button.dart';
import 'package:brn_ecommerce/common/button/custom_text_button.dart';
import 'package:brn_ecommerce/common/show_alert_dialog.dart';
import 'package:brn_ecommerce/models/product.dart';
import 'package:brn_ecommerce/models/product_manager.dart';
import 'package:brn_ecommerce/screens/product_edit/components/images_form.dart';
import 'package:brn_ecommerce/screens/product_edit/components/sizes_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:markdown_editable_textinput/format_markdown.dart';
import 'package:markdown_editable_textinput/markdown_text_input.dart';

class EditProductScreen extends StatelessWidget {
  EditProductScreen({super.key, Product? product})
      : product = product != null ? product.cloneProduct() : Product();

  final Product? product;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    TextEditingController controller = TextEditingController();

    String errorSaveProductMessage = 'Erro ao salvar/editar o Produto\n'
        'Revise os campos e tente novamente!a\n'
        '\nSE O ERRO PERCISTIR CONTATE O SUPORTE';

    backScreen() => Navigator.of(context).pop();
    showAlertDialog() => showDialog(
        context: context,
        builder: (BuildContext context) {
          return ShowAlertDialog(
            titleText: 'Valores não correspondentes!',
            bodyText: product!.errorMessage,
            actions: [
              CustomTextButton(
                text: 'Ciente!',
                icon: null,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });

    return ChangeNotifierProvider.value(
      value: product,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
              product!.id != null ? 'Editar Produto' : 'Adicionar Produto'),
          centerTitle: true,
          actions: [
            if (product!.id != null)
              CustomIconButton(
                iconData: Icons.delete,
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ShowAlertDialog(
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
                                      context
                                          .read<ProductManager>()
                                          .requestDelete(product!);
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop();
                                    }),
                                CustomTextButton(
                                  text: 'NÃO',
                                  icon: null,
                                  fontSize: 18,
                                  fontColor: Colors.green,
                                  onPressed: () {
                                    Navigator.of(context).pop();
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
                      TextFormField(
                        initialValue: product?.name,
                        decoration: const InputDecoration(
                          hintText: 'Título',
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
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
                                          if (formKey.currentState!
                                              .validate()) {
                                            formKey.currentState!.save();

                                            try {
                                              await product.saveProduct();
                                              productManager
                                                  .updateProducts(product);

                                              // Verificar a consistência das quantidades e estoques
                                              await product
                                                  .checkAmountsAndStocksConsistency(
                                                      product.id!,
                                                      product.itemProducts!);
                                              if (product.isValid == false) {
                                                product.loading = false;
                                                showAlertDialog();
                                              } else {
                                                backScreen();
                                              }
                                            } catch (error) {
                                              product.loading = false;
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: Text(
                                                    errorSaveProductMessage,
                                                    style: const TextStyle(
                                                        fontSize: 18)),
                                                backgroundColor: Colors.red,
                                                duration:
                                                    const Duration(seconds: 6),
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                margin:
                                                    const EdgeInsets.all(15),
                                              ));
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

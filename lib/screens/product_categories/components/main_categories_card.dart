import 'dart:io';

import 'package:brn_ecommerce/common/button/custom_text_button.dart';
import 'package:brn_ecommerce/common/functions/common_functions.dart';
import 'package:brn_ecommerce/common/miscellaneous/tag_for_cards.dart';
import 'package:brn_ecommerce/models/categories_of_products/product_category.dart';
import 'package:brn_ecommerce/models/users_manager.dart';
import 'package:brn_ecommerce/screens/product_edit/components/image_source_sheet.dart';
import 'package:brn_ecommerce/screens/product_edit/components/image_source_web.dart';
import 'package:custom_universal_html/html.dart' as html;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

import '../../../common/custom_messengers/custom_scaffold_messenger.dart';

class MainCategoriesCard extends StatefulWidget {
  const MainCategoriesCard({
    super.key,
    this.productCategory,
  });

  final ProductCategory? productCategory;

  @override
  State<MainCategoriesCard> createState() => _MainCategoriesCardState();
}

class _MainCategoriesCardState extends State<MainCategoriesCard> {
  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = widget.productCategory!.categoryRealColor!;
    final Color textColor = getTextColorBasedOnBackground(backgroundColor);
    Color? selectedColor;
    void backScreen() => Navigator.of(context).pop();

    void showColorPicker() {
      Color initialColor =
          widget.productCategory?.categoryRealColor ?? Colors.transparent;

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Selecione uma cor'),
            content: SingleChildScrollView(
              child: ColorPicker(
                pickerColor: initialColor,
                onColorChanged: (color) {
                  setState(() {
                    selectedColor = color;
                    widget.productCategory?.categoryRealColor = color;
                    widget.productCategory?.categoryColor =
                        getHexColor(color);
                  });
                },
                labelTypes: const [
                  ColorLabelType.rgb,
                  ColorLabelType.hsv,
                  ColorLabelType.hsl
                ],
                pickerAreaHeightPercent: 0.8,
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }

    Widget buildCategoryImage() {
      if (widget.productCategory?.categoryImg != null &&
          widget.productCategory?.categoryImg != "") {
        if (widget.productCategory!.categoryImg is File) {
          return Image.file(widget.productCategory!.categoryImg as File,
              fit: BoxFit.cover);
        } else {
          return Image.network(widget.productCategory!.categoryImg!,
              fit: BoxFit.cover);
        }
      } else {
        return Image.asset('assets/images/CategoriesBackground.jpg',
            fit: BoxFit.cover);
      }
    }

    void onImageSelected(File file) {
      widget.productCategory?.updateCategoryImage(file);
      setState(() {
        widget.productCategory?.categoryImg = file;
      });
      backScreen();
    }

    void onImageSelectedList(List<File> files) {
      if (files.length > 1) {
        CustomScaffoldMessenger(
          context: context,
          message: 'Está seção não permite seleção de várias imagens',
        ).msn();
        backScreen();
      } else {
        File file = files.first;
        widget.productCategory?.updateCategoryImage(file);
        setState(() {
          widget.productCategory?.categoryImg = file;
        });
        backScreen();
      }
    }

    void onImageSelectedWeb(List<html.File> files) {
      if (files.length > 1) {
        CustomScaffoldMessenger(
          context: context,
          message: 'Está seção não permite seleção de várias imagens',
        ).msn();
        backScreen();
      } else {
        for (html.File file in files) {
          html.FileReader reader = html.FileReader();
          reader.readAsDataUrl(file);
          reader.onLoadEnd.listen((event) {
            widget.productCategory?.updateCategoryImage(file);
            setState(() {
              widget.productCategory?.categoryImg = file;
            });
            backScreen();
          });
        }
      }
    }

    return Card(
        clipBehavior: Clip.antiAlias,
        color: selectedColor ?? backgroundColor,
        elevation: 7,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
        child: Consumer<UserManager>(builder: (_, userManager, __) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      width: double.infinity,
                      height: 142,
                      child: buildCategoryImage()),
                  Positioned(
                    bottom: 20,
                    left: 14,
                    child: TagForCard(
                      data: widget.productCategory?.categoryTitle ?? "",
                      alignment: Alignment.bottomRight,
                      backgroundColor: backgroundColor,
                      containerWidth: 157,
                    ),
                  ),
                  userManager.adminEnable
                      ? Align(
                          alignment: Alignment.topLeft,
                          child: Visibility(
                            visible: userManager.editingCategories == true,
                            child: CustomTextButton(
                              icon: const Icon(
                                Icons.change_circle_outlined,
                                color: Colors.black,
                                size: 38,
                              ),
                              text: 'Trocar\n Foto',
                              fontColor: Colors.black,
                              onPressed: () async {
                                if (kIsWeb) {
                                  showDialog(
                                      context: context,
                                      builder: (context) => ImageSourceWeb(
                                            onImageSelectedWeb:
                                                onImageSelectedWeb,
                                          ));
                                } else if (Platform.isAndroid) {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) => ImageSourceSheet(
                                            onImageSelected: onImageSelected,
                                            onImageSelectedList:
                                                onImageSelectedList,
                                          ));
                                } else if (Platform.isIOS) {
                                  showCupertinoModalPopup(
                                      context: context,
                                      builder: (context) => ImageSourceSheet(
                                            onImageSelected: onImageSelected,
                                            onImageSelectedList:
                                                onImageSelectedList,
                                          ));
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) => ImageSourceSheet(
                                            onImageSelected: onImageSelected,
                                            onImageSelectedList:
                                                onImageSelectedList,
                                          ));
                                }
                              },
                            ),
                          ),
                        )
                      : Container(),
                  userManager.adminEnable
                      ? Align(
                          alignment: Alignment.topRight,
                          child: Visibility(
                            visible: userManager.editingCategories == true,
                            child: Switch(
                              value:
                                  widget.productCategory?.categoryActivated ==
                                      true,
                              onChanged: (newValue) {
                                setState(() {
                                  widget.productCategory?.categoryActivated =
                                      newValue;
                                });
                              },
                            ),
                          ),
                        )
                      : Container(),
                  userManager.adminEnable
                      ? Padding(
                          padding: const EdgeInsets.only(top: 100, left: 0),
                          child: Visibility(
                            visible: userManager.editingCategories == true,
                            child: CustomTextButton(
                                text: '${widget.productCategory?.categoryID}',
                                fontColor: textColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                onPressed: null),
                          ),
                        )
                      : Container()
                ],
              ),
              SizedBox(
                height: 35,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    userManager.adminEnable
                        ? Align(
                            alignment: Alignment.center,
                            child: Visibility(
                              visible: userManager.editingCategories == true,
                              child: CustomTextButton(
                                icon: Icon(
                                  Icons.color_lens_rounded,
                                  color: textColor,
                                  size: 25,
                                ),
                                text: 'Trocar Cor',
                                fontColor: textColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                onPressed: () {
                                  showColorPicker();
                                },
                              ),
                            ),
                          )
                        : Container(),
                    Visibility(
                      visible: !userManager.editingCategories == true,
                      child: CustomTextButton(
                        isSvg: true,
                        imageAssetsTarget: 'assets/icons/smilingFace.svg',
                        imageHeight: 35,
                        onPressed: null,
                        text: 'Visite-me!',
                        fontColor: textColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        }));
  }
}

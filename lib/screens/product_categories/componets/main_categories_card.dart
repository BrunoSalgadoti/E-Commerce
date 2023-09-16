import 'package:brn_ecommerce/common/button/custom_text_button.dart';
import 'package:brn_ecommerce/common/functions/common_functions.dart';
import 'package:brn_ecommerce/models/product_category.dart';
import 'package:brn_ecommerce/models/users_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainCategoriesCard extends StatefulWidget {
  const MainCategoriesCard({super.key, required this.productCategory});

  final ProductCategory? productCategory;

  @override
  State<MainCategoriesCard> createState() => _MainCategoriesCardState();
}

class _MainCategoriesCardState extends State<MainCategoriesCard> {
  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = widget.productCategory!.categoryRealColor!;
    final Color textColor = getTextColorBasedOnBackground(backgroundColor);
    final categoriesImg = widget.productCategory?.categoryImg != null &&
            widget.productCategory?.categoryImg != ""
        ? Image.network(widget.productCategory!.categoryImg!, fit: BoxFit.cover)
        : Image.asset('assets/images/CategoriesBackground.jpg',
            fit: BoxFit.cover);

    return Card(
        clipBehavior: Clip.antiAlias,
        color: backgroundColor,
        elevation: 7,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
        child: Consumer<UserManager>(builder: (_, userManager, __) {
          return Column(
            mainAxisSize: MainAxisSize.max,
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
                      child: categoriesImg),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 69, right: 7),
                      child: Container(
                        width: 130,
                        decoration: BoxDecoration(
                            color: backgroundColor.withAlpha(98),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(9.0),
                              bottomRight: Radius.circular(9.0),
                            )),
                        padding: const EdgeInsets.all(7),
                        child: Text(
                          widget.productCategory?.categoryTitle ?? "",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                          ),
                        ),
                      ),
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
                              onPressed: () {
                                //TODO: Change picture function
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
                                  //TODO: Change color function
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

import 'package:brasil_fields/brasil_fields.dart';
import 'package:brn_ecommerce/common/button/custom_button.dart';
import 'package:brn_ecommerce/common/button/custom_icon_button.dart';
import 'package:brn_ecommerce/common/custom_text_form_field.dart';
import 'package:brn_ecommerce/common/formated_fields/format_values.dart';
import 'package:brn_ecommerce/common/formated_fields/time_input_formatter.dart';
import 'package:brn_ecommerce/models/address.dart';
import 'package:brn_ecommerce/models/opening_stores.dart';
import 'package:brn_ecommerce/models/stores.dart';
import 'package:brn_ecommerce/screens/stores/components/store_utils.dart';
import 'package:brn_ecommerce/screens/stores_edit/components/store_image_widget.dart';
import 'package:brn_ecommerce/screens/stores_edit/components/store_location_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../helpers/validators.dart';

class EditStoresScreen extends StatefulWidget {
  const EditStoresScreen({Key? key, required this.store}) : super(key: key);

  final Stores store;

  @override
  EditStoresScreenState createState() => EditStoresScreenState();
}

class EditStoresScreenState extends State<EditStoresScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    const textFieldSpaceBetweenHeight = SizedBox(height: 16);
    const textFieldSpaceBetweenWidth = SizedBox(width: 16);

    return ChangeNotifierProvider.value(
      value: widget.store,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.store.id != null
              ? 'Editar dados da Loja'
              : 'Adicionar outra Loja'),
          centerTitle: true,
          actions: [
            if (widget.store.id != null)
              CustomIconButton(
                  iconData: Icons.delete,
                  color: Colors.white,
                  onTap: () {
                    StoreUtils(
                            store: widget.store, address: widget.store.address!)
                        .alertForDeleteStore(context);
                  }),
          ],
        ),
        backgroundColor: Colors.white,
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                StoreImageWidget(store: widget.store),
                textFieldSpaceBetweenHeight,
                CustomTextFormField(
                  initialValue: widget.store.nameStore,
                  labelText: 'Nome da Loja',
                  hintText: 'Nome da Faixada da Loja',
                  isDense: false,
                  validator: emptyValidator,
                  onSaved: (value) => widget.store.nameStore = value,
                ),
                textFieldSpaceBetweenHeight,
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: CustomTextFormField(
                        initialValue: widget.store.address?.street ?? "",
                        labelText: 'Logradouro:',
                        hintText: 'EX: Rua/Av. ...',
                        isDense: false,
                        validator: emptyValidator,
                        onSaved: (value) =>
                            widget.store.address?.street = value,
                      ),
                    ),
                    textFieldSpaceBetweenWidth,
                    Expanded(
                      flex: 1,
                      child: CustomTextFormField(
                        initialValue: widget.store.address?.number ?? "",
                        labelText: 'Nº:',
                        hintText: 'ou "S/N"',
                        isDense: false,
                        validator: emptyValidator,
                        onSaved: (value) =>
                            widget.store.address?.number = value,
                      ),
                    ),
                  ],
                ),
                textFieldSpaceBetweenHeight,
                CustomTextFormField(
                  initialValue: widget.store.address?.complement ?? "",
                  labelText: 'Complemento: (Opcional)',
                  hintText: 'Ex: Matriz ou Filial da Loja',
                  isDense: false,
                  validator: (value) {
                    if (value!.length > 28) {
                      return 'Máximo de 28 caracteres';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) => widget.store.address?.complement = value,
                ),
                textFieldSpaceBetweenHeight,
                CustomTextFormField(
                  initialValue: widget.store.address?.district ?? "",
                  labelText: 'Bairro:',
                  isDense: false,
                  validator: emptyValidator,
                  onSaved: (value) => widget.store.address?.district = value,
                ),
                textFieldSpaceBetweenHeight,
                Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: CustomTextFormField(
                          initialValue: widget.store.address?.city ?? "",
                          labelText: 'Cidade:',
                          validator: emptyValidator,
                          isDense: false,
                          onSaved: (value) =>
                              widget.store.address?.city = value,
                        )),
                    textFieldSpaceBetweenWidth,
                    Expanded(
                        flex: 1,
                        child: CustomTextFormField(
                          initialValue: widget.store.address?.state ?? "",
                          labelText: 'Estado: (Sigla)',
                          hintText: 'Ex: BA',
                          isDense: false,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return 'Campo Obrigatório';
                            } else if (value.length != 2) {
                              return 'Somente a Sigla!';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) => widget.store.address?.state =
                              value?.toUpperCase(),
                        ))
                  ],
                ),
                textFieldSpaceBetweenHeight,
                Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: CustomTextFormField(
                          initialValue: formattedPhoneNumber(
                              widget.store.phoneNumberStore),
                          labelText: 'Telefone:',
                          hintText: 'Ex: (00) 90000-0000',
                          isDense: false,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            TelefoneInputFormatter()
                          ],
                          validator: (value) {
                            if (value!.length < 11) {
                              return 'Confira o número digitado (obrigatório)!';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) => widget.store.phoneNumberStore =
                              unFormatPhone(value!),
                        )),
                    textFieldSpaceBetweenWidth,
                    Expanded(
                      flex: 1,
                      child: CustomTextFormField(
                        initialValue:
                            formattedZipcode(widget.store.address?.zipCode),
                        labelText: 'CEP:',
                        hintText: 'Ex: 00.000-000',
                        textInputType: TextInputType.number,
                        isDense: false,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CepInputFormatter()
                        ],
                        validator: (value) {
                          if (value!.length != 10) {
                            return 'CEP Inválido (Obrigatório!)';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) =>
                            widget.store.address?.zipCode = value,
                      ),
                    ),
                  ],
                ),
                textFieldSpaceBetweenHeight,
                CustomTextFormField(
                  initialValue: widget.store.emailStore ?? "",
                  labelText: 'E-mail:',
                  hintText: 'Ex: nome@domínio.xxx',
                  isDense: false,
                  textInputType: TextInputType.emailAddress,
                  validator: (value) {
                    if (!emailValid(value!)) {
                      return 'E-mail inválido (Obrigatório!)';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) => widget.store.emailStore = value,
                ),
                textFieldSpaceBetweenHeight,
                textFieldSpaceBetweenHeight,
                StoreLocationWidget(store: widget.store),
                textFieldSpaceBetweenHeight,
                CustomTextFormField(
                  initialValue: '${widget.store.address?.lat.toString() ?? ""} '
                      '${widget.store.address?.long.toString() ?? ""}',
                  labelText: 'Nova Localização:',
                  hintText: 'Ex: -9.1234530, -37.1234168',
                  isDense: false,
                  validator: emptyValidator,
                  onSaved: (value) {
                    if (value != null && value.isNotEmpty) {
                      final coordinates = value
                          .split(',')
                          .map((coord) => double.tryParse(coord.trim()) ?? 0)
                          .toList();
                      if (coordinates.length == 2) {
                        widget.store.address?.lat = coordinates[0];
                        widget.store.address?.long = coordinates[1];
                      }
                    }
                  },
                ),
                textFieldSpaceBetweenHeight,
                const Text(
                  'Horários de funcionamento:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    textFieldSpaceBetweenHeight,
                    Row(
                      children: [
                        const Expanded(flex: 1, child: Text('Seg-Sex:')),
                        Expanded(
                          flex: 5,
                          child: CustomTextFormField(
                            initialValue:
                                widget.store.openingStores?.monFri ?? "",
                            labelText: 'Abertura e Fechamento:',
                            hintText: 'Ex: 08:00-18:00',
                            isDense: false,
                            textInputType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              TimeInputFormatter(),
                            ],
                            validator: (value) {
                              if (value!.isNotEmpty && value.length < 10) {
                                return 'Horário Inválido!';
                              } else {
                                return null;
                              }
                            },
                            onSaved: (value) =>
                                widget.store.openingStores?.monFri = value,
                          ),
                        ),
                      ],
                    ),
                    textFieldSpaceBetweenHeight,
                    Row(
                      children: [
                        const Expanded(flex: 1, child: Text('Sab:')),
                        Expanded(
                            flex: 5,
                            child: CustomTextFormField(
                              initialValue:
                                  widget.store.openingStores?.saturday ?? "",
                              labelText: 'Abertura e Fechamento:',
                              hintText: 'Ex: 09:00-12:00',
                              isDense: false,
                              textInputType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                TimeInputFormatter(),
                              ],
                              validator: (value) {
                                if (value!.isNotEmpty && value.length < 10) {
                                  return 'Horário Inválido!';
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (value) =>
                                  widget.store.openingStores?.saturday = value,
                            )),
                      ],
                    ),
                    textFieldSpaceBetweenHeight,
                    Row(
                      children: [
                        const Expanded(flex: 1, child: Text('Dom:')),
                        Expanded(
                            flex: 5,
                            child: CustomTextFormField(
                              initialValue:
                                  widget.store.openingStores?.monday ?? "",
                              labelText: 'Abertura e Fechamento:',
                              hintText: 'Ex: 14:00-18:00 ou Mantenha em Branco',
                              isDense: false,
                              textInputType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                TimeInputFormatter(),
                              ],
                              validator: (value) {
                                if (value!.isNotEmpty && value.length < 10) {
                                  return 'Horário Inválido!';
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (value) =>
                                  widget.store.openingStores?.monday = value,
                            )),
                      ],
                    ),
                    textFieldSpaceBetweenHeight,
                    textFieldSpaceBetweenHeight,
                    const Text(
                      'OBS: Favor seguir a formatação "00:00-00:00"\n'
                      'para: "h/min INICIAL - h/min FINAL"\n'
                      'Caso o estabelecimento não funcione no dia específico:'
                      ' \nMANTER EM BRANCO',
                      style: TextStyle(fontWeight: FontWeight.w800),
                    )
                  ],
                ),
                textFieldSpaceBetweenHeight,
                textFieldSpaceBetweenHeight,
                CustomButton(
                  text: 'Salvar',
                  onPressed: () async {
                    await _saveOrUpdateStore(context);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  backScreen() => Navigator.of(context).pop();

  Future<void> _saveOrUpdateStore(BuildContext context) async {
    final form = formKey.currentState;
    if (form != null && form.validate()) {
      widget.store.address ??= Address();
      widget.store.openingStores ??= OpeningStores();

      form.save();

      final stores = context.read<Stores>();

      if (widget.store.id != null) {
        // Update the store
        await stores.updateStore(widget.store.id!, widget.store);
      } else {
        await stores.saveStore(widget.store);
        // newAddress, newOpeningStores
      }
      backScreen();
    }
  }
}

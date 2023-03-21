import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SearchDialogUsers extends StatelessWidget {
  const SearchDialogUsers({Key? key , required this.initialText}) : super(key: key);

  final String initialText;

  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        Positioned(
            top: 2,
            left: 5,
            right: 5,
            child: Card(
                child: TextFormField(
                  initialValue: initialText,
                  textInputAction: TextInputAction.search,
                  autofocus: true,
                  decoration: InputDecoration(
                      hintText: 'Pesquisar Cliente',
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 15),
                      prefixIcon: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        color: Colors.grey[700],
                        onPressed: () {
                          Navigator.of(context).pop();
                          ClearSelectionEvent;
                        },
                      )
                  ),
                  onFieldSubmitted: (text) {
                    Navigator.of(context).pop(text);

                  },
                )
            )
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';

class SearchDialog extends StatelessWidget {
  const SearchDialog(
      {Key? key, required this.initialText, required this.hintText})
      : super(key: key);

  final String initialText;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                      hintText: hintText,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 15),
                      prefixIcon: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        color: Colors.grey[700],
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )),
              onFieldSubmitted: (text) {
                Navigator.of(context).pop(text);
              },
            )))
      ],
    );
  }
}

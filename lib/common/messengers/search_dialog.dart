import 'package:flutter/material.dart';

/// ## SearchDialog (Folder: common/messengers)
/// A custom search dialog for inputting search queries.
class SearchDialog extends StatelessWidget {
  /// Creates a search dialog with the specified [initialText] and [hintText].
  ///
  /// The [initialText] parameter is the text initially displayed in the search field.
  ///
  /// The [hintText] parameter is the hint text displayed in the search field when it's empty.
  const SearchDialog({super.key, required this.initialText, required this.hintText});

  /// The initial text displayed in the search field.
  final String initialText;

  /// The hint text displayed in the search field when it's empty.
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

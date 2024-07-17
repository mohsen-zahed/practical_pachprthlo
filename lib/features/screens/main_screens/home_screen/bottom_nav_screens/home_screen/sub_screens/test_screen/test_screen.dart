import 'package:flutter/material.dart';
import 'package:practical_pachprthlo/utils/my_media_query.dart';

class TestScreen extends StatelessWidget {
  static const String id = '/test_screen';
  const TestScreen({super.key});

  static const List<String> theList = [
    'amir',
    'saeed',
    'younes',
    'ehsan',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: RawAutocomplete(
            fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
              return TextField(
                controller: textEditingController,
                focusNode: focusNode,
              );
            },
            optionsViewBuilder: (context, onSelected, options) {
              return Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getScreenArea(context, 0.000005),
                  ),
                  child: Material(
                    elevation: 0.4,
                    child: SizedBox(
                      height: 200,
                      child: ListView.builder(
                        itemCount: options.length,
                        itemBuilder: (context, index) {
                          String option = options.elementAt(index).toString();
                          return ListTile(
                            title: Text(option),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              );
            },
            optionsBuilder: (textEditingValue) {
              return theList.where(
                (element) {
                  return element.contains(textEditingValue.text.toLowerCase());
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

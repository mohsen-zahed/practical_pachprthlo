import 'package:flutter/material.dart';
import 'package:practical_pachprthlo/config/constants/colors.dart';
import 'package:practical_pachprthlo/utils/my_media_query.dart';

class CustomSearchField extends StatelessWidget {
  const CustomSearchField({
    super.key,
    required this.searchFocusNode,
    required this.searchController,
    required this.searchTerm,
  });

  final FocusNode searchFocusNode;
  final TextEditingController searchController;
  final ValueNotifier<String> searchTerm;

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: searchFocusNode,
      controller: searchController,
      decoration: InputDecoration(
        hintText: 'Search by Name and Species...',
        hintStyle: Theme.of(context).textTheme.titleMedium!.copyWith(color: kWhiteColor),
        filled: true,
        fillColor: kWhiteColor.withOpacity(0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: getScreenArea(context, 0.000075), vertical: 0),
      ),
      style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kWhiteColor),
      onChanged: (value) {
        searchTerm.value = searchController.text;
      },
    );
  }
}

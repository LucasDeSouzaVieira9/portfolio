import 'package:flutter/material.dart';
import 'package:portfolio/core/app_colors.dart';
import 'package:portfolio/core/app_theme.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({
    Key? key,
    required this.textEditingController,
    required this.onPressedClear,
  }) : super(key: key);
  final TextEditingController textEditingController;
  final VoidCallback onPressedClear;

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  bool displayIcon = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: TextField(
            controller: widget.textEditingController,
            onChanged: ((value) {
              setState(() {
                if (value.isNotEmpty) displayIcon = true;
                if (value.isEmpty) displayIcon = false;
              });
            }),
            cursorColor: AppColors.darkBlue,
            style: ThemeTextStyle.regular(),
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: AppColors.darkBlue),
                labelStyle: ThemeTextStyle.regular(),
                suffixIcon: displayIcon
                    ? IconButton(
                        onPressed: widget.onPressedClear,
                        icon:
                            const Icon(Icons.clear, color: AppColors.darkBlue))
                    : null,
                hintText: 'Pesquisar',
                hintStyle: ThemeTextStyle.regular())),
      ),
    );
  }
}

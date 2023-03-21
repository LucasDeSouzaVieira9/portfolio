import 'package:flutter/material.dart';
import 'package:portfolio/core/app_colors.dart';
import 'package:portfolio/core/get_size.dart';
import 'package:portfolio/core/inject.dart';
import 'package:portfolio/feature/nav/app_navigator.dart';
import 'package:portfolio/feature/nav/nav_menu_page.dart';
import 'package:portfolio/main.dart';

import 'widget/search_widget.dart';

class NavBarMenuScreen extends StatefulWidget {
  const NavBarMenuScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<NavBarMenuScreen> createState() => _NavBarMenuScreenState();
}

class _NavBarMenuScreenState extends State<NavBarMenuScreen> {
  final editingControllerSearch = TextEditingController();
  final appNavigator = inject<AppNavigator>();

  @override
  Widget build(BuildContext context) {
    var locale = MyApp.getLocale(context);

    return Container(
      width: !GetSize.getNavBar(context) ? GetSize.widthPorc(context, 90) : 400,
      color: AppColors.darkBackground1,
      child: Column(
        children: [
          SizedBox(
            height: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    appNavigator.navigateToHomeScreen();
                  },
                  child: const Icon(
                    Icons.my_library_books_sharp,
                    size: 60,
                    color: AppColors.darkBlue,
                  ),
                )
              ],
            ),
          ),
          const Divider(height: 0, thickness: 2, color: AppColors.darkBlue),
          SearchWidget(
            textEditingController: editingControllerSearch,
            onPressedClear: () {
              editingControllerSearch.clear();
            },
          ),
          const Divider(height: 0, thickness: 2, color: AppColors.darkBlue),
          const SizedBox(height: 20),
          const Expanded(child: NavBarMenuPage()),
          const Divider(
            height: 0,
            thickness: 2,
            color: AppColors.darkBlue,
          ),
          Container(
            color: AppColors.darkBackground2,
            height: 50,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.person_outline_rounded),
                  padding: const EdgeInsets.only(left: 16),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.dark_mode),
                  padding: const EdgeInsets.only(left: 16),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: DropdownButton(
                    onChanged: (v) => setState(() {
                      MyApp.setLocale(context, Locale(v.toString()));
                    }),
                    value: locale.languageCode,
                    selectedItemBuilder: (_) {
                      return [
                        const SizedBox(
                          width: 55,
                          child: Icon(Icons.translate),
                        ),
                        const Icon(Icons.translate),
                      ];
                    },
                    underline: const SizedBox(),

                    // change this line with your way to get current locale to select it as default in dropdown
                    items: const [
                      DropdownMenuItem(value: 'en', child: Text('English')),
                      DropdownMenuItem(value: 'pt', child: Text('Portuguese')),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

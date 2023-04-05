import 'package:flutter/material.dart';
import 'package:portfolio/core/inject.dart';
import 'package:portfolio/feature/nav/app_navigator.dart';
import 'package:portfolio/feature/nav/nav_menu_item.dart';

class NavBarMenuPage extends StatefulWidget {
  const NavBarMenuPage({Key? key}) : super(key: key);

  @override
  State<NavBarMenuPage> createState() => _NavBarMenuPageState();
}

class _NavBarMenuPageState extends State<NavBarMenuPage> {
  final appNavigator = inject<AppNavigator>();
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        NavMenuItem(
          menuItem: MenuItemModel(
            title: 'test',
            description: 'test',
            pathIcon: 'assets/icons/dart.svg',
            linkGit: 'https://www.google.com',
            codesReview: [SubMenuCodesReviewModel('test', 'lib/feature/nav/nav_menu_item.dart')],
            subMenu: [
              SubMenuItemModel(
                '123',
                // AppLocalizations.of(context)!.navMenuPageSubMenuTitle,
                () => appNavigator.navigateToValidateCpf(),
              ),
            ],
          ),
        ),
        // NavMenuItem(
        //   menuItem: MenuItemModel(
        //     title: AppLocalizations.of(context)!.navMenuPageStateManagementTitle,
        //     description: AppLocalizations.of(context)!.navMenuPageStateManagement,
        //     pathIcon: 'assets/icons/dart.svg',
        //     linkGit: '',
        //     codesReview: [],
        //     subMenu: [
        //       SubMenuItemModel('Ui Nubank', () => appNavigator.navigateToValidateCpf()),
        //     ],
        //   ),
        // ),

        // NavMenuItem(
        //   menuItem: MenuItemModel(
        //     title: 'Firebase',
        //     description: '',
        //     pathIcon: 'assets/icons/dart.svg',
        //     codesReview: [],
        //     linkGit: '',
        //     subMenu: [
        //       SubMenuItemModel('Login', () => appNavigator.navigateToLoginScreen(context)),
        //       SubMenuItemModel('Register', () => appNavigator.navigateToRegisterScreen(context)),
        //       SubMenuItemModel('Storage', () => appNavigator.navigateToStorageScreen(context)),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}

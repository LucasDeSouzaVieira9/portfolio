import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:portfolio/core/app_colors.dart';
import 'package:portfolio/core/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class NavMenuItem extends StatefulWidget {
  const NavMenuItem({Key? key, required this.menuItem}) : super(key: key);

  final MenuItemModel menuItem;

  @override
  State<NavMenuItem> createState() => _NavMenuItemState();
}

class _NavMenuItemState extends State<NavMenuItem> {
  bool selectedItem = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      child: Container(
        padding: EdgeInsets.all(selectedItem ? 0 : 10),
        decoration: BoxDecoration(
          color: AppColors.darkBackground2,
          borderRadius: BorderRadius.circular(5),
        ),
        height: selectedItem ? widget.menuItem.subMenu.length * 70 + 46 : 200,
        child: Column(
          children: [
            if (!selectedItem) ...[
              Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: AppColors.darkBlue),
                    child: Center(
                        child: SvgPicture.asset(
                      widget.menuItem.pathIcon,
                      width: 20,
                    )),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    widget.menuItem.title,
                    style: ThemeTextStyle.h4HeadlineMedium(),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                color: Colors.transparent,
                height: 80,
                child: Center(
                  child: Text(
                    widget.menuItem.description,
                    style: ThemeTextStyle.body1Medium()
                        .copyWith(color: AppColors.textColor2),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  InkWell(
                    onTap: () async {
                      if (await canLaunchUrl(
                          Uri.parse(widget.menuItem.linkGit))) {
                        await launchUrl(Uri.parse(widget.menuItem.linkGit));
                      }
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/icons/github.svg'),
                        const SizedBox(width: 10),
                        Text(
                          AppLocalizations.of(context)!.navMenuItemGitHubAccess,
                          style: ThemeTextStyle.medium().copyWith(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () => setState(() => selectedItem = true),
                    child: Container(
                      height: 30,
                      width: 120,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.darkBlue),
                      child: Center(
                          child: Text(
                        AppLocalizations.of(context)!.navMenuItemViewMore,
                        style: ThemeTextStyle.medium().copyWith(fontSize: 12),
                      )),
                    ),
                  ),
                ],
              ),
            ] else ...[
              Padding(
                padding: const EdgeInsets.only(
                    top: 10, left: 10, right: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: () => setState(() => selectedItem = false),
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: AppColors.white,
                        )),
                    Text(
                      widget.menuItem.title,
                      style: ThemeTextStyle.h4HeadlineMedium(),
                    ),
                    const SizedBox(width: 26)
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.menuItem.subMenu.length,
                  itemBuilder: ((context, index) {
                    return InkWell(
                      onTap: () {
                        widget.menuItem.subMenu[index].route();
                      },
                      child: Container(
                        height: 60,
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            color: AppColors.darkBlue),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                    color: AppColors.darkBackground2,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50))),
                                height: 50,
                                width: 30,
                                child: Center(
                                  child: Text(
                                    index.toString(),
                                    style: ThemeTextStyle.h4HeadlineMedium(),
                                  ),
                                ),
                              ),
                              Text(widget.menuItem.subMenu[index].title,
                                  style: ThemeTextStyle.h4HeadlineMedium())
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              )
            ]
          ],
        ),
      ),
    );
  }
}

class MenuItemModel {
  final String title;
  final String description;
  final String pathIcon;
  final String linkGit;
  final List<SubMenuItemModel> subMenu;

  MenuItemModel(
      {required this.title,
      required this.description,
      required this.pathIcon,
      required this.linkGit,
      required this.subMenu});
}

class SubMenuItemModel {
  final String title;
  final VoidCallback route;

  SubMenuItemModel(this.title, this.route);
}

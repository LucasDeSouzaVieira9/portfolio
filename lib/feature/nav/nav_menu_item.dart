import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:portfolio/core/app_colors.dart';
import 'package:portfolio/core/app_theme.dart';
import 'package:portfolio/widgets/pt_code_view_modal.dart';
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
    return Container(
      padding: EdgeInsets.all(selectedItem ? 0 : 10),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.darkBackground2,
        borderRadius: BorderRadius.circular(5),
      ),
      height: selectedItem ? widget.menuItem.subMenu.length * 165 : 200,
      child: Column(
        children: [
          if (!selectedItem) ...[
            Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: AppColors.darkBlue),
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
                  style: ThemeTextStyle.body1Medium().copyWith(color: AppColors.textColor2),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const Spacer(),
            Row(
              children: [
                InkWell(
                  onTap: () async {
                    if (await canLaunchUrl(Uri.parse(widget.menuItem.linkGit))) {
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
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: AppColors.darkBlue),
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
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => setState(() => selectedItem = false),
                    child: const Icon(Icons.arrow_back_ios, color: AppColors.white),
                  ),
                  Text(
                    widget.menuItem.title,
                    style: ThemeTextStyle.h4HeadlineMedium(),
                  ),
                  const SizedBox(width: 26)
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: widget.menuItem.subMenu.length,
                separatorBuilder: (context, index) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.darkBlue,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.code_rounded),
                                Text(AppLocalizations.of(context)!.navMenuItemCodeReview),
                              ],
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: 120,
                              height: 30,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: widget.menuItem.codesReview.length,
                                separatorBuilder: (context, index) => const SizedBox(height: 5),
                                itemBuilder: (context, index) => InkWell(
                                  onTap: () => PtCodeViewModal.show(context, codeReview: widget.menuItem.codesReview[index]),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: AppColors.darkBackground2,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30),
                                      ),
                                    ),
                                    height: 30,
                                    width: 30,
                                    child: Center(
                                      child: Text(
                                        (index + 1).toString(),
                                        style: ThemeTextStyle.h4HeadlineMedium(),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              widget.menuItem.subMenu[index].title,
                              style: ThemeTextStyle.h4HeadlineMedium(),
                            ),
                            const SizedBox(height: 10),
                            InkWell(
                              onTap: () => widget.menuItem.subMenu[index].route(),
                              child: Container(
                                height: 30,
                                width: 120,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: AppColors.darkBackground2),
                                child: Center(
                                  child: Text(
                                    AppLocalizations.of(context)!.navMenuItemView,
                                    style: ThemeTextStyle.medium().copyWith(fontSize: 12),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20)
          ]
        ],
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
  final List<SubMenuCodesReviewModel> codesReview;

  MenuItemModel({
    required this.title,
    required this.description,
    required this.pathIcon,
    required this.linkGit,
    required this.subMenu,
    required this.codesReview,
  });
}

class SubMenuItemModel {
  final String title;
  final VoidCallback route;

  SubMenuItemModel(this.title, this.route);
}

class SubMenuCodesReviewModel {
  final String title;
  final String filePath;

  SubMenuCodesReviewModel(this.title, this.filePath);
}

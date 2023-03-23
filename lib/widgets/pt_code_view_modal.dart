import 'package:flutter/material.dart';
import 'package:portfolio/core/app_colors.dart';
import 'package:portfolio/feature/nav/nav_menu_item.dart';
import 'package:widget_with_codeview/widget_with_codeview.dart';

class PtCodeViewModal extends StatefulWidget {
  final String title;
  final String filePath;
  const PtCodeViewModal({Key? key, required this.title, required this.filePath}) : super(key: key);

  @override
  State<PtCodeViewModal> createState({Key? key}) => _PtCodeViewModalState();

  static Future<PtCodeViewModal?> show(BuildContext context, {required SubMenuCodesReviewModel codeReview}) {
    return showDialog<PtCodeViewModal>(
      context: context,
      builder: (BuildContext context) => PtCodeViewModal(
        filePath: codeReview.filePath,
        title: codeReview.title,
      ),
    );
  }
}

class _PtCodeViewModalState extends State<PtCodeViewModal> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          constraints: const BoxConstraints(maxWidth: 600),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.darkBlue),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 34, height: 40),
                  Text(widget.title),
                  const Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Icon(Icons.close),
                  )
                ],
              ),
              Expanded(
                child: Theme(
                  data: ThemeData.dark(),
                  child: WidgetWithCodeView(
                    filePath: widget.filePath,
                    labelBackgroundColor: AppColors.darkBlue,
                    iconBackgroundColor: AppColors.darkBlue,
                    iconForegroundColor: AppColors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

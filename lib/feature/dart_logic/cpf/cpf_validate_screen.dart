import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:portfolio/packages/instant_page_route.dart';
import 'package:portfolio/widgets/pt_text_form_field.dart';

enum _CpfValidateScreenType { VALID, INVALID, INITIAL }

extension _CpfValidateScreenTypeExt on _CpfValidateScreenType {
  Color color() => [
        Colors.greenAccent,
        Colors.redAccent,
        Colors.white,
      ][index];
  String label(BuildContext context) => [
        AppLocalizations.of(context)!.cpfValidateScreenValid,
        AppLocalizations.of(context)!.cpfValidateScreenInvalid,
        ''
      ][index];
}

class CpfValidateScreen extends StatefulWidget {
  const CpfValidateScreen({Key? key}) : super(key: key);

  static const route = "cpf_validate";

  static PageRoute<void> create(RouteSettings routeSettings) {
    return InstantPageRoute<void>(
      settings: routeSettings,
      builder: (context) {
        return const CpfValidateScreen();
      },
    );
  }

  @override
  State<CpfValidateScreen> createState() => _CpfValidateScreenState();
}

class _CpfValidateScreenState extends State<CpfValidateScreen> {
  final invalidCpf = [
    '111.111.111-11',
    '222.222.222-22',
    '333.333.333-33',
    '444.444.444-44',
    '555.555.555-55',
    '666.666.666-66',
    '777.777.777-77',
    '888.888.888-88',
    '999.999.999-99'
  ];
  final GlobalKey<FormState> _formKey = GlobalKey();
  late TextEditingController _controllerTextField;
  late _CpfValidateScreenType type;
  late MaskTextInputFormatter maskFormatter;

  @override
  void initState() {
    _controllerTextField = TextEditingController();
    type = _CpfValidateScreenType.INITIAL;
    maskFormatter = MaskTextInputFormatter(
        mask: '###.###.###-##', type: MaskAutoCompletionType.lazy);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: type.color(),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                  child: Text(
                type.label(context),
                style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )),
              Form(
                key: _formKey,
                child: PtTextField(
                  controller: _controllerTextField,
                  labelText: 'CPF',
                  inputFormatters: [maskFormatter],
                  onChanged: (cpf) {
                    var cpf = maskFormatter.getMaskedText();
                    if (invalidCpf.contains(cpf)) {
                      type = _CpfValidateScreenType.INITIAL;
                    } else if (cpf.length == 14) {
                      var valid = _validateCpf(maskFormatter.getUnmaskedText());
                      type = valid
                          ? _CpfValidateScreenType.VALID
                          : _CpfValidateScreenType.INVALID;
                    }
                    setState(() {});
                  },
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      _controllerTextField.text = '';

                      for (var i = 9; i >= 1; i--) {
                        _controllerTextField.text = maskFormatter.maskText(
                            _controllerTextField.text +
                                Random().nextInt(9).toString());

                        await Future<void>.delayed(
                          const Duration(milliseconds: 100),
                        );
                      }
                      var generatedCpf = _generateCpf(
                          _controllerTextField.text.split('')
                            ..removeWhere((element) => element == '.'));

                      _controllerTextField.text =
                          maskFormatter.maskText(generatedCpf);
                      type = _CpfValidateScreenType.INITIAL;
                      setState(() {});
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                    ),
                    child: Text(AppLocalizations.of(context)!
                        .cpfValidateScreenCPFGenerate),
                  ),
                ],
              )
            ],
          ),
        ));
  }

  bool _validateCpf(String cpf) {
    var removedChecker = cpf.split('');
    if (removedChecker.length == 11) {
      removedChecker.removeRange(9, 11);
    }

    var checkerOne = _calculateChecker(removedChecker);
    var checkerTwo = _calculateChecker([...removedChecker, checkerOne]);
    removedChecker.addAll([checkerOne, checkerTwo]);

    return cpf == removedChecker.join();
  }

  String _generateCpf(List<String> nineNumbers) {
    var checkerOne = _calculateChecker(nineNumbers);
    var checkerTwo = _calculateChecker([...nineNumbers, checkerOne]);
    nineNumbers.addAll([checkerOne, checkerTwo]);

    return nineNumbers.join();
  }

  String _calculateChecker(List<String> cpf) {
    int calc = 0;
    for (int i = cpf.length + 1; i >= 2; i--) {
      calc = calc + (int.parse(cpf[cpf.length + 1 - i]) * i);
    }
    if (calc % 11 < 2) {
      return '0';
    }

    return (11 - (calc % 11)).toString();
  }
}

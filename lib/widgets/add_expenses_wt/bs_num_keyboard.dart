import 'package:exp_app/utils/constants.dart';
import 'package:flutter/material.dart';

import '../../models/combined_model.dart';

class BSNumKeyboard extends StatefulWidget {
  final CombinedModel cModel;
  const BSNumKeyboard({super.key, required this.cModel});

  @override
  State<BSNumKeyboard> createState() => _BSNumKeyboardState();
}

class _BSNumKeyboardState extends State<BSNumKeyboard> {
  String amount = '0.00';

  @override
  void initState() {
    amount = widget.cModel.amount.toStringAsFixed(2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String Function(Match) mathFunc;
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    mathFunc = (Match match) => '${match[1]},';

    return GestureDetector(
      onTap: () {
        _numPad();
      },
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            const Text('Cantidad ingresada'),
            Text(
              '\$ ${amount.replaceAllMapped(reg, mathFunc)}',
              style: const TextStyle(
                  fontSize: 30.0,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  _num(String _text, double _height) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          amount += _text;
          widget.cModel.amount = double.parse(amount);
        });
      },
      child: SizedBox(
        height: _height,
        child: Center(
          child: Text(
            _text,
            style: const TextStyle(
              fontSize: 35.0,
            ),
          ),
        ),
      ),
    );
  }

  _expenseChange(String amount) {
    if (amount == '') amount = '0.00';
    widget.cModel.amount = double.parse(amount);
  }

  _numPad() {
    if (amount == '0.00') amount = '';

    showModalBottomSheet(
      barrierColor: Colors.transparent,
      // isDismissible: false,
      enableDrag: false,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30.0),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: WillPopScope(
            onWillPop: () async => false,
            child: SizedBox(
              height: 350.0,
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  var _height = constraints.biggest.height / 6;
                  return Column(
                    children: [
                      Table(
                        border: TableBorder.symmetric(
                          inside: const BorderSide(
                            // color: Colors.grey,
                            width: 0.1,
                          ),
                        ),
                        children: [
                          TableRow(
                            children: [
                              _num('1', _height),
                              _num('2', _height),
                              _num('3', _height),
                            ],
                          ),
                          TableRow(
                            children: [
                              _num('4', _height),
                              _num('5', _height),
                              _num('6', _height),
                            ],
                          ),
                          TableRow(
                            children: [
                              _num('7', _height),
                              _num('8', _height),
                              _num('9', _height),
                            ],
                          ),
                          TableRow(
                            children: [
                              _num('.', _height),
                              _num('0', _height),
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  setState(() {
                                    if (amount.length > 0.0) {
                                      amount = amount.substring(
                                          0, amount.length - 1);
                                      _expenseChange(amount);
                                    }
                                  });
                                },
                                onLongPress: () {
                                  setState(() {
                                    amount = '';
                                    _expenseChange(amount);
                                  });
                                },
                                child: SizedBox(
                                  height: _height,
                                  child: const Icon(
                                    Icons.backspace,
                                    size: 35.0,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              child: Constants.customButton(
                                  Colors.transparent, Colors.red, 'CANCELAR'),
                              onTap: () {
                                setState(() {
                                  amount = '0.00';
                                  _expenseChange(amount);
                                  Navigator.pop(context);
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              child: Constants.customButton(
                                  Colors.green, Colors.transparent, 'ACEPTAR'),
                              onTap: () {
                                setState(() {
                                  if (amount.length == 0.0) amount = '0.00';
                                  _expenseChange(amount);
                                  Navigator.pop(context);
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

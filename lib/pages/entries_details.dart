import 'dart:math';

import 'package:exp_app/models/entries_model.dart';
import 'package:exp_app/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../providers/expenses_provider.dart';
import '../utils/constants.dart';
import '../utils/math_operations.dart';

class EntriesDetails extends StatefulWidget {
  const EntriesDetails({super.key});

  @override
  State<EntriesDetails> createState() => _EntriesDetailsState();
}

class _EntriesDetailsState extends State<EntriesDetails> {
  List<EntriesModel> etList = [];
  final _scrollController = ScrollController();
  double _offset = 0;

  double get _max => max(90 - _offset * 90, 0.0);

  void _listener() {
    setState(() {
      _offset = _scrollController.offset / 100;
      print(_max);
    });
  }

  @override
  void initState() {
    etList = context.read<ExpensesProvider>().etList;

    _scrollController.addListener(_listener);
    _max;
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_listener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final exProvider = context.watch<ExpensesProvider>();
    // final etList = exProvider.etList;
    double totalEntries = 0.0;
    bool hasData = false;

    totalEntries = etList
        .map((e) => e.entries)
        .fold(0.0, (previousValue, element) => previousValue + element);

    if (_offset > 0.90) _offset = 0.90;

    if (etList.isNotEmpty) {
      hasData = true;
    }

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            expandedHeight: 125.0,
            title: const Padding(
              padding: EdgeInsets.only(right: 60.0),
              child: Text('Desglose de ingresos'),
            ),
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Align(
                alignment: Alignment(_offset, 1),
                child: Text(
                  getAmountFormat(totalEntries),
                ),
              ),
              centerTitle: true,
              background: const Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: Text('Total'),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.only(top: 15.0),
              height: 40.0,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Container(
                decoration: Constants.sheetBoxDecoration(
                    Theme.of(context).primaryColorDark),
              ),
            ),
          ),
          hasData
              ? SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, i) {
                      var item = etList[i];
                      return Slidable(
                        key: ValueKey(item),
                        startActionPane: ActionPane(
                          motion: const DrawerMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                setState(() {
                                  etList.removeAt(i);
                                });
                              },
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              icon: Icons.delete_outline,
                              label: 'Borrar',
                            ),
                            SlidableAction(
                              onPressed: (context) {},
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              icon: Icons.edit_outlined,
                              label: 'Editar',
                            ),
                          ],
                        ),
                        child: ListTile(
                          leading: Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              const Icon(
                                Icons.calendar_today_outlined,
                                size: 40.0,
                              ),
                              Positioned(
                                top: 18,
                                child: Text(item.day.toString()),
                              )
                            ],
                          ),
                          title: Row(
                            children: const [
                              Text('Ingreso'),
                              SizedBox(
                                width: 8.0,
                              ),
                            ],
                          ),
                          subtitle: Text(item.comment),
                          trailing: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                getAmountFormat(item.entries),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${(100 * item.entries / totalEntries).toStringAsFixed(2)}%',
                                style: const TextStyle(fontSize: 12.0),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    childCount: etList.length,
                  ),
                )
              : SliverToBoxAdapter(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(50.0),
                        child: Image.asset('assets/empty.png'),
                      ),
                      const Text(
                        'No hay ingresos para mostrar.\nAgrega uno nuevo',
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 14.0,
                          letterSpacing: 1.1,
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}

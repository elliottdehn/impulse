import 'package:flutter/cupertino.dart';
import 'package:impulse/experiments/refactor/model.dart';
import 'package:impulse/widgets/game/symbol/SymbolWidgetState.dart';

class SymbolWidget extends StatefulWidget {
  final Model m;

  SymbolWidget(this.m);

  @override
  State<StatefulWidget> createState() => SymbolWidgetState(m);
}

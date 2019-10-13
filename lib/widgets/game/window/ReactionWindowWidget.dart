import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:impulse/experiments/refactor/model.dart';

import 'ReactionWindowWidgetState.dart';

class ReactionWindowWidget extends StatefulWidget {
  final Model m;

  ReactionWindowWidget(this.m);
  @override
  State<StatefulWidget> createState() => ReactionWindowWidgetState(m);

}

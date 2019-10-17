import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:impulse/experiments/refactor/model.dart';

import 'score_widget_state.dart';

class ScoreWidget extends StatefulWidget {
  final Model m;

  ScoreWidget(this.m);

  @override
  State<StatefulWidget> createState() => ScoreWidgetState(m);
}

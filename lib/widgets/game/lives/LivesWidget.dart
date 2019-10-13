import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:impulse/experiments/refactor/model.dart';

import 'LivesWidgetState.dart';

class LivesWidget extends StatefulWidget {

  final Model m;

  LivesWidget(this.m);

  @override
  State<StatefulWidget> createState() => LivesWidgetState(m);
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:impulse/widgets/IState.dart';
import 'package:impulse/widgets/game/symbol/SymbolWidget.dart';
import 'package:impulse/widgets/game/symbol/SymbolWidgetPresenter.dart';

import '../../IStateUpdateListener.dart';
import 'SymbolState.dart';

class SymbolWidgetState extends State<SymbolWidget> implements IStateUpdateListener {

  SymbolWidgetPresenter _presenter;

  String _symbol;
  double _opacity;

  //auto event triggers
  Timer _symbolVisibilityTimer;
  Timer _symbolIntervalTimer;


  SymbolWidgetState(){
    _presenter = new SymbolWidgetPresenter(this);
  }

  @override
  initState(){
    super.initState();
    SymbolState state = _presenter.initState();
    _opacity = 0.0;

  }

  @override
  onStateUpdate(IState newState) {
    SymbolState newStateSymbol = newState as SymbolState;
    _opacity = 1.0;
    _symbol = newStateSymbol.symbol;

    _symbolVisibilityTimer = Timer(
      Duration(milliseconds: newStateSymbol.visibilityDuration),
      _onSymbolHide()
    );

    _symbolIntervalTimer = Timer(
      Duration(milliseconds: newStateSymbol.nextSymbolInterval),
      _onNewSymbol
    );

    setState((){});
  }

  _onReact(){
  }

  _onNewSymbol(){
  }

  _onSymbolHide(){
    _opacity = 0.0;
    setState((){});
  }

  _onTapEnforcement(){
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails t) { _onReact(); },
      child:
        Scaffold(
        body: Opacity(
          opacity: _opacity,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                    '$_symbol',
                    style: Theme.of(context).textTheme.display1
                        .apply(fontSizeFactor: 8.0, color: Color.fromRGBO(0, 0, 0, 1.0))
                  ),
                ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _symbolIntervalTimer.cancel();
    _symbolVisibilityTimer.cancel();
  }

}
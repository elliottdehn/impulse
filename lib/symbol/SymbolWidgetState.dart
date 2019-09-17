import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:impulse/symbol/ISymbolEventListener.dart';
import 'package:impulse/symbol/SymbolWidget.dart';
import 'package:impulse/symbol/SymbolWidgetPresenter.dart';
import 'package:impulse/widgets/death/DeathWidget.dart';

class SymbolWidgetState extends State<SymbolWidget> implements ISymbolEventListener {

  SymbolWidgetPresenter _presenter;

  String _symbol;
  double _opacity;

  SymbolWidgetState(){
    _presenter = new SymbolWidgetPresenter(this);
    _opacity = 1.0;
  }

  onReact(){
    _presenter.playerReacted();
  }

  @override
  setSymbol(String s){
    setState(() {
      _symbol = s;
    });
  }

  @override
  setSymbolVisibility(double vis){
    setState(() {
      _opacity = vis;
    });
  }

  @override
  killUser() {
    _launchDeathScreen();
  }

  _launchDeathScreen(){
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return DeathWidget(10,20,30);
        }
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Opacity(
        opacity: _opacity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () { onReact(); },
                child:
                Text(
                  '$_symbol',
                  style: Theme.of(context).textTheme.display1
                      .apply(fontSizeFactor: 8.0, color: Color.fromRGBO(0, 0, 0, 1.0))
                ),
              ),
            ],
          ),
        ),
      )
    );
  }

}
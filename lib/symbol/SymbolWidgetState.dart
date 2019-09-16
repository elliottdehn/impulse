import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:impulse/symbol/ISymbolEventListener.dart';
import 'package:impulse/symbol/SymbolWidget.dart';
import 'package:impulse/symbol/SymbolWidgetPresenter.dart';

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

  //I need someone to tell me when and to what to change my symbol
  //I need someone to tell me when to change my symbol's visibility

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test"),
      ),
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
                  style: Theme.of(context).textTheme.display1.apply(fontSizeFactor: 4.0),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
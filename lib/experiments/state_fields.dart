import 'predicates.dart';
import 'values.dart';

enum PredicateID {
  DID_PLAYER_REACT,
  IS_TAPPED_ONCE,
  IS_NORMAL_SYMBOL,
  IS_KILLER_SYMBOL,
  IS_TAPPED_ZERO,
  DID_NEW_SYMBOL
}

class DidPlayerReact extends TestResult {
  DidPlayerReact(x, y) : super(x, y);
}

class IsTappedOnce extends TestResult {
  IsTappedOnce(x, y) : super(x, y);
}

class IsNormalSymbol extends TestResult {
  IsNormalSymbol(x, y) : super(x, y);
}

class IsKillerSymbol extends TestResult {
  IsKillerSymbol(x, y) : super(x, y);
}

class IsTappedZero extends TestResult {
  IsTappedZero(x, y) : super(x, y);
}

class IsNewSymbol extends TestResult {
  IsNewSymbol(x, y) : super(x, y);
}

/*
Definitions---------------------
 */

mixin Transform<T extends Transform<T>> {
  T transform(TestResults t, {T Function(TestResults, List) fn});
}

abstract class StateField<X> with Transform<StateField<X>> {
  StateField<X> transform(TestResults t,
      {StateField<X> Function(TestResults, List) fn});
}
/*
End definitions-----------------
 */

class TapCountField implements StateField<TapCountField> {
  final TapCount tc;

  TapCountField(this.tc);

  @override
  StateField<TapCountField> transform(TestResults t,
      {StateField<TapCountField> Function(TestResults, List) fn}) {
    DidPlayerReact didReact = t.get(PredicateID.DID_PLAYER_REACT);
    if (~didReact) {
      return new TapCountField(new TapCount(~tc + 1));
    } else {
      return new TapCountField(new TapCount(~tc));
    }
  }
}

class NormalSymbolTotalField implements StateField<NormalSymbolTotalField> {
  final NormalSymbolTotal total;

  NormalSymbolTotalField(this.total);

  @override
  StateField<NormalSymbolTotalField> transform(TestResults t,
      {StateField<NormalSymbolTotalField> Function(TestResults, List) fn}) {
    DidPlayerReact didReact = t.get(PredicateID.DID_PLAYER_REACT);
    IsTappedOnce tappedOnce = t.get(PredicateID.IS_TAPPED_ONCE);
    IsNormalSymbol normalSymbol = t.get(PredicateID.IS_NORMAL_SYMBOL);
    if (~didReact && ~tappedOnce && ~normalSymbol) {
      return NormalSymbolTotalField(NormalSymbolTotal(~total + 1));
    } else {
      return NormalSymbolTotalField(NormalSymbolTotal(~total));
    }
  }
}

class KillerSymbolTotalField implements StateField<KillerSymbolTotalField> {
  final KillerSymbolTotal total;

  KillerSymbolTotalField(this.total);

  @override
  StateField<KillerSymbolTotalField> transform(TestResults t,
      {StateField<KillerSymbolTotalField> Function(TestResults, List) fn}) {
    IsNewSymbol newSymbol = t.get(PredicateID.DID_NEW_SYMBOL);
    IsTappedZero tappedZero = t.get(PredicateID.IS_TAPPED_ZERO);
    IsKillerSymbol killerSymbol = t.get(PredicateID.IS_KILLER_SYMBOL);
    if (~newSymbol && ~tappedZero && ~killerSymbol) {
      return KillerSymbolTotalField(new KillerSymbolTotal(~total + 1));
    } else {
      return KillerSymbolTotalField(new KillerSymbolTotal(~total));
    }
  }
}

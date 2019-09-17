class AppStateStore {

  var _stateFinalValueMap = _AppConfig._keyValueMap;
  var _stateDynamicValueMap = _AppState._keyValueMap;

  Object getStateValueForKey(AppStateKey key){
    return _stateDynamicValueMap[key];
  }

  setStateValueForKey(AppStateKey key, var val) {
      _stateDynamicValueMap[key] = val;
  }

  Object getConfigValueForKey(AppConfigKey key){
    return _stateFinalValueMap[key];
  }

}

class _AppConfig {

  static final double failureSymbolOdds = 0.15;

  static final int intervalSymbolFast = 1000; //milliseconds
  static final int intervalSymbolMedium = 2000; //milliseconds
  static final int intervalSymbolSlow = 3000; //milliseconds
  static final int symbolVisibilityDuration = 100; //milliseconds

  static final List<String> failureLetters = ["X"];
  static final List<String> successLetters =
  [ "A", "B", "C", "D", "E", "F",
    "G", "H", "I", "J", "K", "L",
    "M", "N", "O", "P", "Q", "R",
    "S", "T", "U", "V", "W", "Y", "Z"
  ];

  static final Map<AppConfigKey, Object> _keyValueMap = {
    AppConfigKey.FAILURE_LETTERS:failureLetters,
    AppConfigKey.SUCCESS_LETTERS:successLetters,
    AppConfigKey.INTERVAL_SYMBOL_FAST:intervalSymbolFast,
    AppConfigKey.INTERVAL_SYMBOL_MEDIUM:intervalSymbolMedium,
    AppConfigKey.INTERVAL_SYMBOL_SLOw:intervalSymbolSlow,
    AppConfigKey.FAILURE_SYMBOL_ODDS:failureSymbolOdds,
    AppConfigKey.SYMBOL_VISIBILITY_DURATION:symbolVisibilityDuration
  };

}

enum AppConfigKey{
  FAILURE_LETTERS,
  SUCCESS_LETTERS,
  INTERVAL_SYMBOL_FAST,
  INTERVAL_SYMBOL_MEDIUM,
  INTERVAL_SYMBOL_SLOw,
  FAILURE_SYMBOL_ODDS,
  SYMBOL_VISIBILITY_DURATION
}

class _AppState {

  static Map<AppStateKey, Object> _keyValueMap = {
    AppStateKey.SYMBOL:null,
    AppStateKey.SCORE:0,
    AppStateKey.PLAYER_IS_ALIVE:true,
    AppStateKey.REACTION_WINDOW:700,
    AppStateKey.SYMBOL_TAPPED:false
  };

}

enum AppStateKey {
  SYMBOL,
  SCORE,
  PLAYER_IS_ALIVE,
  REACTION_WINDOW,
  SYMBOL_TAPPED
}
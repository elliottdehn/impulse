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

  static final double failureSymbolOdds = 0.20;

  static final int intervalSymbolFast = 1000; //milliseconds
  static final int intervalSymbolMedium = 2000; //milliseconds
  static final int intervalSymbolSlow = 3000; //milliseconds
  static final int symbolVisibilityDuration = 125; //milliseconds
  static final int baseReactionWindow = 700; //milliseconds
  static final int livesStart = 3;

  static final List<String> failureLetters = ["X", "", null];
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
    AppConfigKey.SYMBOL_VISIBILITY_DURATION:symbolVisibilityDuration,
    AppConfigKey.LIVES_START:livesStart,
    AppConfigKey.BASE_REACTION_WINDOW:baseReactionWindow
  };

}

enum AppConfigKey{
  FAILURE_LETTERS,
  SUCCESS_LETTERS,
  INTERVAL_SYMBOL_FAST,
  INTERVAL_SYMBOL_MEDIUM,
  INTERVAL_SYMBOL_SLOw,
  FAILURE_SYMBOL_ODDS,
  SYMBOL_VISIBILITY_DURATION,
  LIVES_START,
  BASE_REACTION_WINDOW
}

class _AppState {

  static Map<AppStateKey, Object> _keyValueMap = {
    AppStateKey.SYMBOL:null,
    AppStateKey.PLAYER_IS_ALIVE:true, //not needed
    AppStateKey.SYMBOL_SHOWN_TIME:null, //DateTime
    AppStateKey.SYMBOL_TAPPED:false, //not needed
    AppStateKey.SYMBOL_TAPPED_COUNT:0,
    AppStateKey.LIVES:3,
    AppStateKey.REACTION_TIMES:[],
    AppStateKey.NORMAL_SYMBOL_STREAK:0,
    AppStateKey.KILLER_SYMBOL_STREAK:0,
    AppStateKey.NORMAL_SYMBOL_TOTAL:0,
    AppStateKey.KILLER_SYMBOL_TOTAL:0,
  };

}

enum AppStateKey {
  SYMBOL,
  SYMBOL_VISIBLE,
  SYMBOL_TAPPED,
  SYMBOL_TAPPED_COUNT,
  PLAYER_IS_ALIVE,
  LIVES,
  REACTION_TIMES,
  NORMAL_SYMBOL_STREAK,
  KILLER_SYMBOL_STREAK,
  NORMAL_SYMBOL_TOTAL,
  KILLER_SYMBOL_TOTAL,
  REACTION_WINDOW,
  SYMBOL_SHOWN_TIME
}
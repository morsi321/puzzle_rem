part of 'game_cubit.dart';

@immutable
abstract class GameState {}

class GameInitial extends GameState {}

class PageChanged extends GameState {}

class GameSettingsChanged extends GameState {}

class GameStart extends GameState {}

class PuzzlePieceStateChanged extends GameState {}

class TimerChanged extends GameState {}

class GameFinished extends GameState {}

class CoinsAdded extends GameState {}

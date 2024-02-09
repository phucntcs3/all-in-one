part of 'loading_bloc.dart';

abstract class LoadingEvent extends Equatable {
  const LoadingEvent();

  @override
  List<Object> get props => [];
}

class LoadingInit extends LoadingEvent {
  const LoadingInit();

  @override
  List<Object> get props => [];
}

class LoadingChanged extends LoadingEvent {
  const LoadingChanged(this.value);

  final bool value;

  @override
  List<Object> get props => [value];
}

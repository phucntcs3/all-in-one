import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'loading_event.dart';
part 'loading_state.dart';

class LoadingBloc extends Bloc<LoadingEvent, LoadingState> {
  LoadingBloc() : super(const LoadingState()) {
    on<LoadingInit>(_onLoadingInit);
    on<LoadingChanged>(_onLoadingChanged);
  }

  void _onLoadingInit(
    LoadingInit event,
    Emitter<LoadingState> emit,
  ) async {}

  void _onLoadingChanged(
    LoadingChanged event,
    Emitter<LoadingState> emit,
  ) async {
    emit(state.copyWith(loading: event.value));
  }
}

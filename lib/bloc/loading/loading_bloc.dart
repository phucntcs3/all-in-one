import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'loading_event.dart';
part 'loading_state.dart';

class LoadingBloc extends Bloc<LoadingEvent, LoadingState> {
  LoadingBloc() : super(const LoadingState()) {
    on<LoadingInit>(_onLoadingInit);
    on<LoadingChanged>(_onLoadingChanged);
    on<LoadingAppIOS>(_onLoadingAppIOS);
    on<LoadingModalUpdate>(_onLoadingModalUpdate);
    on<LoadingModalDailyBonus>(_onLoadingModalDailyBonus);
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

  void _onLoadingAppIOS(
    LoadingAppIOS event,
    Emitter<LoadingState> emit,
  ) async {
    emit(state.copyWith(
      iosLink: event.value['ios_link'],
      iosLatestVersion: event.value['ios_latest_version'],
    ));
  }

  void _onLoadingModalUpdate(
    LoadingModalUpdate event,
    Emitter<LoadingState> emit,
  ) async {
    emit(state.copyWith(openModalUpdate: event.value));
  }

  void _onLoadingModalDailyBonus(
    LoadingModalDailyBonus event,
    Emitter<LoadingState> emit,
  ) async {
    emit(state.copyWith(openModalDailyBonus: event.value));
  }
}

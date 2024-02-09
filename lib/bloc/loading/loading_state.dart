part of 'loading_bloc.dart';

class LoadingState extends Equatable {
  const LoadingState({
    this.loading = false,
  });

  final bool loading;

  LoadingState copyWith({
    bool? loading,
  }) {
    return LoadingState(
      loading: loading ?? this.loading,
    );
  }

  @override
  List<Object?> get props => [
        loading,
      ];
}

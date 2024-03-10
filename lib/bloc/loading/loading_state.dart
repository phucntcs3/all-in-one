part of 'loading_bloc.dart';

class LoadingState extends Equatable {
  const LoadingState({
    this.iosLink = '',
    this.iosLatestVersion = '',
    this.loading = true,
    this.openModalUpdate = false,
    this.openModalDailyBonus = false,
  });

  final String iosLink;
  final String iosLatestVersion;
  final bool loading;
  final bool openModalUpdate;
  final bool openModalDailyBonus;

  LoadingState copyWith({
    String? iosLink,
    String? iosLatestVersion,
    bool? loading,
    bool? openModalUpdate,
    bool? openModalDailyBonus,
  }) {
    return LoadingState(
      iosLink: iosLink ?? this.iosLink,
      iosLatestVersion: iosLatestVersion ?? this.iosLatestVersion,
      loading: loading ?? this.loading,
      openModalUpdate: openModalUpdate ?? this.openModalUpdate,
      openModalDailyBonus: openModalDailyBonus ?? this.openModalDailyBonus,
    );
  }

  @override
  List<Object?> get props => [
        iosLink,
        loading,
        iosLatestVersion,
        openModalUpdate,
        openModalDailyBonus,
      ];
}

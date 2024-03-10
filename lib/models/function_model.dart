class FunctionModel {
  final String key;
  final String title;
  final String icon;
  final dynamic widget;
  final bool newFeature;

  FunctionModel({
    required this.key,
    required this.title,
    required this.icon,
    required this.widget,
    this.newFeature = false,
  });

  FunctionModel copyWith({
    String? key,
    String? title,
    String? icon,
    dynamic widget,
    bool? newFeature,
  }) {
    return FunctionModel(
      key: key ?? this.key,
      title: title ?? this.title,
      icon: icon ?? this.icon,
      widget: widget ?? this.widget,
      newFeature: newFeature ?? this.newFeature,
    );
  }
}

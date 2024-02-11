class FunctionModel {
  final String key;
  final String title;
  final String icon;
  final dynamic widget;

  FunctionModel({
    required this.key,
    required this.title,
    required this.icon,
    required this.widget,
  });

  FunctionModel copyWith({
    String? key,
    String? title,
    String? icon,
    dynamic widget,
  }) {
    return FunctionModel(
      key: key ?? this.key,
      title: title ?? this.title,
      icon: icon ?? this.icon,
      widget: widget ?? this.widget,
    );
  }
}

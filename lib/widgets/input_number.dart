import 'package:aio_mobile/constants/app_size.dart';
import 'package:flutter/material.dart';

class InputNumber extends StatefulWidget {
  const InputNumber({
    super.key,
    this.title = '',
    this.placeholder = '',
    this.onChanged,
    this.defaultValue = '',
    this.controller,
  });

  final String title;
  final String placeholder;
  final Function(String)? onChanged;
  final String defaultValue;
  final TextEditingController? controller;

  @override
  State<InputNumber> createState() => _InputNumberState();
}

class _InputNumberState extends State<InputNumber> {
  late TextEditingController controller;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    controller = widget.controller ?? TextEditingController();

    if (widget.defaultValue != '') {
      controller.text = widget.defaultValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 100,
          child: Text(
            widget.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Flexible(
          fit: FlexFit.tight,
          child: SizedBox(
            height: AppSize.inputHeight,
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              onChanged: (value) {
                widget.onChanged?.call(value);
              },
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              onTapOutside: (_) {
                focusNode.unfocus();
              },
              decoration: InputDecoration(
                hintText: widget.placeholder,
                border: const OutlineInputBorder(),
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                suffixIcon: controller.text.isNotEmpty
                    ? IconButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(Icons.clear),
                        iconSize: 20,
                        onPressed: () {
                          setState(() {
                            controller.clear();
                            widget.onChanged?.call('');
                            focusNode.requestFocus();
                          });
                        },
                      )
                    : null,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:aio_mobile/models/function_model.dart';
import 'package:flutter/material.dart';

import '../router/core_router.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.item,
    this.isDarkMode = false,
  });

  final FunctionModel item;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Hero(
                tag: item.key,
                child: SizedBox.square(
                  dimension: 50,
                  child: Image.asset(
                    item.icon,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Text(
                item.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              CoreRouter.pop();
            },
            icon: Icon(
              Icons.close,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

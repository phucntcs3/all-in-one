import 'package:aio_mobile/constants/app_size.dart';
import 'package:aio_mobile/models/function_model.dart';
import 'package:flutter/material.dart';

import '../router/core_router.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.item,
    this.isDarkMode = false,
    this.isChildScreen = false,
  });

  final FunctionModel item;
  final bool isDarkMode;
  final bool isChildScreen;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: isChildScreen
            ? MainAxisAlignment.start
            : MainAxisAlignment.spaceBetween,
        children: [
          if (isChildScreen)
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                CoreRouter.pop();
              },
              icon: Icon(
                Icons.chevron_left,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          Row(
            children: [
              if (item.icon != '')
                Hero(
                  tag: item.key,
                  child: SizedBox.square(
                    dimension: isMobile ? 50 : 80,
                    child: Image.asset(
                      item.icon,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              if (item.icon != '') const SizedBox(width: 15),
              Text(
                item.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: isMobile ? 16 : 25,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
          if (!isChildScreen)
            IconButton(
              onPressed: () {
                CoreRouter.pop();
              },
              icon: Icon(
                Icons.close,
                color: isDarkMode ? Colors.white : Colors.black,
                size: isMobile ? null : 50,
              ),
            ),
        ],
      ),
    );
  }
}

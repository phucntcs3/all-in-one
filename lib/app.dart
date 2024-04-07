import 'package:aio_mobile/bloc/bloc_provider.dart';
import 'package:aio_mobile/configs/app_configs.dart';
import 'package:aio_mobile/widgets/banner_ad.dart';
import 'package:aio_mobile/widgets/modal_update.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/loading/loading_bloc.dart';
import 'router/core_router.dart';
import 'widgets/loading.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBlocProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        initialRoute: '/',
        onGenerateRoute: CoreRouter.onGenerateRoute,
        builder: (context, child) {
          return Stack(
            children: [
              // Main App
              Column(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    child: SizedBox(child: child),
                  ),
                  const BannerAdWidget(),
                ],
              ),
              // Other
              BlocBuilder<LoadingBloc, LoadingState>(
                builder: (context, state) {
                  if (state.loading) {
                    return const Loading();
                  }

                  if (state.openModalUpdate && !AppConfigs.isTest) {
                    return ModalUpdate(
                      iosLink: state.iosLink,
                    );
                  }

                  // if (state.openModalDailyBonus) {
                  //   return const ModalLuckyWheel();
                  // }

                  return const SizedBox();
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

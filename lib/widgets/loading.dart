import 'package:aio_mobile/bloc/loading/loading_bloc.dart';
import 'package:aio_mobile/widgets/v_space.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

class Loading extends StatefulWidget {
  const Loading({
    super.key,
    this.onFinish,
  });

  final Function()? onFinish;

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    await setupRemoteConfig();

    widget.onFinish?.call();
  }

  Future<void> setupRemoteConfig() async {
    final remoteConfig = FirebaseRemoteConfig.instance;

    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: const Duration(seconds: 10),
    ));

    await remoteConfig.setDefaults(const {
      "ios_latest_version": "1.0.0",
      "ios_upstore_version": "1.0.0+",
      "ios_should_update": true,
      "ios_link": "",
    });

    await remoteConfig.fetchAndActivate();

    final packageInfo = await PackageInfo.fromPlatform();

    final iosLatestVersion = remoteConfig.getString('ios_latest_version');
    final iosUpstoreVersion = remoteConfig.getString('ios_upstore_version');
    final iosLink = remoteConfig.getString('ios_link');
    final iosShouldUpdate = remoteConfig.getBool('ios_should_update');

    final shouldUpdate = iosShouldUpdate &&
        (packageInfo.version != iosLatestVersion) &&
        (packageInfo.version != iosUpstoreVersion);

    if (mounted) {
      if (shouldUpdate) {
        context.read<LoadingBloc>().add(
              LoadingAppIOS(
                {
                  'ios_link': iosLink,
                  'ios_latest_version': iosLatestVersion,
                },
              ),
            );

        context.read<LoadingBloc>().add(const LoadingModalUpdate(true));
      } else {
        context.read<LoadingBloc>().add(const LoadingModalDailyBonus(true));
      }

      context.read<LoadingBloc>().add(const LoadingChanged(false));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoadingBloc, LoadingState>(
      builder: (context, state) {
        return Positioned.fill(
          child: Material(
            color: Colors.white.withOpacity(0),
            child: Container(
              color: Colors.black.withOpacity(0.6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(
                    color: Colors.white,
                  ),
                  VSpace(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

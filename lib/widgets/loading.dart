import 'package:aio_mobile/bloc/loading/loading_bloc.dart';
import 'package:aio_mobile/widgets/v_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoadingBloc, LoadingState>(
      builder: (context, state) {
        if (state.loading != true) return const SizedBox();

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
                  Text('Loading ...')
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

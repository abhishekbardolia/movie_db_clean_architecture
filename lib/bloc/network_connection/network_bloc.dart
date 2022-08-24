import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';

part 'network_event.dart';
part 'network_state.dart';

class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  late StreamSubscription _subscription;
  final Connectivity connectivity;
  NetworkBloc({required this.connectivity}) : super(ConnectionInitial()){
    on<ListenConnection>(
      (event, emit) {
        _subscription =
            connectivity.onConnectivityChanged.listen((connectivityResult) {
              if (connectivityResult == ConnectivityResult.wifi) {
                add(ConnectionChanged(ConnectionWifii()));
              } else if (connectivityResult == ConnectivityResult.mobile) {
                add(ConnectionChanged(ConnectionInternet()));
              } else if (connectivityResult == ConnectivityResult.none) {
                add(ConnectionChanged(ConnectionFailure()));
              }
            });
      },
    );

    on<ConnectionChanged>((event, emit) => emit(event.connection));

  }


  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}

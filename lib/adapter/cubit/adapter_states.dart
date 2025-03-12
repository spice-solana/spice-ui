abstract class AdapterStates {}

class ConnectedAdapterState extends AdapterStates {
  final String address;
  ConnectedAdapterState({required this.address});
}

class UnconnectedAdapterState extends AdapterStates {}
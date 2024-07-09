import 'package:flutter/cupertino.dart';
import 'package:flutter_course/pages/music/audio_helpers/service_locator.dart';
import 'package:flutter_course/pages/toolBox/views/invididualViews/file_share/data/global_scope_data.dart';
import 'package:flutter_course/pages/toolBox/views/invididualViews/file_share/data/pref_data.dart';
import 'package:flutter_course/pages/toolBox/views/invididualViews/file_share/entity/connection_status.dart';

class ConnectionProvider extends ChangeNotifier {
  ConnectionStatus _connectionStatus = ConnectionStatus.idle;
  ConnectionStatus get connectionStatus => _connectionStatus;

  String _connectedIPAddress = '';
  String get connectedIPAddress => _connectedIPAddress;

  void updateConnectionStatus({required ConnectionStatus newStatus}) {
    _connectionStatus = newStatus;
    getIt.get<GlobalScopeData>().updateConnectionStatus(newStatus: newStatus);
    notifyListeners();
  }

  void updateConnectedIPAddress({required String newIpAddress}) {
    _connectedIPAddress = newIpAddress;
    getIt
        .get<GlobalScopeData>()
        .updateConnectedIPAddress(newIpAddress: newIpAddress);
    getIt.get<PrefData>().saveLastConnectedAddress(newIpAddress);
    notifyListeners();
  }

  void disconnect() {
    _connectedIPAddress = '';
    _connectionStatus = ConnectionStatus.idle;
    getIt.get<GlobalScopeData>().resetAllData();
    notifyListeners();
  }
}

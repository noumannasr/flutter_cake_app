import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';


class NoInternetAppWidget extends StatefulWidget {
  const NoInternetAppWidget({super.key, required this.child});

  final Widget child;

  @override
  State<NoInternetAppWidget> createState() => _NoInternetAppWidgetState();
}

class _NoInternetAppWidgetState extends State<NoInternetAppWidget> {
  int _connectionType = 1;

  final Connectivity _connectivity = Connectivity();

  late StreamSubscription streamSubscription;
  late final Widget _child = widget.child;

  @override
  void initState() {
    _getConnectionType();
    streamSubscription = _connectivity.onConnectivityChanged.listen(_updateState);
    super.initState();
  }

  Future<void> _getConnectionType() async {
    try {
      final connectivityResult = await (_connectivity.checkConnectivity());
      return _updateState(connectivityResult);
    } on PlatformException catch (_) {}
    return _updateState(ConnectivityResult.none);
  }

  _updateState(ConnectivityResult result) {
    if (result == ConnectivityResult.wifi || result == ConnectivityResult.mobile) {
      _connectionType = 1;
      setState(() {});
      return;
    }
    if(_connectionType == 0) {
      Fluttertoast.showToast(
        msg: "Offline",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
    _connectionType = 0;


    setState(() {});
  }

  @override
  void dispose() {
    streamSubscription.cancel();
    super.dispose();
  }

  Widget _noInternetView() => MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Material(
      child: Container(
       // decoration: BoxDecoration(color: R.palette.background),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.language, color: Colors.black,size: 50,),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              'no_internet_connection'.tr(),
              textAlign: TextAlign.center,
              //style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: R.palette.white),
            ),
            const SizedBox(height: 25),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Container(
                width: 200.w,
                height: 50.h,
                color: Colors.black,
                child: Center(
                  child: Text(
                    'try_again'.tr(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _getConnectionType();
    streamSubscription = _connectivity.onConnectivityChanged.listen(_updateState);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        _child,
        Visibility(
          visible: _connectionType != 1,
          child: _noInternetView(),
        ),
      ],
    );
  }


}

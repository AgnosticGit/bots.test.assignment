import 'dart:async';
import 'package:bots/services/internet.service.dart';
import 'package:bots/utils/enums.dart';
import 'package:dio/dio.dart';

class RestApiService<S, E> extends InternetService {
  RestApiService({
    required this.url,
    required this.requestType,
    this.body,
    this.headers,
    this.executeIfSuccess,
    this.executeIfError,
    this.successFromJson,
    this.successToStore,
    this.errorsFromJson,
    this.errorsToStore,
    this.setIsDisconnected,
    this.setIsLoading,
    this.requestAfterReconnect = true,
    this.reconnectDuration = const Duration(seconds: 1),
  });

  final String url;
  final RequestType requestType;
  final Map<String, dynamic>? body;
  final Map<String, String>? headers;

  final void Function()? executeIfSuccess;
  final void Function()? executeIfError;

  final S Function(dynamic json)? successFromJson;
  final E Function(dynamic errors)? errorsFromJson;

  final void Function(S data)? successToStore;
  final void Function(E error)? errorsToStore;

  final Function(bool)? setIsDisconnected;
  final Function(bool)? setIsLoading;

  final bool requestAfterReconnect;
  final Duration reconnectDuration;

  Future<void> request() async {
    if (await _internetIsDiconnected()) {
      return Future.value();
    }

    try {
      _loadingStarted();
      final response = await _httpRequest();
      _loadingFinished();

      if (!_isResponseSuccessfulByCode(response.statusCode!)) {
        throw response.data;
      }

      _successToState(response);

      if (executeIfSuccess != null) executeIfSuccess!();
    } catch (errors) {
      _errorsToState(errors);
      _loadingFinished();
      if (executeIfError != null) executeIfError!();
    }
  }

  void _successToState(Response response) {
    if (successToStore != null && successFromJson != null) {
      final json = response.data;
      successToStore!(successFromJson!(json));
    }
  }

  void _errorsToState(Object errors) {}

  void _loadingStarted() {
    if (setIsLoading != null) setIsLoading!(true);
  }

  void _loadingFinished() {
    if (setIsLoading != null) setIsLoading!(false);
  }

  Future<Response> _httpRequest() async {
    if (requestType == RequestType.get) {
      return Dio().get(
        url,
        options: Options(headers: headers),
      );
    }
    if (requestType == RequestType.post) {
      return Dio().post(
        url,
        options: Options(headers: headers),
        data: body,
      );
    }
    if (requestType == RequestType.put) {
      return Dio().put(
        url,
        options: Options(headers: headers),
        data: body,
      );
    }
    return Dio().delete(
      url,
      options: Options(headers: headers),
      data: body,
    );
  }

  bool _isResponseSuccessfulByCode(int code) {
    switch (code) {
      case 200:
        return true;
      case 201:
        return true;
      default:
        return false;
    }
  }

  Future<bool> _internetIsDiconnected() async {
    if (await isConnected()) {
      if (setIsDisconnected != null) {
        setIsDisconnected!(false);
      }
      return false;
    } else {
      if (setIsDisconnected != null) {
        setIsDisconnected!(true);
        await _requestAfterReconnect();
      }
      return true;
    }
  }

  Future<void> _requestAfterReconnect() async {
    await Future.doWhile(() async {
      bool continueLoop = true;
      await Future.delayed(reconnectDuration, () async {
        if (await isConnected()) {
          continueLoop = false;
          request();
        }
      });
      return continueLoop;
    });
  }
}

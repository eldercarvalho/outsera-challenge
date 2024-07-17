import 'dart:io';

import 'package:dio/dio.dart';
import 'package:outsera_challenge/src/entities/exeception_entity.dart';
import 'package:outsera_challenge/src/entities/void_entity.dart';
import 'package:outsera_challenge/src/infra/http/http.dart';

Future<T> safeRequest<T>({
  required Future<HttpResponse> Function() request,
  T? Function(Map<String, dynamic>)? parseData,
  T? Function(List<Map<String, dynamic>>)? parseDataList,
  String? dataKey,
}) async {
  try {
    final response = await request();
    var responseData = response.data[dataKey];

    if (T == Void) {
      return const Void() as T;
    }

    if (parseDataList != null) {
      final listOfMaps = List<Map<String, dynamic>>.from(responseData).toList();
      return parseDataList(listOfMaps) as T;
    }

    if (parseData != null) {
      return parseData(responseData) as T;
    }

    return responseData;
  } on DioException catch (error) {
    if (error.response != null) {
      throw ServerException(
        statusCode: error.response?.statusCode,
        code: error.response?.data["error"]["code"],
        message: error.response?.data["error"]["message"],
      );
    }

    if (error.type == DioExceptionType.connectionError ||
        error.error is SocketException) {
      throw ConnectionException();
    }

    if (error.type == DioExceptionType.connectionTimeout &&
        error.type == DioExceptionType.receiveTimeout &&
        error.type == DioExceptionType.sendTimeout) {
      throw TimeoutException();
    }

    throw UnknownException(error: error.error);
  } on TypeError catch (error, stackTrace) {
    throw ParsingException(error: error, stackTrace: stackTrace);
  } catch (error) {
    throw UnknownException(error: error);
  }
}

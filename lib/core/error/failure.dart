import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure({required this.message});

  @override
  List<Object> get props => [message];
}

class DataBaseFailure extends Failure {
  const DataBaseFailure({required super.message});
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message});
  factory ServerFailure.fromDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return const ServerFailure(
            message: 'Connection timeout with api server');
      case DioExceptionType.sendTimeout:
        return const ServerFailure(message: 'Send timeout with api server');
      case DioExceptionType.receiveTimeout:
        return const ServerFailure(message: 'Receive timeout with api server');
      case DioExceptionType.badCertificate:
        return const ServerFailure(message: 'badCertification with api server');
      case DioExceptionType.badResponse:
        return ServerFailure.fromDioResponse(
          error.response!.statusCode!,
          error.response,
        );
      case DioExceptionType.cancel:
        return const ServerFailure(message: 'Request to ApiServer was Canceled');
      case DioExceptionType.connectionError:
        return const ServerFailure(message: 'No Internet Connection');
      case DioExceptionType.unknown:
        return const ServerFailure(
          message: 'Opps There was an Error, Please try again',
        );
    }
  }
  factory ServerFailure.fromDioResponse(int statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(message: response['error']['message']);
    } else if (statusCode == 404) {
      return const ServerFailure(
        message: 'Your request was not found, please try later',
      );
    } else if (statusCode == 500) {
      return const ServerFailure(
        message: 'There is a problem with server,please try later',
      );
    }
    return const ServerFailure(message: 'there was an error, please try again');
  }
}
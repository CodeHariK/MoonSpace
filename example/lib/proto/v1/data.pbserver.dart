//
//  Generated code. Do not modify.
//  source: data.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'data.pb.dart' as $1;
import 'data.pbjson.dart';

export 'data.pb.dart';

abstract class TravelServiceBase extends $pb.GeneratedService {
  $async.Future<$1.Destination> getDestination($pb.ServerContext ctx, $1.GetDestinationRequest request);
  $async.Future<$1.ListDestinationsResponse> searchDestinations($pb.ServerContext ctx, $1.GetDestinationRequest request);
  $async.Future<$1.ListDestinationsResponse> listDestinations($pb.ServerContext ctx, $1.ListDestinationsRequest request);
  $async.Future<$1.Destination> createDestination($pb.ServerContext ctx, $1.CreateDestinationRequest request);
  $async.Future<$1.Destination> updateDestination($pb.ServerContext ctx, $1.UpdateDestinationRequest request);
  $async.Future<$1.EmptyResponse> deleteDestination($pb.ServerContext ctx, $1.DeleteDestinationRequest request);
  $async.Future<$1.Activity> getActivity($pb.ServerContext ctx, $1.GetActivityRequest request);
  $async.Future<$1.ListActivitiesResponse> listActivities($pb.ServerContext ctx, $1.ListActivitiesRequest request);
  $async.Future<$1.Activity> createActivity($pb.ServerContext ctx, $1.CreateActivityRequest request);
  $async.Future<$1.Activity> updateActivity($pb.ServerContext ctx, $1.UpdateActivityRequest request);
  $async.Future<$1.EmptyResponse> deleteActivity($pb.ServerContext ctx, $1.DeleteActivityRequest request);
  $async.Future<$1.BookingResponse> bookDestination($pb.ServerContext ctx, $1.BookingRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'GetDestination': return $1.GetDestinationRequest();
      case 'SearchDestinations': return $1.GetDestinationRequest();
      case 'ListDestinations': return $1.ListDestinationsRequest();
      case 'CreateDestination': return $1.CreateDestinationRequest();
      case 'UpdateDestination': return $1.UpdateDestinationRequest();
      case 'DeleteDestination': return $1.DeleteDestinationRequest();
      case 'GetActivity': return $1.GetActivityRequest();
      case 'ListActivities': return $1.ListActivitiesRequest();
      case 'CreateActivity': return $1.CreateActivityRequest();
      case 'UpdateActivity': return $1.UpdateActivityRequest();
      case 'DeleteActivity': return $1.DeleteActivityRequest();
      case 'BookDestination': return $1.BookingRequest();
      default: throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx, $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'GetDestination': return getDestination(ctx, request as $1.GetDestinationRequest);
      case 'SearchDestinations': return searchDestinations(ctx, request as $1.GetDestinationRequest);
      case 'ListDestinations': return listDestinations(ctx, request as $1.ListDestinationsRequest);
      case 'CreateDestination': return createDestination(ctx, request as $1.CreateDestinationRequest);
      case 'UpdateDestination': return updateDestination(ctx, request as $1.UpdateDestinationRequest);
      case 'DeleteDestination': return deleteDestination(ctx, request as $1.DeleteDestinationRequest);
      case 'GetActivity': return getActivity(ctx, request as $1.GetActivityRequest);
      case 'ListActivities': return listActivities(ctx, request as $1.ListActivitiesRequest);
      case 'CreateActivity': return createActivity(ctx, request as $1.CreateActivityRequest);
      case 'UpdateActivity': return updateActivity(ctx, request as $1.UpdateActivityRequest);
      case 'DeleteActivity': return deleteActivity(ctx, request as $1.DeleteActivityRequest);
      case 'BookDestination': return bookDestination(ctx, request as $1.BookingRequest);
      default: throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => TravelServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>> get $messageJson => TravelServiceBase$messageJson;
}


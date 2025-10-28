//
//  Generated code. Do not modify.
//  source: data.proto
//

import "package:connectrpc/connect.dart" as connect;
import "data.pb.dart" as data;

abstract final class TravelService {
  /// Fully-qualified name of the TravelService service.
  static const name = 'moon.space.v1.TravelService';

  static const getDestination = connect.Spec(
    '/$name/GetDestination',
    connect.StreamType.unary,
    data.GetDestinationRequest.new,
    data.Destination.new,
  );

  static const searchDestinations = connect.Spec(
    '/$name/SearchDestinations',
    connect.StreamType.unary,
    data.GetDestinationRequest.new,
    data.ListDestinationsResponse.new,
  );

  static const listDestinations = connect.Spec(
    '/$name/ListDestinations',
    connect.StreamType.unary,
    data.ListDestinationsRequest.new,
    data.ListDestinationsResponse.new,
  );

  static const createDestination = connect.Spec(
    '/$name/CreateDestination',
    connect.StreamType.unary,
    data.CreateDestinationRequest.new,
    data.Destination.new,
  );

  static const updateDestination = connect.Spec(
    '/$name/UpdateDestination',
    connect.StreamType.unary,
    data.UpdateDestinationRequest.new,
    data.Destination.new,
  );

  static const deleteDestination = connect.Spec(
    '/$name/DeleteDestination',
    connect.StreamType.unary,
    data.DeleteDestinationRequest.new,
    data.EmptyResponse.new,
  );

  static const getActivity = connect.Spec(
    '/$name/GetActivity',
    connect.StreamType.unary,
    data.GetActivityRequest.new,
    data.Activity.new,
  );

  static const listActivities = connect.Spec(
    '/$name/ListActivities',
    connect.StreamType.unary,
    data.ListActivitiesRequest.new,
    data.ListActivitiesResponse.new,
  );

  static const createActivity = connect.Spec(
    '/$name/CreateActivity',
    connect.StreamType.unary,
    data.CreateActivityRequest.new,
    data.Activity.new,
  );

  static const updateActivity = connect.Spec(
    '/$name/UpdateActivity',
    connect.StreamType.unary,
    data.UpdateActivityRequest.new,
    data.Activity.new,
  );

  static const deleteActivity = connect.Spec(
    '/$name/DeleteActivity',
    connect.StreamType.unary,
    data.DeleteActivityRequest.new,
    data.EmptyResponse.new,
  );

  static const bookDestination = connect.Spec(
    '/$name/BookDestination',
    connect.StreamType.unary,
    data.BookingRequest.new,
    data.BookingResponse.new,
  );
}

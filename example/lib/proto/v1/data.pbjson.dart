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

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

import 'google/protobuf/timestamp.pbjson.dart' as $0;

@$core.Deprecated('Use bookingStatusDescriptor instead')
const BookingStatus$json = {
  '1': 'BookingStatus',
  '2': [
    {'1': 'BOOKING_STATUS_UNSPECIFIED', '2': 0},
    {'1': 'BOOKING_STATUS_PENDING', '2': 1},
    {'1': 'BOOKING_STATUS_CONFIRMED', '2': 2},
    {'1': 'BOOKING_STATUS_CANCELLED', '2': 3},
    {'1': 'BOOKING_STATUS_COMPLETED', '2': 4},
  ],
};

/// Descriptor for `BookingStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List bookingStatusDescriptor = $convert.base64Decode(
    'Cg1Cb29raW5nU3RhdHVzEh4KGkJPT0tJTkdfU1RBVFVTX1VOU1BFQ0lGSUVEEAASGgoWQk9PS0'
    'lOR19TVEFUVVNfUEVORElORxABEhwKGEJPT0tJTkdfU1RBVFVTX0NPTkZJUk1FRBACEhwKGEJP'
    'T0tJTkdfU1RBVFVTX0NBTkNFTExFRBADEhwKGEJPT0tJTkdfU1RBVFVTX0NPTVBMRVRFRBAE');

@$core.Deprecated('Use destinationDescriptor instead')
const Destination$json = {
  '1': 'Destination',
  '2': [
    {'1': 'ref', '3': 1, '4': 1, '5': 9, '10': 'ref'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'country', '3': 3, '4': 1, '5': 9, '10': 'country'},
    {'1': 'continent', '3': 4, '4': 1, '5': 9, '10': 'continent'},
    {'1': 'known_for', '3': 5, '4': 1, '5': 9, '10': 'knownFor'},
    {'1': 'tags', '3': 6, '4': 3, '5': 9, '10': 'tags'},
    {'1': 'image_url', '3': 7, '4': 1, '5': 9, '10': 'imageUrl'},
  ],
};

/// Descriptor for `Destination`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List destinationDescriptor = $convert.base64Decode(
    'CgtEZXN0aW5hdGlvbhIQCgNyZWYYASABKAlSA3JlZhISCgRuYW1lGAIgASgJUgRuYW1lEhgKB2'
    'NvdW50cnkYAyABKAlSB2NvdW50cnkSHAoJY29udGluZW50GAQgASgJUgljb250aW5lbnQSGwoJ'
    'a25vd25fZm9yGAUgASgJUghrbm93bkZvchISCgR0YWdzGAYgAygJUgR0YWdzEhsKCWltYWdlX3'
    'VybBgHIAEoCVIIaW1hZ2VVcmw=');

@$core.Deprecated('Use activityDescriptor instead')
const Activity$json = {
  '1': 'Activity',
  '2': [
    {'1': 'ref', '3': 1, '4': 1, '5': 9, '10': 'ref'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {'1': 'location_name', '3': 4, '4': 1, '5': 9, '10': 'locationName'},
    {'1': 'duration', '3': 5, '4': 1, '5': 2, '10': 'duration'},
    {'1': 'time_of_day', '3': 6, '4': 1, '5': 9, '10': 'timeOfDay'},
    {'1': 'family_friendly', '3': 7, '4': 1, '5': 8, '10': 'familyFriendly'},
    {'1': 'price', '3': 8, '4': 1, '5': 5, '10': 'price'},
    {'1': 'destination_ref', '3': 9, '4': 1, '5': 9, '10': 'destinationRef'},
    {'1': 'image_url', '3': 10, '4': 1, '5': 9, '10': 'imageUrl'},
  ],
};

/// Descriptor for `Activity`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List activityDescriptor = $convert.base64Decode(
    'CghBY3Rpdml0eRIQCgNyZWYYASABKAlSA3JlZhISCgRuYW1lGAIgASgJUgRuYW1lEiAKC2Rlc2'
    'NyaXB0aW9uGAMgASgJUgtkZXNjcmlwdGlvbhIjCg1sb2NhdGlvbl9uYW1lGAQgASgJUgxsb2Nh'
    'dGlvbk5hbWUSGgoIZHVyYXRpb24YBSABKAJSCGR1cmF0aW9uEh4KC3RpbWVfb2ZfZGF5GAYgAS'
    'gJUgl0aW1lT2ZEYXkSJwoPZmFtaWx5X2ZyaWVuZGx5GAcgASgIUg5mYW1pbHlGcmllbmRseRIU'
    'CgVwcmljZRgIIAEoBVIFcHJpY2USJwoPZGVzdGluYXRpb25fcmVmGAkgASgJUg5kZXN0aW5hdG'
    'lvblJlZhIbCglpbWFnZV91cmwYCiABKAlSCGltYWdlVXJs');

@$core.Deprecated('Use getDestinationRequestDescriptor instead')
const GetDestinationRequest$json = {
  '1': 'GetDestinationRequest',
  '2': [
    {'1': 'ref', '3': 1, '4': 1, '5': 9, '10': 'ref'},
  ],
};

/// Descriptor for `GetDestinationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDestinationRequestDescriptor = $convert.base64Decode(
    'ChVHZXREZXN0aW5hdGlvblJlcXVlc3QSEAoDcmVmGAEgASgJUgNyZWY=');

@$core.Deprecated('Use listDestinationsRequestDescriptor instead')
const ListDestinationsRequest$json = {
  '1': 'ListDestinationsRequest',
};

/// Descriptor for `ListDestinationsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listDestinationsRequestDescriptor = $convert.base64Decode(
    'ChdMaXN0RGVzdGluYXRpb25zUmVxdWVzdA==');

@$core.Deprecated('Use listDestinationsResponseDescriptor instead')
const ListDestinationsResponse$json = {
  '1': 'ListDestinationsResponse',
  '2': [
    {'1': 'destinations', '3': 1, '4': 3, '5': 11, '6': '.moon.space.v1.Destination', '10': 'destinations'},
  ],
};

/// Descriptor for `ListDestinationsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listDestinationsResponseDescriptor = $convert.base64Decode(
    'ChhMaXN0RGVzdGluYXRpb25zUmVzcG9uc2USPgoMZGVzdGluYXRpb25zGAEgAygLMhoubW9vbi'
    '5zcGFjZS52MS5EZXN0aW5hdGlvblIMZGVzdGluYXRpb25z');

@$core.Deprecated('Use createDestinationRequestDescriptor instead')
const CreateDestinationRequest$json = {
  '1': 'CreateDestinationRequest',
  '2': [
    {'1': 'destination', '3': 1, '4': 1, '5': 11, '6': '.moon.space.v1.Destination', '10': 'destination'},
  ],
};

/// Descriptor for `CreateDestinationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createDestinationRequestDescriptor = $convert.base64Decode(
    'ChhDcmVhdGVEZXN0aW5hdGlvblJlcXVlc3QSPAoLZGVzdGluYXRpb24YASABKAsyGi5tb29uLn'
    'NwYWNlLnYxLkRlc3RpbmF0aW9uUgtkZXN0aW5hdGlvbg==');

@$core.Deprecated('Use updateDestinationRequestDescriptor instead')
const UpdateDestinationRequest$json = {
  '1': 'UpdateDestinationRequest',
  '2': [
    {'1': 'destination', '3': 1, '4': 1, '5': 11, '6': '.moon.space.v1.Destination', '10': 'destination'},
  ],
};

/// Descriptor for `UpdateDestinationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateDestinationRequestDescriptor = $convert.base64Decode(
    'ChhVcGRhdGVEZXN0aW5hdGlvblJlcXVlc3QSPAoLZGVzdGluYXRpb24YASABKAsyGi5tb29uLn'
    'NwYWNlLnYxLkRlc3RpbmF0aW9uUgtkZXN0aW5hdGlvbg==');

@$core.Deprecated('Use deleteDestinationRequestDescriptor instead')
const DeleteDestinationRequest$json = {
  '1': 'DeleteDestinationRequest',
  '2': [
    {'1': 'ref', '3': 1, '4': 1, '5': 9, '10': 'ref'},
  ],
};

/// Descriptor for `DeleteDestinationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteDestinationRequestDescriptor = $convert.base64Decode(
    'ChhEZWxldGVEZXN0aW5hdGlvblJlcXVlc3QSEAoDcmVmGAEgASgJUgNyZWY=');

@$core.Deprecated('Use getActivityRequestDescriptor instead')
const GetActivityRequest$json = {
  '1': 'GetActivityRequest',
  '2': [
    {'1': 'ref', '3': 1, '4': 1, '5': 9, '10': 'ref'},
  ],
};

/// Descriptor for `GetActivityRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getActivityRequestDescriptor = $convert.base64Decode(
    'ChJHZXRBY3Rpdml0eVJlcXVlc3QSEAoDcmVmGAEgASgJUgNyZWY=');

@$core.Deprecated('Use listActivitiesRequestDescriptor instead')
const ListActivitiesRequest$json = {
  '1': 'ListActivitiesRequest',
  '2': [
    {'1': 'destination_ref', '3': 1, '4': 1, '5': 9, '10': 'destinationRef'},
  ],
};

/// Descriptor for `ListActivitiesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listActivitiesRequestDescriptor = $convert.base64Decode(
    'ChVMaXN0QWN0aXZpdGllc1JlcXVlc3QSJwoPZGVzdGluYXRpb25fcmVmGAEgASgJUg5kZXN0aW'
    '5hdGlvblJlZg==');

@$core.Deprecated('Use listActivitiesResponseDescriptor instead')
const ListActivitiesResponse$json = {
  '1': 'ListActivitiesResponse',
  '2': [
    {'1': 'activities', '3': 1, '4': 3, '5': 11, '6': '.moon.space.v1.Activity', '10': 'activities'},
  ],
};

/// Descriptor for `ListActivitiesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listActivitiesResponseDescriptor = $convert.base64Decode(
    'ChZMaXN0QWN0aXZpdGllc1Jlc3BvbnNlEjcKCmFjdGl2aXRpZXMYASADKAsyFy5tb29uLnNwYW'
    'NlLnYxLkFjdGl2aXR5UgphY3Rpdml0aWVz');

@$core.Deprecated('Use createActivityRequestDescriptor instead')
const CreateActivityRequest$json = {
  '1': 'CreateActivityRequest',
  '2': [
    {'1': 'activity', '3': 1, '4': 1, '5': 11, '6': '.moon.space.v1.Activity', '10': 'activity'},
  ],
};

/// Descriptor for `CreateActivityRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createActivityRequestDescriptor = $convert.base64Decode(
    'ChVDcmVhdGVBY3Rpdml0eVJlcXVlc3QSMwoIYWN0aXZpdHkYASABKAsyFy5tb29uLnNwYWNlLn'
    'YxLkFjdGl2aXR5UghhY3Rpdml0eQ==');

@$core.Deprecated('Use updateActivityRequestDescriptor instead')
const UpdateActivityRequest$json = {
  '1': 'UpdateActivityRequest',
  '2': [
    {'1': 'activity', '3': 1, '4': 1, '5': 11, '6': '.moon.space.v1.Activity', '10': 'activity'},
  ],
};

/// Descriptor for `UpdateActivityRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateActivityRequestDescriptor = $convert.base64Decode(
    'ChVVcGRhdGVBY3Rpdml0eVJlcXVlc3QSMwoIYWN0aXZpdHkYASABKAsyFy5tb29uLnNwYWNlLn'
    'YxLkFjdGl2aXR5UghhY3Rpdml0eQ==');

@$core.Deprecated('Use deleteActivityRequestDescriptor instead')
const DeleteActivityRequest$json = {
  '1': 'DeleteActivityRequest',
  '2': [
    {'1': 'ref', '3': 1, '4': 1, '5': 9, '10': 'ref'},
  ],
};

/// Descriptor for `DeleteActivityRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteActivityRequestDescriptor = $convert.base64Decode(
    'ChVEZWxldGVBY3Rpdml0eVJlcXVlc3QSEAoDcmVmGAEgASgJUgNyZWY=');

@$core.Deprecated('Use bookingRequestDescriptor instead')
const BookingRequest$json = {
  '1': 'BookingRequest',
  '2': [
    {'1': 'destination_ref', '3': 1, '4': 1, '5': 9, '10': 'destinationRef'},
    {'1': 'activity_refs', '3': 2, '4': 3, '5': 9, '10': 'activityRefs'},
    {'1': 'start_date', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'startDate'},
    {'1': 'end_date', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'endDate'},
    {'1': 'user_id', '3': 5, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `BookingRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bookingRequestDescriptor = $convert.base64Decode(
    'Cg5Cb29raW5nUmVxdWVzdBInCg9kZXN0aW5hdGlvbl9yZWYYASABKAlSDmRlc3RpbmF0aW9uUm'
    'VmEiMKDWFjdGl2aXR5X3JlZnMYAiADKAlSDGFjdGl2aXR5UmVmcxI5CgpzdGFydF9kYXRlGAMg'
    'ASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJc3RhcnREYXRlEjUKCGVuZF9kYXRlGA'
    'QgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIHZW5kRGF0ZRIXCgd1c2VyX2lkGAUg'
    'ASgJUgZ1c2VySWQ=');

@$core.Deprecated('Use bookingResponseDescriptor instead')
const BookingResponse$json = {
  '1': 'BookingResponse',
  '2': [
    {'1': 'booking_id', '3': 1, '4': 1, '5': 9, '10': 'bookingId'},
    {'1': 'status', '3': 6, '4': 1, '5': 14, '6': '.moon.space.v1.BookingStatus', '10': 'status'},
  ],
};

/// Descriptor for `BookingResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bookingResponseDescriptor = $convert.base64Decode(
    'Cg9Cb29raW5nUmVzcG9uc2USHQoKYm9va2luZ19pZBgBIAEoCVIJYm9va2luZ0lkEjQKBnN0YX'
    'R1cxgGIAEoDjIcLm1vb24uc3BhY2UudjEuQm9va2luZ1N0YXR1c1IGc3RhdHVz');

@$core.Deprecated('Use emptyResponseDescriptor instead')
const EmptyResponse$json = {
  '1': 'EmptyResponse',
};

/// Descriptor for `EmptyResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List emptyResponseDescriptor = $convert.base64Decode(
    'Cg1FbXB0eVJlc3BvbnNl');

const $core.Map<$core.String, $core.dynamic> TravelServiceBase$json = {
  '1': 'TravelService',
  '2': [
    {'1': 'GetDestination', '2': '.moon.space.v1.GetDestinationRequest', '3': '.moon.space.v1.Destination'},
    {'1': 'SearchDestinations', '2': '.moon.space.v1.GetDestinationRequest', '3': '.moon.space.v1.ListDestinationsResponse'},
    {'1': 'ListDestinations', '2': '.moon.space.v1.ListDestinationsRequest', '3': '.moon.space.v1.ListDestinationsResponse'},
    {'1': 'CreateDestination', '2': '.moon.space.v1.CreateDestinationRequest', '3': '.moon.space.v1.Destination'},
    {'1': 'UpdateDestination', '2': '.moon.space.v1.UpdateDestinationRequest', '3': '.moon.space.v1.Destination'},
    {'1': 'DeleteDestination', '2': '.moon.space.v1.DeleteDestinationRequest', '3': '.moon.space.v1.EmptyResponse'},
    {'1': 'GetActivity', '2': '.moon.space.v1.GetActivityRequest', '3': '.moon.space.v1.Activity'},
    {'1': 'ListActivities', '2': '.moon.space.v1.ListActivitiesRequest', '3': '.moon.space.v1.ListActivitiesResponse'},
    {'1': 'CreateActivity', '2': '.moon.space.v1.CreateActivityRequest', '3': '.moon.space.v1.Activity'},
    {'1': 'UpdateActivity', '2': '.moon.space.v1.UpdateActivityRequest', '3': '.moon.space.v1.Activity'},
    {'1': 'DeleteActivity', '2': '.moon.space.v1.DeleteActivityRequest', '3': '.moon.space.v1.EmptyResponse'},
    {'1': 'BookDestination', '2': '.moon.space.v1.BookingRequest', '3': '.moon.space.v1.BookingResponse'},
  ],
};

@$core.Deprecated('Use travelServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>> TravelServiceBase$messageJson = {
  '.moon.space.v1.GetDestinationRequest': GetDestinationRequest$json,
  '.moon.space.v1.Destination': Destination$json,
  '.moon.space.v1.ListDestinationsResponse': ListDestinationsResponse$json,
  '.moon.space.v1.ListDestinationsRequest': ListDestinationsRequest$json,
  '.moon.space.v1.CreateDestinationRequest': CreateDestinationRequest$json,
  '.moon.space.v1.UpdateDestinationRequest': UpdateDestinationRequest$json,
  '.moon.space.v1.DeleteDestinationRequest': DeleteDestinationRequest$json,
  '.moon.space.v1.EmptyResponse': EmptyResponse$json,
  '.moon.space.v1.GetActivityRequest': GetActivityRequest$json,
  '.moon.space.v1.Activity': Activity$json,
  '.moon.space.v1.ListActivitiesRequest': ListActivitiesRequest$json,
  '.moon.space.v1.ListActivitiesResponse': ListActivitiesResponse$json,
  '.moon.space.v1.CreateActivityRequest': CreateActivityRequest$json,
  '.moon.space.v1.UpdateActivityRequest': UpdateActivityRequest$json,
  '.moon.space.v1.DeleteActivityRequest': DeleteActivityRequest$json,
  '.moon.space.v1.BookingRequest': BookingRequest$json,
  '.google.protobuf.Timestamp': $0.Timestamp$json,
  '.moon.space.v1.BookingResponse': BookingResponse$json,
};

/// Descriptor for `TravelService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List travelServiceDescriptor = $convert.base64Decode(
    'Cg1UcmF2ZWxTZXJ2aWNlElIKDkdldERlc3RpbmF0aW9uEiQubW9vbi5zcGFjZS52MS5HZXREZX'
    'N0aW5hdGlvblJlcXVlc3QaGi5tb29uLnNwYWNlLnYxLkRlc3RpbmF0aW9uEmMKElNlYXJjaERl'
    'c3RpbmF0aW9ucxIkLm1vb24uc3BhY2UudjEuR2V0RGVzdGluYXRpb25SZXF1ZXN0GicubW9vbi'
    '5zcGFjZS52MS5MaXN0RGVzdGluYXRpb25zUmVzcG9uc2USYwoQTGlzdERlc3RpbmF0aW9ucxIm'
    'Lm1vb24uc3BhY2UudjEuTGlzdERlc3RpbmF0aW9uc1JlcXVlc3QaJy5tb29uLnNwYWNlLnYxLk'
    'xpc3REZXN0aW5hdGlvbnNSZXNwb25zZRJYChFDcmVhdGVEZXN0aW5hdGlvbhInLm1vb24uc3Bh'
    'Y2UudjEuQ3JlYXRlRGVzdGluYXRpb25SZXF1ZXN0GhoubW9vbi5zcGFjZS52MS5EZXN0aW5hdG'
    'lvbhJYChFVcGRhdGVEZXN0aW5hdGlvbhInLm1vb24uc3BhY2UudjEuVXBkYXRlRGVzdGluYXRp'
    'b25SZXF1ZXN0GhoubW9vbi5zcGFjZS52MS5EZXN0aW5hdGlvbhJaChFEZWxldGVEZXN0aW5hdG'
    'lvbhInLm1vb24uc3BhY2UudjEuRGVsZXRlRGVzdGluYXRpb25SZXF1ZXN0GhwubW9vbi5zcGFj'
    'ZS52MS5FbXB0eVJlc3BvbnNlEkkKC0dldEFjdGl2aXR5EiEubW9vbi5zcGFjZS52MS5HZXRBY3'
    'Rpdml0eVJlcXVlc3QaFy5tb29uLnNwYWNlLnYxLkFjdGl2aXR5El0KDkxpc3RBY3Rpdml0aWVz'
    'EiQubW9vbi5zcGFjZS52MS5MaXN0QWN0aXZpdGllc1JlcXVlc3QaJS5tb29uLnNwYWNlLnYxLk'
    'xpc3RBY3Rpdml0aWVzUmVzcG9uc2USTwoOQ3JlYXRlQWN0aXZpdHkSJC5tb29uLnNwYWNlLnYx'
    'LkNyZWF0ZUFjdGl2aXR5UmVxdWVzdBoXLm1vb24uc3BhY2UudjEuQWN0aXZpdHkSTwoOVXBkYX'
    'RlQWN0aXZpdHkSJC5tb29uLnNwYWNlLnYxLlVwZGF0ZUFjdGl2aXR5UmVxdWVzdBoXLm1vb24u'
    'c3BhY2UudjEuQWN0aXZpdHkSVAoORGVsZXRlQWN0aXZpdHkSJC5tb29uLnNwYWNlLnYxLkRlbG'
    'V0ZUFjdGl2aXR5UmVxdWVzdBocLm1vb24uc3BhY2UudjEuRW1wdHlSZXNwb25zZRJQCg9Cb29r'
    'RGVzdGluYXRpb24SHS5tb29uLnNwYWNlLnYxLkJvb2tpbmdSZXF1ZXN0Gh4ubW9vbi5zcGFjZS'
    '52MS5Cb29raW5nUmVzcG9uc2U=');


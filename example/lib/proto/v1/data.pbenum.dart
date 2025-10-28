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

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class BookingStatus extends $pb.ProtobufEnum {
  static const BookingStatus BOOKING_STATUS_UNSPECIFIED = BookingStatus._(0, _omitEnumNames ? '' : 'BOOKING_STATUS_UNSPECIFIED');
  static const BookingStatus BOOKING_STATUS_PENDING = BookingStatus._(1, _omitEnumNames ? '' : 'BOOKING_STATUS_PENDING');
  static const BookingStatus BOOKING_STATUS_CONFIRMED = BookingStatus._(2, _omitEnumNames ? '' : 'BOOKING_STATUS_CONFIRMED');
  static const BookingStatus BOOKING_STATUS_CANCELLED = BookingStatus._(3, _omitEnumNames ? '' : 'BOOKING_STATUS_CANCELLED');
  static const BookingStatus BOOKING_STATUS_COMPLETED = BookingStatus._(4, _omitEnumNames ? '' : 'BOOKING_STATUS_COMPLETED');

  static const $core.List<BookingStatus> values = <BookingStatus> [
    BOOKING_STATUS_UNSPECIFIED,
    BOOKING_STATUS_PENDING,
    BOOKING_STATUS_CONFIRMED,
    BOOKING_STATUS_CANCELLED,
    BOOKING_STATUS_COMPLETED,
  ];

  static final $core.List<BookingStatus?> _byValue = $pb.ProtobufEnum.$_initByValueList(values, 4);
  static BookingStatus? valueOf($core.int value) =>  value < 0 || value >= _byValue.length ? null : _byValue[value];

  const BookingStatus._(super.value, super.name);
}


const $core.bool _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');

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

import 'data.pbenum.dart';
import 'google/protobuf/timestamp.pb.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'data.pbenum.dart';

class Destination extends $pb.GeneratedMessage {
  factory Destination({
    $core.String? ref,
    $core.String? name,
    $core.String? country,
    $core.String? continent,
    $core.String? knownFor,
    $core.Iterable<$core.String>? tags,
    $core.String? imageUrl,
  }) {
    final result = create();
    if (ref != null) result.ref = ref;
    if (name != null) result.name = name;
    if (country != null) result.country = country;
    if (continent != null) result.continent = continent;
    if (knownFor != null) result.knownFor = knownFor;
    if (tags != null) result.tags.addAll(tags);
    if (imageUrl != null) result.imageUrl = imageUrl;
    return result;
  }

  Destination._();

  factory Destination.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory Destination.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Destination', package: const $pb.PackageName(_omitMessageNames ? '' : 'moon.space.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'ref')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'country')
    ..aOS(4, _omitFieldNames ? '' : 'continent')
    ..aOS(5, _omitFieldNames ? '' : 'knownFor')
    ..pPS(6, _omitFieldNames ? '' : 'tags')
    ..aOS(7, _omitFieldNames ? '' : 'imageUrl')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Destination clone() => Destination()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Destination copyWith(void Function(Destination) updates) => super.copyWith((message) => updates(message as Destination)) as Destination;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Destination create() => Destination._();
  @$core.override
  Destination createEmptyInstance() => create();
  static $pb.PbList<Destination> createRepeated() => $pb.PbList<Destination>();
  @$core.pragma('dart2js:noInline')
  static Destination getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Destination>(create);
  static Destination? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ref => $_getSZ(0);
  @$pb.TagNumber(1)
  set ref($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRef() => $_has(0);
  @$pb.TagNumber(1)
  void clearRef() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get country => $_getSZ(2);
  @$pb.TagNumber(3)
  set country($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCountry() => $_has(2);
  @$pb.TagNumber(3)
  void clearCountry() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get continent => $_getSZ(3);
  @$pb.TagNumber(4)
  set continent($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasContinent() => $_has(3);
  @$pb.TagNumber(4)
  void clearContinent() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get knownFor => $_getSZ(4);
  @$pb.TagNumber(5)
  set knownFor($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasKnownFor() => $_has(4);
  @$pb.TagNumber(5)
  void clearKnownFor() => $_clearField(5);

  @$pb.TagNumber(6)
  $pb.PbList<$core.String> get tags => $_getList(5);

  @$pb.TagNumber(7)
  $core.String get imageUrl => $_getSZ(6);
  @$pb.TagNumber(7)
  set imageUrl($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasImageUrl() => $_has(6);
  @$pb.TagNumber(7)
  void clearImageUrl() => $_clearField(7);
}

class Activity extends $pb.GeneratedMessage {
  factory Activity({
    $core.String? ref,
    $core.String? name,
    $core.String? description,
    $core.String? locationName,
    $core.double? duration,
    $core.String? timeOfDay,
    $core.bool? familyFriendly,
    $core.int? price,
    $core.String? destinationRef,
    $core.String? imageUrl,
  }) {
    final result = create();
    if (ref != null) result.ref = ref;
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    if (locationName != null) result.locationName = locationName;
    if (duration != null) result.duration = duration;
    if (timeOfDay != null) result.timeOfDay = timeOfDay;
    if (familyFriendly != null) result.familyFriendly = familyFriendly;
    if (price != null) result.price = price;
    if (destinationRef != null) result.destinationRef = destinationRef;
    if (imageUrl != null) result.imageUrl = imageUrl;
    return result;
  }

  Activity._();

  factory Activity.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory Activity.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Activity', package: const $pb.PackageName(_omitMessageNames ? '' : 'moon.space.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'ref')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..aOS(4, _omitFieldNames ? '' : 'locationName')
    ..a<$core.double>(5, _omitFieldNames ? '' : 'duration', $pb.PbFieldType.OF)
    ..aOS(6, _omitFieldNames ? '' : 'timeOfDay')
    ..aOB(7, _omitFieldNames ? '' : 'familyFriendly')
    ..a<$core.int>(8, _omitFieldNames ? '' : 'price', $pb.PbFieldType.O3)
    ..aOS(9, _omitFieldNames ? '' : 'destinationRef')
    ..aOS(10, _omitFieldNames ? '' : 'imageUrl')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Activity clone() => Activity()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Activity copyWith(void Function(Activity) updates) => super.copyWith((message) => updates(message as Activity)) as Activity;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Activity create() => Activity._();
  @$core.override
  Activity createEmptyInstance() => create();
  static $pb.PbList<Activity> createRepeated() => $pb.PbList<Activity>();
  @$core.pragma('dart2js:noInline')
  static Activity getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Activity>(create);
  static Activity? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ref => $_getSZ(0);
  @$pb.TagNumber(1)
  set ref($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRef() => $_has(0);
  @$pb.TagNumber(1)
  void clearRef() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get locationName => $_getSZ(3);
  @$pb.TagNumber(4)
  set locationName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasLocationName() => $_has(3);
  @$pb.TagNumber(4)
  void clearLocationName() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get duration => $_getN(4);
  @$pb.TagNumber(5)
  set duration($core.double value) => $_setFloat(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDuration() => $_has(4);
  @$pb.TagNumber(5)
  void clearDuration() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get timeOfDay => $_getSZ(5);
  @$pb.TagNumber(6)
  set timeOfDay($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasTimeOfDay() => $_has(5);
  @$pb.TagNumber(6)
  void clearTimeOfDay() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.bool get familyFriendly => $_getBF(6);
  @$pb.TagNumber(7)
  set familyFriendly($core.bool value) => $_setBool(6, value);
  @$pb.TagNumber(7)
  $core.bool hasFamilyFriendly() => $_has(6);
  @$pb.TagNumber(7)
  void clearFamilyFriendly() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.int get price => $_getIZ(7);
  @$pb.TagNumber(8)
  set price($core.int value) => $_setSignedInt32(7, value);
  @$pb.TagNumber(8)
  $core.bool hasPrice() => $_has(7);
  @$pb.TagNumber(8)
  void clearPrice() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get destinationRef => $_getSZ(8);
  @$pb.TagNumber(9)
  set destinationRef($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasDestinationRef() => $_has(8);
  @$pb.TagNumber(9)
  void clearDestinationRef() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get imageUrl => $_getSZ(9);
  @$pb.TagNumber(10)
  set imageUrl($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasImageUrl() => $_has(9);
  @$pb.TagNumber(10)
  void clearImageUrl() => $_clearField(10);
}

/// Destination messages
class GetDestinationRequest extends $pb.GeneratedMessage {
  factory GetDestinationRequest({
    $core.String? ref,
  }) {
    final result = create();
    if (ref != null) result.ref = ref;
    return result;
  }

  GetDestinationRequest._();

  factory GetDestinationRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetDestinationRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetDestinationRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'moon.space.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'ref')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDestinationRequest clone() => GetDestinationRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDestinationRequest copyWith(void Function(GetDestinationRequest) updates) => super.copyWith((message) => updates(message as GetDestinationRequest)) as GetDestinationRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetDestinationRequest create() => GetDestinationRequest._();
  @$core.override
  GetDestinationRequest createEmptyInstance() => create();
  static $pb.PbList<GetDestinationRequest> createRepeated() => $pb.PbList<GetDestinationRequest>();
  @$core.pragma('dart2js:noInline')
  static GetDestinationRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetDestinationRequest>(create);
  static GetDestinationRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ref => $_getSZ(0);
  @$pb.TagNumber(1)
  set ref($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRef() => $_has(0);
  @$pb.TagNumber(1)
  void clearRef() => $_clearField(1);
}

class ListDestinationsRequest extends $pb.GeneratedMessage {
  factory ListDestinationsRequest() => create();

  ListDestinationsRequest._();

  factory ListDestinationsRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory ListDestinationsRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListDestinationsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'moon.space.v1'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListDestinationsRequest clone() => ListDestinationsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListDestinationsRequest copyWith(void Function(ListDestinationsRequest) updates) => super.copyWith((message) => updates(message as ListDestinationsRequest)) as ListDestinationsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListDestinationsRequest create() => ListDestinationsRequest._();
  @$core.override
  ListDestinationsRequest createEmptyInstance() => create();
  static $pb.PbList<ListDestinationsRequest> createRepeated() => $pb.PbList<ListDestinationsRequest>();
  @$core.pragma('dart2js:noInline')
  static ListDestinationsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListDestinationsRequest>(create);
  static ListDestinationsRequest? _defaultInstance;
}

class ListDestinationsResponse extends $pb.GeneratedMessage {
  factory ListDestinationsResponse({
    $core.Iterable<Destination>? destinations,
  }) {
    final result = create();
    if (destinations != null) result.destinations.addAll(destinations);
    return result;
  }

  ListDestinationsResponse._();

  factory ListDestinationsResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory ListDestinationsResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListDestinationsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'moon.space.v1'), createEmptyInstance: create)
    ..pc<Destination>(1, _omitFieldNames ? '' : 'destinations', $pb.PbFieldType.PM, subBuilder: Destination.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListDestinationsResponse clone() => ListDestinationsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListDestinationsResponse copyWith(void Function(ListDestinationsResponse) updates) => super.copyWith((message) => updates(message as ListDestinationsResponse)) as ListDestinationsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListDestinationsResponse create() => ListDestinationsResponse._();
  @$core.override
  ListDestinationsResponse createEmptyInstance() => create();
  static $pb.PbList<ListDestinationsResponse> createRepeated() => $pb.PbList<ListDestinationsResponse>();
  @$core.pragma('dart2js:noInline')
  static ListDestinationsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListDestinationsResponse>(create);
  static ListDestinationsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Destination> get destinations => $_getList(0);
}

class CreateDestinationRequest extends $pb.GeneratedMessage {
  factory CreateDestinationRequest({
    Destination? destination,
  }) {
    final result = create();
    if (destination != null) result.destination = destination;
    return result;
  }

  CreateDestinationRequest._();

  factory CreateDestinationRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory CreateDestinationRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateDestinationRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'moon.space.v1'), createEmptyInstance: create)
    ..aOM<Destination>(1, _omitFieldNames ? '' : 'destination', subBuilder: Destination.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateDestinationRequest clone() => CreateDestinationRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateDestinationRequest copyWith(void Function(CreateDestinationRequest) updates) => super.copyWith((message) => updates(message as CreateDestinationRequest)) as CreateDestinationRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateDestinationRequest create() => CreateDestinationRequest._();
  @$core.override
  CreateDestinationRequest createEmptyInstance() => create();
  static $pb.PbList<CreateDestinationRequest> createRepeated() => $pb.PbList<CreateDestinationRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateDestinationRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateDestinationRequest>(create);
  static CreateDestinationRequest? _defaultInstance;

  @$pb.TagNumber(1)
  Destination get destination => $_getN(0);
  @$pb.TagNumber(1)
  set destination(Destination value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasDestination() => $_has(0);
  @$pb.TagNumber(1)
  void clearDestination() => $_clearField(1);
  @$pb.TagNumber(1)
  Destination ensureDestination() => $_ensure(0);
}

class UpdateDestinationRequest extends $pb.GeneratedMessage {
  factory UpdateDestinationRequest({
    Destination? destination,
  }) {
    final result = create();
    if (destination != null) result.destination = destination;
    return result;
  }

  UpdateDestinationRequest._();

  factory UpdateDestinationRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory UpdateDestinationRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateDestinationRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'moon.space.v1'), createEmptyInstance: create)
    ..aOM<Destination>(1, _omitFieldNames ? '' : 'destination', subBuilder: Destination.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateDestinationRequest clone() => UpdateDestinationRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateDestinationRequest copyWith(void Function(UpdateDestinationRequest) updates) => super.copyWith((message) => updates(message as UpdateDestinationRequest)) as UpdateDestinationRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateDestinationRequest create() => UpdateDestinationRequest._();
  @$core.override
  UpdateDestinationRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateDestinationRequest> createRepeated() => $pb.PbList<UpdateDestinationRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateDestinationRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateDestinationRequest>(create);
  static UpdateDestinationRequest? _defaultInstance;

  @$pb.TagNumber(1)
  Destination get destination => $_getN(0);
  @$pb.TagNumber(1)
  set destination(Destination value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasDestination() => $_has(0);
  @$pb.TagNumber(1)
  void clearDestination() => $_clearField(1);
  @$pb.TagNumber(1)
  Destination ensureDestination() => $_ensure(0);
}

class DeleteDestinationRequest extends $pb.GeneratedMessage {
  factory DeleteDestinationRequest({
    $core.String? ref,
  }) {
    final result = create();
    if (ref != null) result.ref = ref;
    return result;
  }

  DeleteDestinationRequest._();

  factory DeleteDestinationRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory DeleteDestinationRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DeleteDestinationRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'moon.space.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'ref')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteDestinationRequest clone() => DeleteDestinationRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteDestinationRequest copyWith(void Function(DeleteDestinationRequest) updates) => super.copyWith((message) => updates(message as DeleteDestinationRequest)) as DeleteDestinationRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteDestinationRequest create() => DeleteDestinationRequest._();
  @$core.override
  DeleteDestinationRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteDestinationRequest> createRepeated() => $pb.PbList<DeleteDestinationRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteDestinationRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteDestinationRequest>(create);
  static DeleteDestinationRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ref => $_getSZ(0);
  @$pb.TagNumber(1)
  set ref($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRef() => $_has(0);
  @$pb.TagNumber(1)
  void clearRef() => $_clearField(1);
}

/// Activity messages
class GetActivityRequest extends $pb.GeneratedMessage {
  factory GetActivityRequest({
    $core.String? ref,
  }) {
    final result = create();
    if (ref != null) result.ref = ref;
    return result;
  }

  GetActivityRequest._();

  factory GetActivityRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetActivityRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetActivityRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'moon.space.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'ref')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetActivityRequest clone() => GetActivityRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetActivityRequest copyWith(void Function(GetActivityRequest) updates) => super.copyWith((message) => updates(message as GetActivityRequest)) as GetActivityRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetActivityRequest create() => GetActivityRequest._();
  @$core.override
  GetActivityRequest createEmptyInstance() => create();
  static $pb.PbList<GetActivityRequest> createRepeated() => $pb.PbList<GetActivityRequest>();
  @$core.pragma('dart2js:noInline')
  static GetActivityRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetActivityRequest>(create);
  static GetActivityRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ref => $_getSZ(0);
  @$pb.TagNumber(1)
  set ref($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRef() => $_has(0);
  @$pb.TagNumber(1)
  void clearRef() => $_clearField(1);
}

class ListActivitiesRequest extends $pb.GeneratedMessage {
  factory ListActivitiesRequest({
    $core.String? destinationRef,
  }) {
    final result = create();
    if (destinationRef != null) result.destinationRef = destinationRef;
    return result;
  }

  ListActivitiesRequest._();

  factory ListActivitiesRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory ListActivitiesRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListActivitiesRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'moon.space.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'destinationRef')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListActivitiesRequest clone() => ListActivitiesRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListActivitiesRequest copyWith(void Function(ListActivitiesRequest) updates) => super.copyWith((message) => updates(message as ListActivitiesRequest)) as ListActivitiesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListActivitiesRequest create() => ListActivitiesRequest._();
  @$core.override
  ListActivitiesRequest createEmptyInstance() => create();
  static $pb.PbList<ListActivitiesRequest> createRepeated() => $pb.PbList<ListActivitiesRequest>();
  @$core.pragma('dart2js:noInline')
  static ListActivitiesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListActivitiesRequest>(create);
  static ListActivitiesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get destinationRef => $_getSZ(0);
  @$pb.TagNumber(1)
  set destinationRef($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDestinationRef() => $_has(0);
  @$pb.TagNumber(1)
  void clearDestinationRef() => $_clearField(1);
}

class ListActivitiesResponse extends $pb.GeneratedMessage {
  factory ListActivitiesResponse({
    $core.Iterable<Activity>? activities,
  }) {
    final result = create();
    if (activities != null) result.activities.addAll(activities);
    return result;
  }

  ListActivitiesResponse._();

  factory ListActivitiesResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory ListActivitiesResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListActivitiesResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'moon.space.v1'), createEmptyInstance: create)
    ..pc<Activity>(1, _omitFieldNames ? '' : 'activities', $pb.PbFieldType.PM, subBuilder: Activity.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListActivitiesResponse clone() => ListActivitiesResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListActivitiesResponse copyWith(void Function(ListActivitiesResponse) updates) => super.copyWith((message) => updates(message as ListActivitiesResponse)) as ListActivitiesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListActivitiesResponse create() => ListActivitiesResponse._();
  @$core.override
  ListActivitiesResponse createEmptyInstance() => create();
  static $pb.PbList<ListActivitiesResponse> createRepeated() => $pb.PbList<ListActivitiesResponse>();
  @$core.pragma('dart2js:noInline')
  static ListActivitiesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListActivitiesResponse>(create);
  static ListActivitiesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Activity> get activities => $_getList(0);
}

class CreateActivityRequest extends $pb.GeneratedMessage {
  factory CreateActivityRequest({
    Activity? activity,
  }) {
    final result = create();
    if (activity != null) result.activity = activity;
    return result;
  }

  CreateActivityRequest._();

  factory CreateActivityRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory CreateActivityRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateActivityRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'moon.space.v1'), createEmptyInstance: create)
    ..aOM<Activity>(1, _omitFieldNames ? '' : 'activity', subBuilder: Activity.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateActivityRequest clone() => CreateActivityRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateActivityRequest copyWith(void Function(CreateActivityRequest) updates) => super.copyWith((message) => updates(message as CreateActivityRequest)) as CreateActivityRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateActivityRequest create() => CreateActivityRequest._();
  @$core.override
  CreateActivityRequest createEmptyInstance() => create();
  static $pb.PbList<CreateActivityRequest> createRepeated() => $pb.PbList<CreateActivityRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateActivityRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateActivityRequest>(create);
  static CreateActivityRequest? _defaultInstance;

  @$pb.TagNumber(1)
  Activity get activity => $_getN(0);
  @$pb.TagNumber(1)
  set activity(Activity value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasActivity() => $_has(0);
  @$pb.TagNumber(1)
  void clearActivity() => $_clearField(1);
  @$pb.TagNumber(1)
  Activity ensureActivity() => $_ensure(0);
}

class UpdateActivityRequest extends $pb.GeneratedMessage {
  factory UpdateActivityRequest({
    Activity? activity,
  }) {
    final result = create();
    if (activity != null) result.activity = activity;
    return result;
  }

  UpdateActivityRequest._();

  factory UpdateActivityRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory UpdateActivityRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateActivityRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'moon.space.v1'), createEmptyInstance: create)
    ..aOM<Activity>(1, _omitFieldNames ? '' : 'activity', subBuilder: Activity.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateActivityRequest clone() => UpdateActivityRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateActivityRequest copyWith(void Function(UpdateActivityRequest) updates) => super.copyWith((message) => updates(message as UpdateActivityRequest)) as UpdateActivityRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateActivityRequest create() => UpdateActivityRequest._();
  @$core.override
  UpdateActivityRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateActivityRequest> createRepeated() => $pb.PbList<UpdateActivityRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateActivityRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateActivityRequest>(create);
  static UpdateActivityRequest? _defaultInstance;

  @$pb.TagNumber(1)
  Activity get activity => $_getN(0);
  @$pb.TagNumber(1)
  set activity(Activity value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasActivity() => $_has(0);
  @$pb.TagNumber(1)
  void clearActivity() => $_clearField(1);
  @$pb.TagNumber(1)
  Activity ensureActivity() => $_ensure(0);
}

class DeleteActivityRequest extends $pb.GeneratedMessage {
  factory DeleteActivityRequest({
    $core.String? ref,
  }) {
    final result = create();
    if (ref != null) result.ref = ref;
    return result;
  }

  DeleteActivityRequest._();

  factory DeleteActivityRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory DeleteActivityRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DeleteActivityRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'moon.space.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'ref')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteActivityRequest clone() => DeleteActivityRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteActivityRequest copyWith(void Function(DeleteActivityRequest) updates) => super.copyWith((message) => updates(message as DeleteActivityRequest)) as DeleteActivityRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteActivityRequest create() => DeleteActivityRequest._();
  @$core.override
  DeleteActivityRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteActivityRequest> createRepeated() => $pb.PbList<DeleteActivityRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteActivityRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteActivityRequest>(create);
  static DeleteActivityRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ref => $_getSZ(0);
  @$pb.TagNumber(1)
  set ref($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRef() => $_has(0);
  @$pb.TagNumber(1)
  void clearRef() => $_clearField(1);
}

/// Booking
class BookingRequest extends $pb.GeneratedMessage {
  factory BookingRequest({
    $core.String? destinationRef,
    $core.Iterable<$core.String>? activityRefs,
    $0.Timestamp? startDate,
    $0.Timestamp? endDate,
    $core.String? userId,
  }) {
    final result = create();
    if (destinationRef != null) result.destinationRef = destinationRef;
    if (activityRefs != null) result.activityRefs.addAll(activityRefs);
    if (startDate != null) result.startDate = startDate;
    if (endDate != null) result.endDate = endDate;
    if (userId != null) result.userId = userId;
    return result;
  }

  BookingRequest._();

  factory BookingRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory BookingRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BookingRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'moon.space.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'destinationRef')
    ..pPS(2, _omitFieldNames ? '' : 'activityRefs')
    ..aOM<$0.Timestamp>(3, _omitFieldNames ? '' : 'startDate', subBuilder: $0.Timestamp.create)
    ..aOM<$0.Timestamp>(4, _omitFieldNames ? '' : 'endDate', subBuilder: $0.Timestamp.create)
    ..aOS(5, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BookingRequest clone() => BookingRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BookingRequest copyWith(void Function(BookingRequest) updates) => super.copyWith((message) => updates(message as BookingRequest)) as BookingRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BookingRequest create() => BookingRequest._();
  @$core.override
  BookingRequest createEmptyInstance() => create();
  static $pb.PbList<BookingRequest> createRepeated() => $pb.PbList<BookingRequest>();
  @$core.pragma('dart2js:noInline')
  static BookingRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BookingRequest>(create);
  static BookingRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get destinationRef => $_getSZ(0);
  @$pb.TagNumber(1)
  set destinationRef($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDestinationRef() => $_has(0);
  @$pb.TagNumber(1)
  void clearDestinationRef() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<$core.String> get activityRefs => $_getList(1);

  @$pb.TagNumber(3)
  $0.Timestamp get startDate => $_getN(2);
  @$pb.TagNumber(3)
  set startDate($0.Timestamp value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasStartDate() => $_has(2);
  @$pb.TagNumber(3)
  void clearStartDate() => $_clearField(3);
  @$pb.TagNumber(3)
  $0.Timestamp ensureStartDate() => $_ensure(2);

  @$pb.TagNumber(4)
  $0.Timestamp get endDate => $_getN(3);
  @$pb.TagNumber(4)
  set endDate($0.Timestamp value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasEndDate() => $_has(3);
  @$pb.TagNumber(4)
  void clearEndDate() => $_clearField(4);
  @$pb.TagNumber(4)
  $0.Timestamp ensureEndDate() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.String get userId => $_getSZ(4);
  @$pb.TagNumber(5)
  set userId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasUserId() => $_has(4);
  @$pb.TagNumber(5)
  void clearUserId() => $_clearField(5);
}

class BookingResponse extends $pb.GeneratedMessage {
  factory BookingResponse({
    $core.String? bookingId,
    BookingStatus? status,
  }) {
    final result = create();
    if (bookingId != null) result.bookingId = bookingId;
    if (status != null) result.status = status;
    return result;
  }

  BookingResponse._();

  factory BookingResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory BookingResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BookingResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'moon.space.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'bookingId')
    ..e<BookingStatus>(6, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: BookingStatus.BOOKING_STATUS_UNSPECIFIED, valueOf: BookingStatus.valueOf, enumValues: BookingStatus.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BookingResponse clone() => BookingResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BookingResponse copyWith(void Function(BookingResponse) updates) => super.copyWith((message) => updates(message as BookingResponse)) as BookingResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BookingResponse create() => BookingResponse._();
  @$core.override
  BookingResponse createEmptyInstance() => create();
  static $pb.PbList<BookingResponse> createRepeated() => $pb.PbList<BookingResponse>();
  @$core.pragma('dart2js:noInline')
  static BookingResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BookingResponse>(create);
  static BookingResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get bookingId => $_getSZ(0);
  @$pb.TagNumber(1)
  set bookingId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasBookingId() => $_has(0);
  @$pb.TagNumber(1)
  void clearBookingId() => $_clearField(1);

  @$pb.TagNumber(6)
  BookingStatus get status => $_getN(1);
  @$pb.TagNumber(6)
  set status(BookingStatus value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(6)
  void clearStatus() => $_clearField(6);
}

class EmptyResponse extends $pb.GeneratedMessage {
  factory EmptyResponse() => create();

  EmptyResponse._();

  factory EmptyResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory EmptyResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'EmptyResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'moon.space.v1'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EmptyResponse clone() => EmptyResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EmptyResponse copyWith(void Function(EmptyResponse) updates) => super.copyWith((message) => updates(message as EmptyResponse)) as EmptyResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EmptyResponse create() => EmptyResponse._();
  @$core.override
  EmptyResponse createEmptyInstance() => create();
  static $pb.PbList<EmptyResponse> createRepeated() => $pb.PbList<EmptyResponse>();
  @$core.pragma('dart2js:noInline')
  static EmptyResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EmptyResponse>(create);
  static EmptyResponse? _defaultInstance;
}

class TravelServiceApi {
  final $pb.RpcClient _client;

  TravelServiceApi(this._client);

  $async.Future<Destination> getDestination($pb.ClientContext? ctx, GetDestinationRequest request) =>
    _client.invoke<Destination>(ctx, 'TravelService', 'GetDestination', request, Destination())
  ;
  $async.Future<ListDestinationsResponse> searchDestinations($pb.ClientContext? ctx, GetDestinationRequest request) =>
    _client.invoke<ListDestinationsResponse>(ctx, 'TravelService', 'SearchDestinations', request, ListDestinationsResponse())
  ;
  $async.Future<ListDestinationsResponse> listDestinations($pb.ClientContext? ctx, ListDestinationsRequest request) =>
    _client.invoke<ListDestinationsResponse>(ctx, 'TravelService', 'ListDestinations', request, ListDestinationsResponse())
  ;
  $async.Future<Destination> createDestination($pb.ClientContext? ctx, CreateDestinationRequest request) =>
    _client.invoke<Destination>(ctx, 'TravelService', 'CreateDestination', request, Destination())
  ;
  $async.Future<Destination> updateDestination($pb.ClientContext? ctx, UpdateDestinationRequest request) =>
    _client.invoke<Destination>(ctx, 'TravelService', 'UpdateDestination', request, Destination())
  ;
  $async.Future<EmptyResponse> deleteDestination($pb.ClientContext? ctx, DeleteDestinationRequest request) =>
    _client.invoke<EmptyResponse>(ctx, 'TravelService', 'DeleteDestination', request, EmptyResponse())
  ;
  $async.Future<Activity> getActivity($pb.ClientContext? ctx, GetActivityRequest request) =>
    _client.invoke<Activity>(ctx, 'TravelService', 'GetActivity', request, Activity())
  ;
  $async.Future<ListActivitiesResponse> listActivities($pb.ClientContext? ctx, ListActivitiesRequest request) =>
    _client.invoke<ListActivitiesResponse>(ctx, 'TravelService', 'ListActivities', request, ListActivitiesResponse())
  ;
  $async.Future<Activity> createActivity($pb.ClientContext? ctx, CreateActivityRequest request) =>
    _client.invoke<Activity>(ctx, 'TravelService', 'CreateActivity', request, Activity())
  ;
  $async.Future<Activity> updateActivity($pb.ClientContext? ctx, UpdateActivityRequest request) =>
    _client.invoke<Activity>(ctx, 'TravelService', 'UpdateActivity', request, Activity())
  ;
  $async.Future<EmptyResponse> deleteActivity($pb.ClientContext? ctx, DeleteActivityRequest request) =>
    _client.invoke<EmptyResponse>(ctx, 'TravelService', 'DeleteActivity', request, EmptyResponse())
  ;
  $async.Future<BookingResponse> bookDestination($pb.ClientContext? ctx, BookingRequest request) =>
    _client.invoke<BookingResponse>(ctx, 'TravelService', 'BookDestination', request, BookingResponse())
  ;
}


const $core.bool _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');

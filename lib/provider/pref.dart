import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'pref.g.dart';

@Riverpod(keepAlive: true)
class Pref extends _$Pref {
  SharedPreferences? get _pref => state.value;

  @override
  Future<SharedPreferences> build() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    return pref;
  }

  Future<void> saveString(String key, String value) async =>
      await _pref?.setString(key, value);
  String? getString(String key) => _pref?.getString(key);

  Future<void> saveBool(String key, bool value) async =>
      await _pref?.setBool(key, value);
  bool getBool(String key) => _pref?.getBool(key) ?? false;

  Future<void> saveInt(String key, int value) async =>
      await _pref?.setInt(key, value);
  int? getInt(String key) => _pref?.getInt(key);

  Future<void>? clear() => _pref?.clear();

  Future<void> saveDouble(String key, double value) async =>
      await _pref?.setDouble(key, value);
  double? getDouble(String key) => _pref?.getDouble(key);

  Future<void> saveStringList(String key, List<String> value) async =>
      await _pref?.setStringList(key, value);
  List<String>? getStringList(String key) => _pref?.getStringList(key);

  Future<void> remove(String key) async => await _pref?.remove(key);
  bool containsKey(String key) => _pref?.containsKey(key) ?? false;
}

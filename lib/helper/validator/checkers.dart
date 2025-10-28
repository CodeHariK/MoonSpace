import './validator.dart';

extension CheckString on String? {
  String? checkMin(int min) {
    if ((this?.length ?? 0) < min) {
      return 'minimum $min characters required';
    }

    return null;
  }

  String? checkMax(int max) {
    if ((this?.length ?? 0) > max) {
      return 'maximum $max characters allowed';
    }

    return null;
  }

  String? checkAlphanumeric() {
    final v = this ?? '';
    if (!isAlphanumeric(v)) {
      return 'only (a-z) (A-Z) (0-9) allowed';
    }
    return null;
  }
}

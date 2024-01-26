class LocalizationModel {
  static String getFlag(String code) {
    switch (code) {
      case 'id':
        return '${String.fromCharCode(0x1F1EE)}${String.fromCharCode(0x1F1E9)}';
      default:
        return '${String.fromCharCode(0x1F1FA)}${String.fromCharCode(0x1F1F8)}';
    }
  }
}

class SavedAppSettings {
  int maxSavedTraces;
  String language;
  String theme;

  SavedAppSettings(
      {required this.maxSavedTraces,
      required this.language,
      required this.theme});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["maxSavedTraces"] = maxSavedTraces;
    data["language"] = language;
    data["theme"] = theme;
    return data;
  }

  @override
  String toString() {
    return 'SavedAppSettings(maxSavedTraces: $maxSavedTraces, language: $language, theme: $theme)';
  }
}

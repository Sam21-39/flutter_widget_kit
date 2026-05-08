/// Sealed class representing supported widget sizes/families.
sealed class WidgetFamily {
  const WidgetFamily();

  /// Canonical sizes that map to both iOS and Android.
  static const WidgetFamily small = CanonicalWidgetFamily.small;
  static const WidgetFamily medium = CanonicalWidgetFamily.medium;
  static const WidgetFamily large = CanonicalWidgetFamily.large;
}

/// Universal widget families that map to platform-specific counterparts.
enum CanonicalWidgetFamily implements WidgetFamily {
  /// Maps to iOS systemSmall and Android 2x2.
  small,

  /// Maps to iOS systemMedium and Android 4x2.
  medium,

  /// Maps to iOS systemLarge and Android 4x4.
  large,
}

/// iOS-specific widget families.
sealed class IOSWidgetFamily extends WidgetFamily {
  const IOSWidgetFamily();

  static const WidgetFamily accessoryCircular = _IOSAccessoryCircular();
  static const WidgetFamily accessoryRectangular = _IOSAccessoryRectangular();
  static const WidgetFamily systemExtraLarge = _IOSSystemExtraLarge();
}

class _IOSAccessoryCircular extends IOSWidgetFamily {
  const _IOSAccessoryCircular();
}

class _IOSAccessoryRectangular extends IOSWidgetFamily {
  const _IOSAccessoryRectangular();
}

class _IOSSystemExtraLarge extends IOSWidgetFamily {
  const _IOSSystemExtraLarge();
}

/// Android-specific widget families (sizes in cells).
sealed class AndroidWidgetFamily extends WidgetFamily {
  const AndroidWidgetFamily();

  static WidgetFamily cells(int width, int height) => _AndroidCellSize(width, height);
}

class _AndroidCellSize extends AndroidWidgetFamily {
  final int width;
  final int height;
  const _AndroidCellSize(this.width, this.height);
}

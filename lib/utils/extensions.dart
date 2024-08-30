enum AppFlavorEnum {
  paid,
  free,
}

extension BaseEnvExten on String {
  String appFlavorName() {
    switch (this) {
      case 'free':
        return '';
      case 'paid':
        return 'Premium';
      default:
        return '';
    }
  }

  AppFlavorEnum appFlavor() {
    switch (this) {
      case 'free':
        return AppFlavorEnum.free;
      case 'paid':
        return AppFlavorEnum.paid;
      default:
        return AppFlavorEnum.free;
    }
  }
}

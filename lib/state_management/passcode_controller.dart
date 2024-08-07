class PasscodeController {
  String _passcode = '';

  void updatePasscode(String value, int index) {
    if (value.length == 1) {
      if (_passcode.length == index) {
        _passcode += value;
      } else {
        _passcode = _passcode.substring(0, index) + value + _passcode.substring(index + 1);
      }
    }
  }

  bool isPasscodeComplete() {
    return _passcode.length == 4;
  }

  String getPasscode() {
    return _passcode;
  }

  void clearPasscode() {
    _passcode = '';
  }
}

import 'package:flutter/material.dart';
import 'package:starman/main.dart';

class LanguageSwitcher extends StatefulWidget {
  @override
  State<LanguageSwitcher> createState() => _LanguageSwitcherState();
}

class _LanguageSwitcherState extends State<LanguageSwitcher> {
  bool _isEnglish = true;

  void _toggleLanguage(bool isEnglish) {
    setState(() {
      _isEnglish = isEnglish;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.grey[200],
      ),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () => _toggleLanguage(true),
                    child: Center(
                      child: Text(
                        'EN',
                        style: TextStyle(
                          color: _isEnglish ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _toggleLanguage(false),
                    child: Center(
                      child: Text(
                        'မြန်မာ',
                        style: TextStyle(
                          color: !_isEnglish ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 100),
            left: _isEnglish ? 0 : 50,
            top: 0,
            bottom: 0,
            child: Container(
              width: 40,
              decoration: BoxDecoration(
                color: AppColors.primaryColor, // Your primary color
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: Text(
                  _isEnglish ? 'EN' : 'မြန်မာ',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

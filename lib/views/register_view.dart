import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:starman/state_management/register_controller.dart';
import 'package:starman/widgets/language_button_widget.dart';
import 'package:starman/widgets/custom_textformfield_widget.dart';

class RegisterView extends StatelessWidget {
  final RegisterController _controller = RegisterController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(40, 10, 40, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'assets/logo.png',
                  height: 80,
                ),
              ),
              SizedBox(height: 10),
              LocaleText(
                'registration',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 23),

              LanguageButtonWidget(),

              SizedBox(height: 12),

              CustomTextFieldWidget(
                label: Locales.string(context, 'star_id'),
                icon: Icons.star,
                onChanged: _controller.updateStarID,
              ),

              ElevatedButton(
                onPressed: () {
                },
                child: LocaleText(
                  'register',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  elevation: 1,
                  minimumSize: Size(200, 40),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

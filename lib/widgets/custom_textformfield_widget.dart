import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final String label;
  final IconData icon;
  final Function(String) onChanged;
  final bool isAddressField;

  CustomTextFieldWidget({
    required this.label,
    required this.icon,
    required this.onChanged,
    this.isAddressField = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            label,
            style: TextStyle(
              color: Colors.black,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(height: 10),
        Container(
          height: isAddressField ? 80 : 48,
          width: MediaQuery.of(context).size.width / 1.21,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextFormField(
            onChanged: onChanged,
            maxLines: isAddressField ? 3 : 1,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: isAddressField ? 10 : 15,
              ),
              prefixIcon: Icon(
                icon,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

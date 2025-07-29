import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';


class NationalityPicker extends StatelessWidget {
  final Map<String, String> nationalityMap = {
  'KH': 'Cambodian',
  'TH': 'Thai',
  'MM': 'Burmese',
  'AF': 'Afghan',
  'AL': 'Albanian',
  'DZ': 'Algerian',
  'AS': 'American Samoan',
  'AD': 'Andorran',
  'AO': 'Angolan',
  'AI': 'Anguillan',
  // Add more here...
};

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showCountryPicker(
          context: context,
          showPhoneCode: false,
          onSelect: (Country country) {
            final nationality = nationalityMap[country.countryCode] ?? country.name;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('You selected:$nationality')),
            );
          },
          countryListTheme: CountryListThemeData(
            flagSize: 30,
            textStyle: TextStyle(fontSize: 16),
            bottomSheetHeight: 500,
            backgroundColor: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
        );
      },
      child: Text('Select Nationality'),
    );
  }
}

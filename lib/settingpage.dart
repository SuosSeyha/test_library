import 'package:flutter/material.dart';

class ProfileSettingsPage extends StatefulWidget {
  const ProfileSettingsPage({super.key});

  @override
  State<ProfileSettingsPage> createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
  // Sample data for dropdowns
  final Map<String, List<String>> cityDistricts = {
    'Phnom Penh': ['Chamkar Mon', 'Daun Penh', '7 Makara'],
    'Siem Reap': ['Siem Reap', 'Banteay Srei', 'Angkor Thom'],
    'Battambang': ['Battambang', 'Sangkat', 'Banann'],
  };

  final Map<String, List<String>> districtCommunes = {
    'Chamkar Mon': ['Tonle Bassac', 'Koh Pich', 'Srah Chak'],
    'Daun Penh': ['Srah Chak', 'Wat Phnom', 'Chey Chumneas'],
    '7 Makara': ['Orussey', 'Monorom', 'Veal Vong'],
    'Siem Reap': ['Sla Kram', 'Svay Dangkum', 'Nokor Thom'],
    'Banteay Srei': ['Khun Ream', 'Run Ta Ek', 'Trapeang Thom'],
    'Angkor Thom': ['Leang Dai', 'Peak Sneng', 'Srah Srang'],
    'Battambang': ['Svay Por', 'Prek Preah Sdach', 'Rottanak'],
    'Sangkat': ['Sangkat 1', 'Sangkat 2', 'Sangkat 3'],
    'Banann': ['Banann 1', 'Banann 2', 'Banann 3'],
  };

  String? selectedCity;
  String? selectedDistrict;
  String? selectedCommune;
  final TextEditingController streetController = TextEditingController();
  final TextEditingController houseController = TextEditingController();

  @override
  void dispose() {
    streetController.dispose();
    houseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // City Dropdown
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'City',
                      border: OutlineInputBorder(),
                    ),
                    value: selectedCity,
                    items: cityDistricts.keys
                        .map((city) => DropdownMenuItem(
                              value: city,
                              child: Text(city),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCity = value;
                        selectedDistrict = null; // Reset district
                        selectedCommune = null; // Reset commune
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16),
                // District Dropdown
                Expanded(
                  flex: 1,
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'District',
                      border: OutlineInputBorder(),
                    ),
                    value: selectedDistrict,
                    items: selectedCity == null
                        ? []
                        : cityDistricts[selectedCity]!
                            .map((district) => DropdownMenuItem(
                                  value: district,
                                  child: Text(district),
                                ))
                            .toList(),
                    onChanged: selectedCity == null
                        ? null
                        : (value) {
                            setState(() {
                              selectedDistrict = value;
                              selectedCommune = null; // Reset commune
                            });
                          },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),
            // Commune/Sangkat Dropdown
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Commune/Sangkat',
                border: OutlineInputBorder(),
              ),
              value: selectedCommune,
              items: selectedDistrict == null
                  ? []
                  : districtCommunes[selectedDistrict]!
                      .map((commune) => DropdownMenuItem(
                            value: commune,
                            child: Text(commune),
                          ))
                      .toList(),
              onChanged: selectedDistrict == null
                  ? null
                  : (value) {
                      setState(() {
                        selectedCommune = value;
                      });
                    },
            ),
            const SizedBox(height: 16),
            // Street No Input
            TextField(
              controller: streetController,
              decoration: const InputDecoration(
                labelText: 'Street No',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            // House No Input
            TextField(
              controller: houseController,
              decoration: const InputDecoration(
                labelText: 'House No',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle save action
                if (selectedCity != null &&
                    selectedDistrict != null &&
                    selectedCommune != null &&
                    streetController.text.isNotEmpty &&
                    houseController.text.isNotEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Saved: $selectedCity, $selectedDistrict, $selectedCommune, '
                        'Street: ${streetController.text}, House: ${houseController.text}',
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please fill all fields')),
                  );
                }
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: ProfileSettingsPage(),
  ));
}

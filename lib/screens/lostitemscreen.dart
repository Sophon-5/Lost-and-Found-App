import 'dart:io' show File;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'submittedscreen.dart';

class LostItemScreen extends StatefulWidget {
  const LostItemScreen({super.key});

  @override
  State<LostItemScreen> createState() => _LostItemScreenState();
}

class _LostItemScreenState extends State<LostItemScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  String? _selectedLocation;
  final List<String> _locations = <String>[
    'Campus',
    'Library',
    'Cafeteria',
    'Hostel',
    'Ground',
    'Other',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _contactController.dispose();
    _emailController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _imageFile = picked);
    }
  }

  void _removeImage() {
    setState(() => _imageFile = null);
  }

  Future<void> _pickDate() async {
    final DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 2),
      lastDate: DateTime(now.year + 2),
    );
    if (picked != null) {
      _dateController.text =
          '${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}';
      setState(() {});
    }
  }

  Future<void> _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      final String hh = picked.hour.toString().padLeft(2, '0');
      final String mm = picked.minute.toString().padLeft(2, '0');
      _timeController.text = '$hh:$mm';
      setState(() {});
    }
  }

  OutlineInputBorder _inputBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: color, width: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        title: const Text('FindMyStuff'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                const Text('Item Title', style: TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    hintText: 'e.g., Black Wallet',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                    border: _inputBorder(Colors.grey.shade300),
                    enabledBorder: _inputBorder(Colors.grey.shade300),
                    focusedBorder: _inputBorder(Colors.grey.shade500),
                  ),
                  validator: (value) => (value == null || value.trim().isEmpty) ? 'Title is required' : null,
                ),

                const SizedBox(height: 16),
                const Text('Description', style: TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: 'Describe the item in detail',
                    alignLabelWithHint: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                    border: _inputBorder(Colors.grey.shade300),
                    enabledBorder: _inputBorder(Colors.grey.shade300),
                    focusedBorder: _inputBorder(Colors.grey.shade500),
                  ),
                ),

                const SizedBox(height: 16),
                const Text('Location', style: TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _locationController,
                  decoration: InputDecoration(
                    hintText: 'Enter location',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                    border: _inputBorder(Colors.grey.shade300),
                    enabledBorder: _inputBorder(Colors.grey.shade300),
                    focusedBorder: _inputBorder(Colors.grey.shade500),
                  ),
                ),

                const SizedBox(height: 16),
                const Text('Photo (optional)', style: TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_imageFile != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: kIsWeb
                            ? Image.network(
                                _imageFile!.path,
                                height: 160,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              )
                            : Image.file(
                                File(_imageFile!.path),
                                height: 160,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                      )
                    else
                      InkWell(
                        onTap: _pickImage,
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          height: 120,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300, width: 1),
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey.shade50,
                          ),
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.upload_outlined,
                            color: Colors.grey,
                            size: 36,
                          ),
                        ),
                      ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        ElevatedButton.icon(
                          onPressed: _pickImage,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black87,
                            side: BorderSide(color: Colors.grey.shade300, width: 1),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          icon: const Icon(Icons.upload_outlined),
                          label: const Text('Upload photo'),
                        ),
                        const SizedBox(width: 12),
                        if (_imageFile != null)
                          OutlinedButton.icon(
                            onPressed: _removeImage,
                            icon: const Icon(Icons.delete_outline),
                            label: const Text('Remove'),
                          ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 16),
                const Text('Contact Information', style: TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _contactController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: 'XXXX-XXX-XXXX',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                    border: _inputBorder(Colors.grey.shade300),
                    enabledBorder: _inputBorder(Colors.grey.shade300),
                    focusedBorder: _inputBorder(Colors.grey.shade500),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) return 'Contact number is required';
                    final String digits = value.replaceAll(RegExp(r'[^0-9]'), '');
                    return digits.length < 8 ? 'Enter a valid contact number' : null;
                  },
                ),

                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Date', style: TextStyle(fontWeight: FontWeight.w600)),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _dateController,
                            readOnly: true,
                            onTap: _pickDate,
                            decoration: InputDecoration(
                              hintText: 'XX-XX-XXXX',
                              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                              border: _inputBorder(Colors.grey.shade300),
                              enabledBorder: _inputBorder(Colors.grey.shade300),
                              focusedBorder: _inputBorder(Colors.grey.shade500),
                            ),
                            validator: (value) => (value == null || value.trim().isEmpty) ? 'Date is required' : null,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Time of Lost', style: TextStyle(fontWeight: FontWeight.w600)),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _timeController,
                            readOnly: true,
                            onTap: _pickTime,
                            decoration: InputDecoration(
                              hintText: '00:00',
                              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                              border: _inputBorder(Colors.grey.shade300),
                              enabledBorder: _inputBorder(Colors.grey.shade300),
                              focusedBorder: _inputBorder(Colors.grey.shade500),
                            ),
                            validator: (value) => (value == null || value.trim().isEmpty) ? 'Time is required' : null,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),
                const Text('Email Address', style: TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'xyz@gmail.com',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                    border: _inputBorder(Colors.grey.shade300),
                    enabledBorder: _inputBorder(Colors.grey.shade300),
                    focusedBorder: _inputBorder(Colors.grey.shade500),
                  ),
                ),

                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE74C3C),
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const SubmittedScreen()),
                        );
                      }
                    },
                    child: const Text('Submit form'),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

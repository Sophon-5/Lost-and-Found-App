import 'package:flutter/material.dart';
import 'submittedscreen.dart';
import '../data/found_item_repository.dart';
import '../models/found_item.dart';

class FoundItemScreen extends StatefulWidget {
  const FoundItemScreen({super.key});

  static const String routeName = '/found-item';

  /// Call this from any button to open the Found Item form
  static Future<T?> navigateToFoundItem<T>(BuildContext context) {
    return Navigator.of(context).push<T>(
      MaterialPageRoute(builder: (_) => const FoundItemScreen()),
    );
  }

  @override
  State<FoundItemScreen> createState() => _FoundItemScreenState();
}

class _FoundItemScreenState extends State<FoundItemScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _storageController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();


  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _storageController.dispose();
    _locationController.dispose();
    _emailController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
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
        title: const Text('Report Found Item'),
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
                const Text('Temporary Storage', style: TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _storageController,
                  decoration: InputDecoration(
                    hintText: 'e.g., Kept with Security Office',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                    border: _inputBorder(Colors.grey.shade300),
                    enabledBorder: _inputBorder(Colors.grey.shade300),
                    focusedBorder: _inputBorder(Colors.grey.shade500),
                  ),
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
                          const Text('Time of Found', style: TextStyle(fontWeight: FontWeight.w600)),
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
                      backgroundColor: const Color(0xFF6C63FF),
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        final FoundItem item = FoundItem(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          title: _titleController.text.trim(),
                          description: _descriptionController.text.trim(),
                          location: _locationController.text.trim(),
                          storage: _storageController.text.trim(),
                          email: _emailController.text.trim(),
                          date: _dateController.text.trim(),
                          time: _timeController.text.trim(),
                          createdAt: DateTime.now(),
                        );
                        FoundItemRepository.instance.add(item).then((_) {
                          Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const SubmittedScreen()),
                          );
                        });
                      }
                    },
                    child: const Text('Submit Found Item'),
                  ),
                ),
                const SizedBox(height: 12),
                Center(
                  child: TextButton(
                    onPressed: () => Navigator.of(context).maybePop(),
                    child: const Text('Cancel'),
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



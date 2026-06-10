import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const ImageHandlingApp());
}

class ImageHandlingApp extends StatelessWidget {
  const ImageHandlingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Image Handling',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ImageHandlingHomePage(),
    );
  }
}

class ImageHandlingHomePage extends StatefulWidget {
  const ImageHandlingHomePage({super.key});

  @override
  State<ImageHandlingHomePage> createState() => _ImageHandlingHomePageState();
}

class _ImageHandlingHomePageState extends State<ImageHandlingHomePage> {
  final ImagePicker _picker = ImagePicker();
  XFile? _pickedImage;
  bool _isUploading = false;
  bool _applyFilter = false;
  BoxFit _selectedFit = BoxFit.cover;

  static const List<String> _networkImages = [
    'https://images.unsplash.com/photo-1564865877675-04bba2c7c4ae?auto=format&fit=crop&w=900&q=80',
    'https://images.unsplash.com/photo-1547721064-da6cfb341d50?auto=format&fit=crop&w=900&q=80',
    'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=900&q=80',
  ];

  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(
      source: source,
      maxWidth: 1600,
      maxHeight: 1600,
      imageQuality: 85,
    );

    if (image == null) {
      return;
    }

    setState(() {
      _pickedImage = image;
      _applyFilter = false;
    });
  }

  void _clearPickedImage() {
    setState(() {
      _pickedImage = null;
      _applyFilter = false;
    });
  }

  Future<void> _simulateUpload() async {
    if (_pickedImage == null) {
      return;
    }

    setState(() {
      _isUploading = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isUploading = false;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Image ready to upload!')),
      );
    }
  }

  Widget _buildBoxFitSelector() {
    final fits = {
      'cover': BoxFit.cover,
      'contain': BoxFit.contain,
      'fill': BoxFit.fill,
      'fitWidth': BoxFit.fitWidth,
      'fitHeight': BoxFit.fitHeight,
    };

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: fits.entries.map((entry) {
        final selected = _selectedFit == entry.value;
        return ChoiceChip(
          label: Text(entry.key),
          selected: selected,
          onSelected: (_) => setState(() {
            _selectedFit = entry.value;
          }),
        );
      }).toList(),
    );
  }

  Widget _buildAssetGallery() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('Asset Images', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        SizedBox(
          height: 180,
          child: Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    'assets/images/asset_photo_1.png',
                    fit: _selectedFit,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    'assets/images/asset_photo_2.png',
                    fit: _selectedFit,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNetworkGallery() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('Cached Network Images', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        SizedBox(
          height: 190,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _networkImages.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: CachedNetworkImage(
                  imageUrl: _networkImages[index],
                  width: 260,
                  height: 190,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: Colors.grey.shade200,
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey.shade200,
                    child: const Center(child: Icon(Icons.broken_image, size: 48)),
                  ),
                  fadeInDuration: const Duration(milliseconds: 600),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPickedImagePreview() {
    if (_pickedImage == null) {
      return const Center(child: Text('No image selected yet.'));
    }

    final imageWidget = Image.file(
      File(_pickedImage!.path),
      fit: _selectedFit,
      width: double.infinity,
      height: double.infinity,
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: ColorFiltered(
        colorFilter: _applyFilter
            ? const ColorFilter.mode(Color.fromRGBO(255, 192, 0, 0.35), BlendMode.modulate)
            : const ColorFilter.mode(Colors.transparent, BlendMode.multiply),
        child: InteractiveViewer(
          clipBehavior: Clip.none,
          panEnabled: true,
          minScale: 0.8,
          maxScale: 4.0,
          child: SizedBox(
            width: double.infinity,
            height: 260,
            child: imageWidget,
          ),
        ),
      ),
    );
  }

  Widget _buildPickerControls() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('Pick Image', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.photo_library),
                label: const Text('Gallery'),
                onPressed: () => _pickImage(ImageSource.gallery),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.camera_alt),
                label: const Text('Camera'),
                onPressed: () => _pickImage(ImageSource.camera),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: _pickedImage == null ? null : _simulateUpload,
                child: _isUploading ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)) : const Text('Upload Preview'),
              ),
            ),
            const SizedBox(width: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey.shade800),
              onPressed: _pickedImage == null ? null : _clearPickedImage,
              child: const Icon(Icons.clear),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            const Text('Filter:'),
            const SizedBox(width: 12),
            Switch(
              value: _applyFilter,
              onChanged: (value) => setState(() {
                _applyFilter = value;
              }),
            ),
            const Expanded(child: Text('Warm color filter preview')),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Image Handling'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: ListView(
            children: [
              const Text('Learning image handling with assets, network caching, and picker flows.', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              const SizedBox(height: 16),
              _buildBoxFitSelector(),
              const SizedBox(height: 16),
              _buildAssetGallery(),
              const SizedBox(height: 16),
              _buildNetworkGallery(),
              const SizedBox(height: 16),
              const Text('Picked Image Preview', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              _buildPickedImagePreview(),
              const SizedBox(height: 12),
              _buildPickerControls(),
              const SizedBox(height: 24),
              const Text('Tip', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text('Use the gallery or camera buttons to select an image. Pinch to zoom the picked image and switch between BoxFit modes for resizing behavior.'),
            ],
          ),
        ),
      ),
    );
  }
}

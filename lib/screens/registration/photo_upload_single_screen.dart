import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'widgets/custom_button.dart';

class PhotoUploadSingleScreen extends StatefulWidget {
  const PhotoUploadSingleScreen({Key? key}) : super(key: key);

  @override
  _PhotoUploadSingleScreenState createState() => _PhotoUploadSingleScreenState();
}

class _PhotoUploadSingleScreenState extends State<PhotoUploadSingleScreen> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  final Color neonBlue = const Color(0xFF00E5FF);
  final Color luxyGold = const Color(0xFFD4AF37);

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      Navigator.pop(context);
    }
  }

  void _showImagePickerOptions() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: const Text('Añadir Foto', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        message: const Text('Elige una de las siguientes opciones para tu perfil de lujo.'),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () => _pickImage(ImageSource.camera),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(CupertinoIcons.camera, color: Colors.blue),
                SizedBox(width: 10),
                Text('Tomar Foto'),
              ],
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () => _pickImage(ImageSource.gallery),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(CupertinoIcons.photo, color: Colors.blue),
                SizedBox(width: 10),
                Text('Galería de Fotos'),
              ],
            ),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDestructiveAction: true,
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Row(
                        children: List.generate(5, (index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: index == 4 ? Colors.white : Colors.grey[900],
                          ),
                        )),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.monetization_on, color: luxyGold, size: 16),
                            const SizedBox(width: 5),
                            const Text("6", style: TextStyle(color: Colors.white, fontSize: 12)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Show Your Best Self!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Sube tu foto favorita que demuestre quién eres. ¡La primera impresión cuenta!',
                        style: TextStyle(color: Colors.white54, fontSize: 15, height: 1.4),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Center(
                    child: GestureDetector(
                      onTap: _showImagePickerOptions,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: _image != null ? neonBlue.withOpacity(0.5) : Colors.white10,
                            width: 1.5,
                          ),
                        ),
                        child: _image != null
                            ? Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.file(_image!, fit: BoxFit.cover, width: double.infinity, height: double.infinity),
                                  ),
                                  Positioned(
                                    bottom: 10,
                                    left: 10,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                        color: Colors.black54,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Text('Main Photo', style: TextStyle(color: Colors.white, fontSize: 12)),
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(CupertinoIcons.camera_fill, size: 50, color: Colors.grey[800]),
                                  const SizedBox(height: 15),
                                  const Text('Añadir Foto', style: TextStyle(color: Colors.grey)),
                                ],
                              ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildInfoIcon(Icons.high_quality, "HD Required"),
                    _buildInfoIcon(Icons.face_retouching_natural, "Clear Face"),
                    _buildInfoIcon(Icons.local_cafe, "Show Lifestyle"),
                  ],
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Column(
                    children: [
                      const Text(
                        'Completa para ganar 4 Monedas',
                        style: TextStyle(color: Colors.white30, fontSize: 13),
                      ),
                      const SizedBox(height: 15),
                      LuxyButton(
                        text: "Siguiente",
                        isActive: _image != null,
                        onPressed: () {
                          Navigator.pushNamed(context, '/photos_multi', arguments: _image);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoIcon(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.grey[600], size: 24),
        ),
        const SizedBox(height: 8),
        Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 11)),
      ],
    );
  }
}

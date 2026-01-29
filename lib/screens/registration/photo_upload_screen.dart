import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'widgets/custom_button.dart';

class PhotoUploadScreen extends StatefulWidget {
  const PhotoUploadScreen({Key? key}) : super(key: key);

  @override
  _PhotoUploadScreenState createState() => _PhotoUploadScreenState();
}

class _PhotoUploadScreenState extends State<PhotoUploadScreen> {
  List<File?> _photos = List.generate(6, (_) => null);
  final ImagePicker _picker = ImagePicker();
  final Color neonBlue = const Color(0xFF00E5FF);
  final Color luxyGold = const Color(0xFFD4AF37);

  Future<void> _pickImage(int index, ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _photos[index] = File(pickedFile.path);
      });
      Navigator.pop(context);
    }
  }

  void _showImagePickerOptions(int index) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: const Text('Añadir Foto', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        message: const Text('Las fotos HD y con rostro despejado obtienen más matches.'),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () => _pickImage(index, ImageSource.camera),
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
            onPressed: () => _pickImage(index, ImageSource.gallery),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(CupertinoIcons.photo, color: Colors.blue),
                SizedBox(width: 10),
                Text('Galería de Fotos'),
              ],
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(context),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.camera_alt_outlined, color: Colors.pink),
                SizedBox(width: 10),
                Text('Subir desde Instagram'),
              ],
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(context),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.facebook, color: Colors.blueAccent),
                SizedBox(width: 10),
                Text('Subir desde Facebook'),
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

  void _showSkipWarning() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [luxyGold.withOpacity(0.3), Colors.white],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: const Text(
                  'Wait! Don\'t Skip This',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'More photos can really boost your chances and help you get more likes. Give it a try - it\'s worth it!',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54, fontSize: 16),
                ),
              ),
              const Divider(height: 1),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel', style: TextStyle(color: Colors.grey, fontSize: 16)),
                    ),
                  ),
                  Container(width: 1, height: 50, color: Colors.grey[200]),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/verification_pending');
                      },
                      child: Text('Skip', style: TextStyle(color: luxyGold, fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: Column(
          children: [
            // Header con Linea de Progreso Curva
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: _showSkipWarning,
                      child: const Text(
                        'Skip',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ),
                  ),
                  Container(
                    height: 100,
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 20),
                    child: CustomPaint(
                      painter: CurvedProgressPainter(),
                    ),
                  ),
                  const Positioned(
                    left: 20,
                    top: 25,
                    child: Text(
                      'You\'re here',
                      style: TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                  ),
                ],
              ),
            ),

            // Título
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Great start! Your photos beat 10% of new users.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Keep going – more photos can bring more likes!',
                    style: TextStyle(color: Colors.white54, fontSize: 14),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Grid de Fotos
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GridView.builder(
                  itemCount: 6,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return _buildPhotoSlot(index);
                  },
                ),
              ),
            ),

            // Footer
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Column(
                children: [
                  const Text(
                    'Complete for 5 Coins',
                    style: TextStyle(color: Colors.white30, fontSize: 13),
                  ),
                  const SizedBox(height: 15),
                  LuxyButton(
                    text: "Next",
                    isActive: _photos[0] != null,
                    onPressed: () => Navigator.pushNamed(context, '/verification_pending'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhotoSlot(int index) {
    return GestureDetector(
      onTap: () => _showImagePickerOptions(index),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _photos[index] != null ? neonBlue.withOpacity(0.5) : Colors.transparent,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (_photos[index] != null)
                Image.file(_photos[index]!, fit: BoxFit.cover)
              else
                const Center(
                  child: Icon(Icons.add, color: Colors.grey, size: 30),
                ),
              if (index == 0)
                Positioned(
                  bottom: 5,
                  left: 5,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'Main Photo',
                      style: TextStyle(color: Colors.white, fontSize: 8),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class CurvedProgressPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey[800]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final path = Path();
    path.moveTo(0, size.height * 0.8);
    path.quadraticBezierTo(
      size.width * 0.5,
      size.height * 0.4,
      size.width,
      size.height * 0.1,
    );

    canvas.drawPath(path, paint);

    // Dibujar la parte activa
    final activePaint = Paint()
      ..color = const Color(0xFFD4AF37)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final activePath = Path();
    activePath.moveTo(0, size.height * 0.8);
    activePath.quadraticBezierTo(
      size.width * 0.1,
      size.height * 0.75,
      size.width * 0.2,
      size.height * 0.65,
    );
    canvas.drawPath(activePath, activePaint);

    // Dibujar los puntos
    final dotPaint = Paint()..color = Colors.grey[800]!;
    final activeDotPaint = Paint()..color = const Color(0xFFD4AF37);

    // Punto 1 (Activo)
    canvas.drawCircle(Offset(0, size.height * 0.8), 4, activeDotPaint);
    // Puntos restantes
    canvas.drawCircle(Offset(size.width * 0.35, size.height * 0.55), 4, dotPaint);
    canvas.drawCircle(Offset(size.width * 0.65, size.height * 0.35), 4, dotPaint);
    canvas.drawCircle(Offset(size.width, size.height * 0.1), 4, dotPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

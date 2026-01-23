import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'widgets/custom_button.dart';

class PhotoUploadMultiScreen extends StatefulWidget {
  final File? initialPhoto;
  const PhotoUploadMultiScreen({Key? key, this.initialPhoto}) : super(key: key);

  @override
  _PhotoUploadMultiScreenState createState() => _PhotoUploadMultiScreenState();
}

class _PhotoUploadMultiScreenState extends State<PhotoUploadMultiScreen> {
  late List<File?> _photos;
  final ImagePicker _picker = ImagePicker();
  final Color neonBlue = const Color(0xFF00E5FF);
  final Color luxyGold = const Color(0xFFD4AF37);

  @override
  void initState() {
    super.initState();
    _photos = List.generate(6, (index) => index == 0 ? widget.initialPhoto : null);
  }

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
                  '¡Espera! No te saltes esto',
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
                  'Subir más fotos realmente aumenta tus posibilidades y te ayuda a conseguir más likes. ¡Inténtalo, vale la pena!',
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
                      child: const Text('Cancelar', style: TextStyle(color: Colors.grey, fontSize: 16)),
                    ),
                  ),
                  Container(width: 1, height: 50, color: Colors.grey[200]),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/profile_created', arguments: _photos[0]);
                      },
                      child: Text('Saltar', style: TextStyle(color: luxyGold, fontSize: 16, fontWeight: FontWeight.bold)),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: _showSkipWarning,
                      child: const Text(
                        'Saltar',
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
                      'Estás aquí',
                      style: TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '¡Gran comienzo! Tus fotos superan al 10% de los nuevos usuarios.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Sigue así: ¡más fotos pueden traer más likes!',
                    style: TextStyle(color: Colors.white54, fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Column(
                children: [
                  const Text(
                    'Completa para ganar 5 Monedas',
                    style: TextStyle(color: Colors.white30, fontSize: 13),
                  ),
                  const SizedBox(height: 15),
                  LuxyButton(
                    text: "Siguiente",
                    isActive: _photos[0] != null,
                    onPressed: () {
                      Navigator.pushNamed(context, '/profile_created', arguments: _photos[0]);
                    },
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
                      'Foto Principal',
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

    final dotPaint = Paint()..color = Colors.grey[800]!;
    final activeDotPaint = Paint()..color = const Color(0xFFD4AF37);

    canvas.drawCircle(Offset(0, size.height * 0.8), 4, activeDotPaint);
    canvas.drawCircle(Offset(size.width * 0.35, size.height * 0.55), 4, dotPaint);
    canvas.drawCircle(Offset(size.width * 0.65, size.height * 0.35), 4, dotPaint);
    canvas.drawCircle(Offset(size.width, size.height * 0.1), 4, dotPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

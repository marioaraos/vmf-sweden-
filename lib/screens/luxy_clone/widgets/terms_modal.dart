import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TermsAndConditionsModal extends StatefulWidget {
  const TermsAndConditionsModal({Key? key}) : super(key: key);

  @override
  _TermsAndConditionsModalState createState() => _TermsAndConditionsModalState();
}

class _TermsAndConditionsModalState extends State<TermsAndConditionsModal> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _totalPages = 6;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _launchURL() async {
    final Uri url = Uri.parse('https://www.tusitio.com/legal');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: Colors.black.withOpacity(0.95),
      child: Container(
        padding: const EdgeInsets.all(24),
        height: 580,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFD4AF37), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _currentPage < 3 ? "Términos de Servicio" : "Política de Privacidad",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFFD4AF37),
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: [
                  _buildPage(
                    "Información Legal del Operador\n\n"
                    "Responsable: Marjo Alexandro Araos\n"
                    "Postadress: c/o ELOHIM INTERNATIONAL, Oxholmsgränds 3, 127 48 Skärholmen\n\n"
                    "Juridiskt namn: SHALOM INTERNATIONAL\n"
                    "Organisationsnummer: 802441-9650\n"
                    "Registreringsdatum: 2008-06-26\n"
                    "Bolagsform: Ideell förening\n"
                    "Status: Registrerad\n"
                    "Registrerad för: Moms, F-skatt, Arbetsgivaravgift",
                    false,
                  ),
                  _buildPage(
                    "Términos de Servicio (Uso y Conducta)\n\n"
                    "1. Aceptación: Al registrarte en VMF Lux, declaras ser mayor de edad y aceptas nuestras normas de exclusividad.\n"
                    "2. Conducta: Se prohíbe cualquier comportamiento abusivo, discriminatorio o fraudulento.\n"
                    "3. Propiedad: Todo el contenido de la plataforma es propiedad de SHALOM INTERNATIONAL.",
                    false,
                  ),
                  _buildPage(
                    "Política de Privacidad - Datos que Recopilamos\n\n"
                    "Recopilamos la información que nos proporcionas directamente:\n"
                    "• Nombre y datos de contacto.\n"
                    "• Fecha de nacimiento y género.\n"
                    "• Fotografías y preferencias de perfil.\n"
                    "• Datos de ubicación para mejorar el emparejamiento.",
                    false,
                  ),
                  _buildPage(
                    "Uso de la Información\n\n"
                    "Utilizamos tus datos bajo la responsabilidad de Marjo Alexandro Araos para:\n"
                    "• Crear y gestionar tu cuenta de usuario.\n"
                    "• Personalizar tu experiencia y mostrarte perfiles relevantes.\n"
                    "• Mantener la seguridad y verificar la autenticidad de los miembros.",
                    false,
                  ),
                  _buildPage(
                    "Seguridad y Compartición de Datos\n\n"
                    "• Tus datos están protegidos mediante encriptación SSL.\n"
                    "• No vendemos ni alquilamos tu información personal a terceros con fines publicitarios.\n"
                    "• Solo compartimos datos si es legalmente requerido por las autoridades suecas.",
                    false,
                  ),
                  _buildPage(
                    "Tus Derechos Legales\n\n"
                    "Tienes derecho a acceder, rectificar o eliminar tus datos en cualquier momento.\n"
                    "Para cualquier consulta legal sobre tus datos, puedes dirigirte a SHALOM INTERNATIONAL en la dirección registrada en Skärholmen.",
                    true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_currentPage > 0)
                  TextButton(
                    onPressed: () {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    },
                    child: const Text("Anterior", style: TextStyle(color: Colors.white70)),
                  )
                else
                  const SizedBox(width: 80),
                Row(
                  children: List.generate(_totalPages, (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentPage == index ? const Color(0xFFD4AF37) : Colors.grey,
                        ),
                      )),
                ),
                if (_currentPage < _totalPages - 1)
                  TextButton(
                    onPressed: () {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    },
                    child: const Text("Siguiente", style: TextStyle(color: Color(0xFFD4AF37))),
                  )
                else
                  const SizedBox(width: 80),
              ],
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD4AF37),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Aceptar",
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(String text, bool isLastPage) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: const TextStyle(fontSize: 14, color: Colors.white, height: 1.5),
          ),
          const SizedBox(height: 20),
          if (isLastPage)
            GestureDetector(
              onTap: _launchURL,
              child: const Text(
                "Ver legal completo",
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFFD4AF37),
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

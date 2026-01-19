import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdvancedFiltersModal extends StatefulWidget {
  const AdvancedFiltersModal({Key? key}) : super(key: key);

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AdvancedFiltersModal(),
    );
  }

  @override
  _AdvancedFiltersModalState createState() => _AdvancedFiltersModalState();
}

class _AdvancedFiltersModalState extends State<AdvancedFiltersModal> {
  RangeValues _ageRange = const RangeValues(25, 45);
  double _distance = 50;
  String _selectedIncome = 'Any';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: Color(0xFF121212),
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(2)),
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'ADVANCED FILTERS',
                style: GoogleFonts.inter(
                  color: const Color(0xFFD4AF37),
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Reset', style: TextStyle(color: Colors.white54, fontSize: 12)),
              ),
            ],
          ),
          const SizedBox(height: 30),
          _buildFilterLabel('Age Range', '${_ageRange.start.round()} - ${_ageRange.end.round()}');
          RangeSlider(
            values: _ageRange,
            min: 18,
            max: 80,
            activeColor: const Color(0xFFD4AF37),
            inactiveColor: Colors.white10,
            onChanged: (values) => setState(() => _ageRange = values),
          ),
          const SizedBox(height: 24),
          _buildFilterLabel('Maximum Distance', '${_distance.round()} km');
          Slider(
            value: _distance,
            min: 1,
            max: 200,
            activeColor: const Color(0xFFD4AF37),
            inactiveColor: Colors.white10,
            onChanged: (val) => setState(() => _distance = val),
          ),
          const SizedBox(height: 24),
          _buildFilterLabel('Verified Income Tier', _selectedIncome),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            children: ['Any', '250k+', '500k+', '1M+'].map((tier) {
              final isSelected = _selectedIncome == tier;
              return GestureDetector(
                onTap: () => setState(() => _selectedIncome = tier),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFFD4AF37) : Colors.transparent,
                    border: Border.all(color: isSelected ? const Color(0xFFD4AF37) : Colors.white10),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    tier,
                    style: TextStyle(
                      color: isSelected ? Colors.black : Colors.white,
                      fontSize: 12,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD4AF37),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: Text(
                'APPLY FILTERS',
                style: GoogleFonts.inter(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildFilterLabel(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: GoogleFonts.inter(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
        Text(value, style: GoogleFonts.inter(color: const Color(0xFFD4AF37), fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }
}

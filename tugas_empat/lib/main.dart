import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jasa Freelance & Layanan Digital',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E88E5),
        ),
        useMaterial3: true,
      ),
      home: const BerandaPage(),
    );
  }
}

class PenyediaJasa {
  final String nama;
  final String profesi;
  final String harga;
  final String bio;
  final List<String> keahlian;
  final IconData icon;

  const PenyediaJasa({
    required this.nama,
    required this.profesi,
    required this.harga,
    required this.bio,
    required this.keahlian,
    required this.icon,
  });
}

class BerandaPage extends StatelessWidget {
  const BerandaPage({super.key});

  final List<PenyediaJasa> daftarJasa = const [
    PenyediaJasa(
      nama: 'Harun Yahya',
      profesi: 'Mobile App Developer (Flutter)',
      harga: 'Rp 3.500.000 / proyek',
      bio:
          'Spesialis pembuatan aplikasi mobile Android & iOS menggunakan Flutter. Berpengalaman dalam integrasi REST API, database lokal, dan publikasi aplikasi.',
      keahlian: ['Flutter & Dart', 'Integrasi API', 'Firebase Setup'],
      icon: Icons.developer_mode,
    ),
    PenyediaJasa(
      nama: 'Yahya Yahya',
      profesi: 'UI/UX Designer',
      harga: 'Rp 1.500.000 / proyek',
      bio:
          'Menyediakan jasa desain antarmuka aplikasi dan website modern. Berfokus pada kemudahan interaksi pengguna (UX) dan desain visual yang elegan (UI).',
      keahlian: ['Figma Design', 'Wireframing & Prototyping', 'Design System'],
      icon: Icons.design_services,
    ),
    PenyediaJasa(
      nama: 'Harun Harun',
      profesi: 'Backend & Cloud Engineer',
      harga: 'Rp 4.000.000 / proyek',
      bio:
          'Melayani pengembangan RESTful API berkinerja tinggi, manajemen database PostgreSQL/MySQL, serta konfigurasi server cloud & deployment.',
      keahlian: ['REST API Architecture', 'Database Optimization', 'Cloud Server Setup'],
      icon: Icons.storage,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Daftar Penyedia Jasa',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        itemCount: daftarJasa.length,
        itemBuilder: (context, index) {
          final jasa = daftarJasa[index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              leading: CircleAvatar(
                radius: 26,
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                child: Icon(
                  jasa.icon,
                  size: 28,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              title: Text(
                jasa.nama,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(
                    jasa.profesi,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    jasa.harga,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailProfilPage(jasa: jasa),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class DetailProfilPage extends StatefulWidget {
  final PenyediaJasa jasa;

  const DetailProfilPage({super.key, required this.jasa});

  @override
  State<DetailProfilPage> createState() => _DetailProfilPageState();
}

class _DetailProfilPageState extends State<DetailProfilPage> {
  bool _isFollowing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Profil Jasa',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  widget.jasa.icon,
                  size: 80,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.jasa.nama,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                widget.jasa.profesi,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F4FD),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFFBCE0FD),
                    width: 1.2,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.info_outline, size: 20, color: Color(0xFF1E88E5)),
                        SizedBox(width: 8),
                        Text(
                          'Bio & Penawaran Layanan',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 18),
                    Text(
                      widget.jasa.bio,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'Estimasi Biaya: ${widget.jasa.harga}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1565C0),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Keahlian Utama:',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      children: widget.jasa.keahlian.map((item) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: const Color(0xFFBCE0FD),
                            ),
                          ),
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF1565C0),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _isFollowing = !_isFollowing;
                  });
                },
                icon: Icon(
                  _isFollowing ? Icons.check_circle : Icons.person_add,
                  color: Colors.white,
                ),
                label: Text(
                  _isFollowing ? 'Following' : 'Follow',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      _isFollowing ? Colors.teal : const Color(0xFF1E88E5),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 36,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  elevation: 3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

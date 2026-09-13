import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

// Konfigurasi Base URL API Backend
class AppConfig {
  /// Base URL endpoint API.
  /// - Android Emulator: 'http://10.0.2.2:3000'
  /// - Web / Windows Desktop: 'http://localhost:3000'
  /// - Real Device (HP Fisik): Ubah sesuai IP LAN Laptop (misal 'http://192.168.1.10:3000')
  static String get baseUrl {
    if (kIsWeb) {
      return 'http://localhost:3000';
    }
    return defaultTargetPlatform == TargetPlatform.android
        ? 'http://10.0.2.2:3000'
        : 'http://localhost:3000';
  }
}

// Model PenyediaJasa yang dipetakan dari database MySQL
class PenyediaJasa {
  final int id;
  final String nama;
  final String profesi;
  final String harga;
  final String bio;
  final List<String> keahlian;
  final IconData icon;

  const PenyediaJasa({
    required this.id,
    required this.nama,
    required this.profesi,
    required this.harga,
    required this.bio,
    required this.keahlian,
    required this.icon,
  });

  factory PenyediaJasa.fromJson(Map<String, dynamic> json) {
    List<String> listKeahlian = [];
    if (json['keahlian'] is List) {
      listKeahlian = (json['keahlian'] as List)
          .map((item) => item.toString())
          .toList();
    } else if (json['keahlian'] is String) {
      try {
        final parsed = jsonDecode(json['keahlian'] as String);
        if (parsed is List) {
          listKeahlian = parsed.map((item) => item.toString()).toList();
        } else {
          listKeahlian = [json['keahlian'].toString()];
        }
      } catch (_) {
        listKeahlian = (json['keahlian'] as String)
            .split(',')
            .map((s) => s.trim())
            .toList();
      }
    }

    return PenyediaJasa(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()) ?? 0,
      nama: json['nama'] ?? '',
      profesi: json['profesi'] ?? '',
      harga: json['harga'] ?? '',
      bio: json['bio'] ?? '',
      keahlian: listKeahlian,
      icon: _parseIcon(json['icon']?.toString()),
    );
  }

  static IconData _parseIcon(String? iconName) {
    switch (iconName?.toLowerCase().trim()) {
      case 'developer_mode':
        return Icons.developer_mode;
      case 'design_services':
        return Icons.design_services;
      case 'storage':
        return Icons.storage;
      case 'code':
        return Icons.code;
      case 'security':
        return Icons.security;
      case 'web':
        return Icons.web;
      case 'phone_android':
        return Icons.phone_android;
      case 'analytics':
        return Icons.analytics;
      case 'cloud':
        return Icons.cloud;
      default:
        return Icons.work_outline;
    }
  }
}

// Service untuk mengambil data dari backend REST API
class ApiService {
  static Future<List<PenyediaJasa>> getPenyediaJasa() async {
    final uri = Uri.parse('${AppConfig.baseUrl}/api/penyedia-jasa');

    try {
      final response = await http
          .get(uri)
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonBody = jsonDecode(response.body);
        if (jsonBody['status'] == true && jsonBody['data'] is List) {
          final List rawList = jsonBody['data'];
          return rawList.map((item) => PenyediaJasa.fromJson(item)).toList();
        } else {
          throw Exception('Format respons API tidak valid.');
        }
      } else {
        throw Exception(
          'Gagal memuat data dari server (HTTP ${response.statusCode})',
        );
      }
    } catch (e) {
      throw Exception('Tidak dapat terhubung ke server backend ($e)');
    }
  }
}

class BerandaPage extends StatefulWidget {
  const BerandaPage({super.key});

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  late Future<List<PenyediaJasa>> _futureJasa;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    setState(() {
      _futureJasa = ApiService.getPenyediaJasa();
    });
  }

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
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Segarkan Data',
            onPressed: _loadData,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _loadData();
          await _futureJasa;
        },
        child: FutureBuilder<List<PenyediaJasa>>(
          future: _futureJasa,
          builder: (context, snapshot) {
            // Loading State
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Memuat data dari MySQL...'),
                  ],
                ),
              );
            }

            // Error State
            if (snapshot.hasError) {
              return Center(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.cloud_off,
                        size: 64,
                        color: Colors.redAccent,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Koneksi Backend Gagal',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${snapshot.error}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: _loadData,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Coba Lagi'),
                      ),
                    ],
                  ),
                ),
              );
            }

            // Empty State
            final listJasa = snapshot.data ?? [];
            if (listJasa.isEmpty) {
              return const Center(
                child: Text(
                  'Belum ada data penyedia jasa di database.',
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),
              );
            }

            // Success State (Data dari MySQL)
            return ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              itemCount: listJasa.length,
              itemBuilder: (context, index) {
                final jasa = listJasa[index];
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
                      backgroundColor:
                          Theme.of(context).colorScheme.primaryContainer,
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
            );
          },
        ),
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
                        Icon(
                          Icons.info_outline,
                          size: 20,
                          color: Color(0xFF1E88E5),
                        ),
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

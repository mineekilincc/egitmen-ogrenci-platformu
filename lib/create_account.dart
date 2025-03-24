import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  String? _userRole = 'Öğrenci'; // Varsayılan olarak Öğrenci seçildi

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          "Hesap Oluştur",
          style: GoogleFonts.poppins(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Yeni Bir Hesap Oluştur",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 30,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.1),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // İsim TextField
                    TextField(
                      decoration: InputDecoration(
                        hintText: "İsim Soyisim",
                        prefixIcon: const Icon(Icons.person_outline),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade200,
                      ),
                    ),
                    const SizedBox(height: 15),
                    // Email TextField
                    TextField(
                      decoration: InputDecoration(
                        hintText: "E-mail",
                        prefixIcon: const Icon(Icons.email_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade200,
                      ),
                    ),
                    const SizedBox(height: 15),
                    // Şifre TextField
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Şifre",
                        prefixIcon: const Icon(Icons.lock_outline),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade200,
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Şifre Onay TextField
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Şifreyi Doğrulayın",
                        prefixIcon: const Icon(Icons.lock_outline),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade200,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Kullanıcı Rolü Seçimi (Eğitmen / Öğrenci)
                    Column(
                      children: [
                        Text(
                          'Kullanıcı Rolü Seçin:',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Öğrenci ve Eğitmen seçenekleri
                        RadioListTile<String>(
                          title: Text(
                            'Öğrenci',
                            style: GoogleFonts.poppins(fontSize: 14),
                          ),
                          value: 'Öğrenci',
                          groupValue: _userRole,
                          onChanged: (String? value) {
                            setState(() {
                              _userRole = value;
                            });
                          },
                        ),
                        RadioListTile<String>(
                          title: Text(
                            'Eğitmen',
                            style: GoogleFonts.poppins(fontSize: 14),
                          ),
                          value: 'Eğitmen',
                          groupValue: _userRole,
                          onChanged: (String? value) {
                            setState(() {
                              _userRole = value;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Hesap Oluştur Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          // Hesap oluşturma işlemleri burada gerçekleştirilecek
                          print("Kullanıcı Rolü: $_userRole");
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pinkAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          "Hesap Oluştur",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    // Zaten bir hesabınız var mı?
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Zaten bir hesabınız var mı?",
                          style: GoogleFonts.poppins(fontSize: 12),
                        ),
                        TextButton(
                          onPressed: () {
                            // Giriş ekranına yönlendirme işlemleri burada gerçekleştirilecek
                          },
                          child: Text(
                            "Giriş Yap",
                            style: GoogleFonts.poppins(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

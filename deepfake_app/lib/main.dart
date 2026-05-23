import 'package:flutter/material.dart';

void main() {
  runApp(const DeepGuardAI());
}

class DeepGuardAI extends StatelessWidget {
  const DeepGuardAI({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DeepGuard AI',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      body: Stack(
        children: [

          /// TOP GLOW
          Positioned(
            top: -120,
            left: -80,
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.purple.withOpacity(0.18),
              ),
            ),
          ),

          Positioned(
            top: 50,
            right: -100,
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue.withOpacity(0.15),
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  const SizedBox(height: 10),

                  /// HEADER
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          const Text(
                            "DeepGuard",
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF111827),
                            ),
                          ),

                          ShaderMask(
                            shaderCallback: (bounds) {
                              return const LinearGradient(
                                colors: [
                                  Colors.purple,
                                  Colors.blue,
                                ],
                              ).createShader(bounds);
                            },

                            child: const Text(
                              "AI Detector",
                              style: TextStyle(
                                fontSize: 34,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),

                          const SizedBox(height: 10),

                          const Text(
                            "Detect AI-generated media instantly",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),

                      Container(
                        width: 60,
                        height: 60,

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),

                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF8B5CF6),
                              Color(0xFF3B82F6),
                            ],
                          ),

                          boxShadow: [
                            BoxShadow(
                              color: Colors.purple.withOpacity(0.3),
                              blurRadius: 25,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),

                        child: const Icon(
                          Icons.auto_awesome,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 35),

                  /// UPLOAD CARD
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(28),

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(34),
                      color: Colors.white,

                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 30,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),

                    child: Column(
                      children: [

                        Container(
                          width: 110,
                          height: 110,

                          decoration: BoxDecoration(
                            shape: BoxShape.circle,

                            gradient: LinearGradient(
                              colors: [
                                Colors.purple.withOpacity(0.15),
                                Colors.blue.withOpacity(0.15),
                              ],
                            ),
                          ),

                          child: const Icon(
                            Icons.cloud_upload_rounded,
                            size: 55,
                            color: Color(0xFF7C3AED),
                          ),
                        ),

                        const SizedBox(height: 22),

                        const Text(
                          "Upload Your File",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF111827),
                          ),
                        ),

                        const SizedBox(height: 10),

                        const Text(
                          "Analyze images, videos, and audio files with advanced AI detection",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black54,
                            height: 1.5,
                            fontSize: 15,
                          ),
                        ),

                        const SizedBox(height: 28),

                        /// FILE TYPES
                        Row(
                          children: [

                            Expanded(
                              child: mediaTypeCard(
                                icon: Icons.image,
                                title: "Image",
                                color: Colors.purple,
                              ),
                            ),

                            const SizedBox(width: 14),

                            Expanded(
                              child: mediaTypeCard(
                                icon: Icons.videocam,
                                title: "Video",
                                color: Colors.blue,
                              ),
                            ),

                            const SizedBox(width: 14),

                            Expanded(
                              child: mediaTypeCard(
                                icon: Icons.mic,
                                title: "Audio",
                                color: Colors.pink,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 28),

                        /// BUTTON
                        Container(
                          width: double.infinity,
                          height: 62,

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22),

                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF8B5CF6),
                                Color(0xFF3B82F6),
                              ],
                            ),

                            boxShadow: [
                              BoxShadow(
                                color: Colors.purple.withOpacity(0.35),
                                blurRadius: 25,
                                offset: const Offset(0, 12),
                              ),
                            ],
                          ),

                          child: ElevatedButton.icon(
                            onPressed: () {},

                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                            ),

                            icon: const Icon(Icons.upload_file),

                            label: const Text(
                              "Select File",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  /// RESULT CARD
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(28),

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(34),

                      gradient: LinearGradient(
                        colors: [
                          Colors.white,
                          Colors.green.withOpacity(0.06),
                        ],
                      ),

                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.withOpacity(0.08),
                          blurRadius: 30,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),

                    child: Column(
                      children: [

                        Row(
                          children: [

                            Container(
                              width: 16,
                              height: 16,

                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.greenAccent,
                              ),
                            ),

                            const SizedBox(width: 10),

                            const Text(
                              "ANALYSIS RESULT",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.5,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 30),

                        const Text(
                          "REAL",
                          style: TextStyle(
                            fontSize: 56,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),

                        const SizedBox(height: 12),

                        const Text(
                          "This media appears authentic",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                          ),
                        ),

                        const SizedBox(height: 28),

                        ClipRRect(
                          borderRadius: BorderRadius.circular(30),

                          child: const LinearProgressIndicator(
                            value: 0.94,
                            minHeight: 14,
                          ),
                        ),

                        const SizedBox(height: 14),

                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Text(
                              "Confidence",
                              style: TextStyle(
                                color: Colors.black54,
                              ),
                            ),

                            Text(
                              "94%",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF111827),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget mediaTypeCard({
    required IconData icon,
    required String title,
    required Color color,
  }) {

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 18,
      ),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: color.withOpacity(0.08),
      ),

      child: Column(
        children: [

          Icon(
            icon,
            color: color,
            size: 30,
          ),

          const SizedBox(height: 10),

          Text(
            title,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
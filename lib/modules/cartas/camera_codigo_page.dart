import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraCodigoPage extends StatefulWidget {
  const CameraCodigoPage({super.key});

  @override
  State<CameraCodigoPage> createState() => _CameraCodigoPageState();
}

class _CameraCodigoPageState extends State<CameraCodigoPage> {
  CameraController? _controller;
  bool _inicializando = true;
  bool _capturando = false;
  String? _erro;

  @override
  void initState() {
    super.initState();
    _inicializarCamera();
  }

  Future<void> _inicializarCamera() async {
    try {
      final cameras = await availableCameras();

      if (cameras.isEmpty) {
        throw Exception('Nenhuma câmera encontrada.');
      }

      final cameraTraseira = cameras.firstWhere(
        (camera) =>
          camera.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.first,
      );

      final controller = CameraController(
        cameraTraseira,
        ResolutionPreset.high,
        enableAudio: false,
      );

      _controller = controller;

      await controller.initialize();

      if (!mounted) {
        await controller.dispose();
        return;
      }

      setState(() {
        _inicializando = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _erro = 'Não foi possível abrir a câmera: $e';
        _inicializando = false;
      });
    }
  }

  Future<void> _capturarFoto() async {
    final controller = _controller;

    if (controller == null ||
      !controller.value.isInitialized ||
      _capturando) {
        return;
      }

    setState(() => _capturando = true);

    try {
      final foto = await controller.takePicture();

      if (!mounted) return;

      Navigator.pop(context, foto.path);
    } catch (e) {
      if (!mounted) return;

      setState(() => _capturando = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao tirar foto: $e'),
        ),
      );
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (_inicializando)
              const Center(
                child: CircularProgressIndicator(),
              )
            else if (_erro != null)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    _erro!,
                    style: const TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            else if (controller != null &&
                controller.value.isInitialized)
              CameraPreview(controller),

            if (!_inicializando && _erro == null)
              Positioned(
                top: 24,
                left: 20,
                right: 20,
                child: Column(
                  children: [
                    const Text(
                      'Identificar carta',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Aproxime a câmera e enquande somente '
                      'o código numérico de 8 dígitos.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),

            if (!_inicializando && _erro == null)
              Center(
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 0.82,
                  height: 76,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.greenAccent,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            if(!_inicializando && _erro == null)
              Positioned(
                left: 20,
                right: 20,
                bottom: 28,
                child: Column(
                  children: [
                    const Text(
                      'Deixe os 8 dígitos nítidos dentro da moldura.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: 
                          _capturando ? null : _capturarFoto,
                        icon: const Icon(Icons.camera_alt),
                        label: Text(
                          _capturando
                            ? 'Capturando...'
                            : 'Capturar código',
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: _capturando
                        ? null
                        : () => Navigator.pop(context),
                      child: const Text(
                        'Cancelar',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
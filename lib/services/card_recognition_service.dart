import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class CardRecognitionService {
  final TextRecognizer _textRecognizer = TextRecognizer(
    script: TextRecognitionScript.latin,
  );

  Future<String> reconhecerTexto(String caminhoImagem) async {
    final imagem = InputImage.fromFilePath(caminhoImagem);

    final resultado = await _textRecognizer.processImage(imagem);

    return resultado.text;
  }

  void dispose() {
    _textRecognizer.close();
  }
}
import '../../domain/repositories/ai_repository.dart';
import '../smart_task_breaker.dart';
// import 'package:google_generative_ai/google_generative_ai.dart';

class AiRepositoryImpl implements AiRepository {
  @override
  Future<List<String>> breakdownTask(String title) async {
    // LÓGICA GRATUITA AUTOMATIZADA:
    // Utilizamos un motor heurístico basado en plantillas inteligentes.
    // Es instantáneo, no consume datos y es 100% privado.
    
    await Future.delayed(const Duration(milliseconds: 600)); // Simulación de IA
    return SmartTaskBreaker.breakDown(title);

    /* 
    PARA INTEGRAR GEMINI (TIER GRATUITO):
    1. Obtén una API KEY en https://aistudio.google.com/
    2. Descomenta el código de abajo:

    final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: 'TU_API_KEY');
    final prompt = 'Eres un experto en TDAH. Desglosa esta tarea en 5 micropasos accionables de menos de 5 minutos cada uno: "$title". Responde solo con la lista de pasos, uno por línea.';
    final content = [Content.text(prompt)];
    final response = await model.generateContent(content);
    
    return response.text?.split('\n').where((s) => s.isNotEmpty).toList() ?? [];
    */
  }
}

import 'package:number_gaminng_app/utils/app_log.dart';
import 'package:number_gaminng_app/utils/language/en_en_language.dart';
import 'package:number_gaminng_app/widgets/texts/languages/translation_cache.dart';
import 'package:translator/translator.dart';
import 'package:number_gaminng_app/utils/language/language_data.dart';

class TranslationService {
  TranslationService._();

  static final TranslationService instance = TranslationService._();

  final GoogleTranslator _translator = GoogleTranslator();

  Future<String> getText({required String key, required String language}) async {
    final targetLanguage = language.split('_').first.toLowerCase();

    final currentLanguageMap = LanguageData.getLanguage(language);

    final localText = currentLanguageMap[key];

    if (localText != null && localText.isNotEmpty) {
      return localText;
    }

    final englishText = enEnLanguage[key];

    if (englishText == null || englishText.isEmpty) {
      return key;
    }

    if (targetLanguage == 'en') {
      return englishText;
    }

    final cachedText = await TranslationCache.get(key: key, language: targetLanguage);

    if (cachedText != null && cachedText.isNotEmpty) {
      return cachedText;
    }

    try {
      final result = await _translator.translate(englishText, to: targetLanguage);

      final translatedText = result.text;

      if (translatedText.isNotEmpty) {
        await TranslationCache.set(key: key, language: targetLanguage, value: translatedText);

        return translatedText;
      }
    } catch (_) {
      appLog('Translation failed for key: $key, language: $language');
    }

    return englishText;
  }
}

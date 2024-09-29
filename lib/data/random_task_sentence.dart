import 'dart:math';

String randomTaskSentences() {
  final List<String> taskSentences = [
    'Notlarınızı buraya ekleyin!',
    'Gününüzü planlamak için tıklayın.',
    'Hedeflerinizi yazın ve takip edin.',
    'Unutmayın, küçük notlar büyük farklar yaratır.',
    'Yapılacaklarınızı buraya ekleyebilirsiniz.',
    'Düşüncelerinizi not alın, zihninizi özgürleştirin.',
    'Önemli anları kaydetmek için tıklayın.',
    'Planlayın, başarın!',
    'Hatırlatmalar ekleyerek hiçbir şeyi kaçırmayın.',
    'Hayallerinizi gerçeğe dönüştürmek için yazmaya başlayın.',
  ];
  final random = Random();
  return taskSentences[random.nextInt(taskSentences.length)];
}

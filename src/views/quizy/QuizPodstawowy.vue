<template>
  <div>
    <!-- Header -->
    <section class="bg-gradient-to-r from-primary to-orange-600 text-white py-8 px-8">
      <div class="mx-auto max-w-[1440px]">
        <h1 class="text-3xl md:text-4xl font-bold">Quiz Podstawowy ADR</h1>
      </div>
    </section>

    <!-- Password Protection -->
    <section v-if="!isAuthenticated" class="py-16 px-8 bg-white min-h-[60vh] flex items-center justify-center">
      <div class="mx-auto max-w-md w-full">
        <div class="bg-white rounded-lg p-8 border border-gray-200 shadow-lg">
          <div class="text-center mb-6">
            <div class="bg-primary/10 w-16 h-16 rounded-full flex items-center justify-center mx-auto mb-4">
              <svg class="w-8 h-8 text-primary" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z" />
              </svg>
            </div>
            <h2 class="text-2xl font-bold text-text-main mb-2">Dostęp chroniony</h2>
            <p class="text-gray-600">Wprowadź hasło aby uzyskać dostęp do quizu</p>
          </div>

          <form @submit.prevent="checkPassword" class="space-y-4">
            <div>
              <label for="password" class="block text-sm font-semibold text-text-main mb-2">
                Hasło
              </label>
              <input
                type="password"
                id="password"
                v-model="passwordInput"
                class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent"
                placeholder="Wprowadź hasło"
                required
              />
            </div>

            <div v-if="showError" class="p-3 bg-red-50 border border-red-200 rounded-lg">
              <p class="text-sm text-red-600">Nieprawidłowe hasło. Spróbuj ponownie.</p>
            </div>

            <button
              type="submit"
              class="w-full bg-primary text-white px-8 py-3 text-lg font-semibold rounded-lg hover:opacity-90 transition-opacity uppercase"
            >
              Zaloguj się
            </button>
          </form>
        </div>
      </div>
    </section>

    <!-- Quiz Content -->
    <section v-else class="py-16 px-8 bg-white">
      <div class="mx-auto max-w-[1000px]">
        <div class="mb-8 flex justify-between items-center">
          <h2 class="text-2xl font-bold text-text-main">
            {{ selectedQuizId ? availableQuizzes.find(q => q.id === selectedQuizId)?.name : 'Quizy Podstawowe' }}
          </h2>
          <button
            @click="logout"
            class="text-sm text-gray-600 hover:text-primary transition-colors"
          >
            Wyloguj się
          </button>
        </div>

        <!-- Quiz selection - when no quiz is selected -->
        <div v-if="!selectedQuizId" class="space-y-6">
          <div class="bg-primary/10 rounded-lg p-6 mb-8">
            <h3 class="font-bold text-xl text-text-main mb-2 text-center">Wybierz quiz do rozwiązania</h3>
            <p class="text-gray-600 text-center">Dostępnych jest 15 quizów podstawowych</p>
          </div>

          <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
            <div
              v-for="quiz in availableQuizzes"
              :key="quiz.id"
              @click="selectQuiz(quiz.id)"
              class="bg-white border-2 border-gray-300 rounded-lg p-6 cursor-pointer hover:border-primary hover:shadow-lg transition-all"
            >
              <div class="flex items-center justify-between mb-3">
                <h4 class="text-lg font-bold text-text-main">{{ quiz.name }}</h4>
                <span 
                  v-if="quiz.completed"
                  class="bg-green-600 text-white px-2 py-1 rounded text-xs font-semibold"
                >
                  ✓
                </span>
              </div>
              <p class="text-sm text-gray-600 mb-2">
                {{ isQuizAvailable(quiz.id) ? `${getQuizQuestions(quiz.id).length} pytań` : 'Wkrótce dostępny' }}
              </p>
              <div v-if="quiz.score !== null" class="text-sm font-semibold" :class="quiz.score >= 75 ? 'text-green-600' : 'text-red-600'">
                Wynik: {{ quiz.score }}%
              </div>
              <button 
                v-if="isQuizAvailable(quiz.id)"
                class="mt-3 w-full bg-primary text-white px-4 py-2 rounded hover:opacity-90 transition-opacity text-sm font-semibold"
              >
                Rozpocznij
              </button>
              <div v-else class="mt-3 w-full bg-gray-300 text-gray-500 px-4 py-2 rounded text-sm font-semibold text-center">
                Niedostępny
              </div>
            </div>
          </div>
        </div>

        <!-- Quiz not started (but quiz is selected) -->
        <div v-if="selectedQuizId && !quizStarted && !quizFinished" class="text-center">
          <button 
            @click="backToQuizList"
            class="mb-6 text-gray-600 hover:text-primary transition-colors flex items-center gap-2"
          >
            ← Powrót do listy quizów
          </button>
          
          <h3 class="text-2xl font-bold text-text-main mb-6">
            {{ availableQuizzes.find(q => q.id === selectedQuizId)?.name }}
          </h3>
          
          <div class="bg-primary/10 rounded-lg p-6 mb-8">
            <h3 class="font-bold text-lg text-text-main mb-4">Informacje o quizie:</h3>
            <ul class="space-y-2">
              <li class="flex items-center justify-center">
                <span class="text-primary mr-2">✓</span>
                <span class="text-gray-700">{{ questions.length }} pytań testowych</span>
              </li>
            </ul>
          </div>
          <button 
            @click="startQuiz"
            class="bg-primary text-white px-8 py-4 text-lg font-semibold rounded-lg hover:opacity-90 transition-opacity uppercase"
          >
            Rozpocznij Quiz
          </button>
        </div>

        <!-- Quiz in progress -->
        <div v-if="quizStarted && !quizFinished">
          <div class="mb-6">
            <div class="bg-gray-200 rounded-full h-2">
              <div 
                class="bg-primary h-2 rounded-full transition-all duration-300"
                :style="{ width: `${(currentQuestion / questions.length) * 100}%` }"
              ></div>
            </div>
            <p class="text-sm text-gray-600 mt-2">
              Pytanie {{ currentQuestion }} / {{ questions.length }}
            </p>
          </div>

          <div class="bg-white border-2 border-gray-300 rounded-lg p-6">
            <div class="mb-4">
              <div class="flex items-center gap-2 mb-4">
                <span class="text-lg font-bold">Pytanie {{ currentQuestion }}</span>
                <span 
                  v-if="isQuestionAnswered(currentQuestion) && !isAnswerCorrect(currentQuestion)"
                  class="bg-red-600 text-white px-3 py-1 rounded text-sm font-semibold"
                >
                  ZŁE
                </span>
                <span 
                  v-if="isQuestionAnswered(currentQuestion) && isAnswerCorrect(currentQuestion)"
                  class="bg-green-600 text-white px-3 py-1 rounded text-sm font-semibold"
                >
                  POPRAWNIE
                </span>
              </div>
              <h3 class="text-lg mb-6">{{ questions[currentQuestion - 1].question }}</h3>
            </div>

            <div class="space-y-3">
              <div
                v-for="(answer, index) in questions[currentQuestion - 1].answers"
                :key="index"
                @click="selectAnswer(index)"
                :class="[
                  'flex items-start gap-3 p-4 rounded-lg cursor-pointer transition-colors border-2',
                  selectedAnswer === index ? 'border-primary bg-primary/10' : 'border-gray-300 hover:border-primary/50',
                  isQuestionAnswered(currentQuestion) && index === questions[currentQuestion - 1].correctAnswer ? 'bg-green-50 border-green-500' : '',
                  isQuestionAnswered(currentQuestion) && selectedAnswer === index && index !== questions[currentQuestion - 1].correctAnswer ? 'bg-red-50 border-red-500' : ''
                ]"
              >
                <div :class="[
                  'flex items-center justify-center w-10 h-10 rounded-full text-white font-bold flex-shrink-0',
                  isQuestionAnswered(currentQuestion) && index === questions[currentQuestion - 1].correctAnswer ? 'bg-green-600' : 
                  isQuestionAnswered(currentQuestion) && selectedAnswer === index && index !== questions[currentQuestion - 1].correctAnswer ? 'bg-red-600' : 
                  'bg-blue-600'
                ]">
                  <span v-if="isQuestionAnswered(currentQuestion) && index === questions[currentQuestion - 1].correctAnswer">✓</span>
                  <span v-else-if="isQuestionAnswered(currentQuestion) && selectedAnswer === index && index !== questions[currentQuestion - 1].correctAnswer">✗</span>
                  <span v-else>{{ answer.letter }}</span>
                </div>
                <span class="flex-1 text-gray-700">{{ answer.text }}</span>
              </div>
            </div>

            <div class="mt-6 flex justify-between">
              <button
                v-if="currentQuestion > 1"
                @click="previousQuestion"
                class="bg-gray-500 text-white px-6 py-2 rounded-lg hover:bg-gray-600 transition-colors"
              >
                ← Poprzednie
              </button>
              <div v-else></div>
              <button
                v-if="currentQuestion < questions.length"
                @click="nextQuestion"
                class="bg-primary text-white px-6 py-2 rounded-lg hover:opacity-90 transition-opacity"
              >
                Następne →
              </button>
              <button
                v-else
                @click="finishQuiz"
                class="bg-green-600 text-white px-6 py-2 rounded-lg hover:bg-green-700 transition-colors"
              >
                Zakończ Quiz
              </button>
            </div>
          </div>
        </div>

        <!-- Quiz finished -->
        <div v-if="quizFinished" class="text-center">
          <div class="bg-white border-2 border-gray-300 rounded-lg p-8 mb-6">
            <h3 class="text-2xl font-bold mb-4 text-text-main">Quiz zakończony!</h3>
            <div :class="[
              'text-6xl font-bold mb-4',
              percentage >= 75 ? 'text-green-600' : 'text-red-600'
            ]">
              {{ correctAnswers }}/{{ questions.length }}
            </div>
            <p class="text-lg text-gray-700 mb-2">
              Ukończono {{ correctAnswers }}/{{ questions.length }} pytania
            </p>
            <p class="text-2xl font-bold mb-4" :class="percentage >= 75 ? 'text-green-600' : 'text-red-600'">
              Uzyskano {{ percentage }}%
            </p>
            <p v-if="percentage >= 75" class="text-lg text-green-600 font-semibold">
              ✓ Gratulacje! Zdałeś quiz!
            </p>
            <p v-else class="text-lg text-red-600 font-semibold">
              ✗ Niestety nie udało się. Spróbuj ponownie.
            </p>
          </div>
          
          <div class="flex gap-4 justify-center flex-wrap">
            <button 
              @click="backToQuizList"
              class="bg-gray-500 text-white px-8 py-3 rounded-lg hover:bg-gray-600 transition-colors"
            >
              Lista quizów
            </button>
            <button 
              @click="restartQuiz"
              class="bg-primary text-white px-8 py-3 rounded-lg hover:opacity-90 transition-opacity"
            >
              Rozpocznij ponownie
            </button>
            <button 
              @click="showResults"
              class="bg-gray-600 text-white px-8 py-3 rounded-lg hover:bg-gray-700 transition-colors"
            >
              Zobacz odpowiedzi
            </button>
          </div>
        </div>
      </div>
    </section>

    <Contact />
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import Contact from '../../components/Contact.vue'
import { supabase } from '../../lib/supabaseClient'

const isAuthenticated = ref(false)
const passwordInput = ref('')
const showError = ref(false)
const CORRECT_PASSWORD = 'Romuald'
const STORAGE_KEY = 'quiz_podstawowy_auth'

const selectedQuizId = ref(null)
const quizStarted = ref(false)
const quizFinished = ref(false)
const currentQuestion = ref(1)
const selectedAnswer = ref(null)
const userAnswers = ref([])
const answeredQuestions = ref({})

// Definicja 15 quizów
const availableQuizzes = ref([
  { id: 1, name: 'Podstawowy 1', completed: false, score: null },
  { id: 2, name: 'Podstawowy 2', completed: false, score: null },
  { id: 3, name: 'Podstawowy 3', completed: false, score: null },
  { id: 4, name: 'Podstawowy 4', completed: false, score: null },
  { id: 5, name: 'Podstawowy 5', completed: false, score: null },
  { id: 6, name: 'Podstawowy 6', completed: false, score: null },
  { id: 7, name: 'Podstawowy 7', completed: false, score: null },
  { id: 8, name: 'Podstawowy 8', completed: false, score: null },
  { id: 9, name: 'Podstawowy 9', completed: false, score: null },
  { id: 10, name: 'Podstawowy 10', completed: false, score: null },
  { id: 11, name: 'Podstawowy 11', completed: false, score: null },
  { id: 12, name: 'Podstawowy 12', completed: false, score: null },
  { id: 13, name: 'Podstawowy 13', completed: false, score: null },
  { id: 14, name: 'Podstawowy 14', completed: false, score: null },
  { id: 15, name: 'Podstawowy 15', completed: false, score: null }
])

// Baza pytań - Quiz 1
const quiz1Questions = [
  {
    question: 'Kierowca powinien odmówić przyjęcia przesyłki do przewozu, jeżeli:',
    correctAnswer: 2,
    answers: [
      { letter: 'A', text: 'jest to urządzenie zawierające materiał niebezpieczny, a nazwa jego nie figuruje w spisie towarów ADR' },
      { letter: 'B', text: 'nadawca zlecił przewóz materiałów różnych klas' },
      { letter: 'C', text: 'opakowania nie są zaopatrzone w wymagane przepisami ADR oznakowania' }
    ]
  },
  {
    question: 'Jednostka transportowa o dopuszczalnej masie całkowitej (DMC) powyżej 7,5 tony powinna być wyposażona w dwie gaśnice:',
    correctAnswer: 2,
    answers: [
      { letter: 'A', text: 'o łącznej zawartości 10 kg' },
      { letter: 'B', text: 'o łącznej zawartości 8 kg' },
      { letter: 'C', text: 'o łącznej zawartości 12 kg przy czym co najmniej jedna powinna być nie mniejsza niż 6 kg' }
    ]
  },
  {
    question: 'Które z poniższych zagrożeń stwarzanych przez towary klasy 2 uważane się za najważniejsze?',
    correctAnswer: 1,
    answers: [
      { letter: 'A', text: 'działania szkodliwe dla środowiska' },
      { letter: 'B', text: 'związki z wysokim ciśnieniem' },
      { letter: 'C', text: 'właściwości trujące' }
    ]
  },
  {
    question: 'Niżej przedstawiony znak tunelu oznacza:',
    correctAnswer: null,
    answers: [
      { letter: 'A', text: 'zakaz wjazdu dla pojazdów przewożących towary niebezpieczne' },
      { letter: 'B', text: 'ograniczenie kategorii tunelu' },
      { letter: 'C', text: 'dopuszczalną prędkość' }
    ]
  },
  {
    question: 'Instrukcje pisemne:',
    correctAnswer: 0,
    answers: [
      { letter: 'A', text: 'mogą zalecać, aby w przypadku niewielkich wycieków, kierowca zapobiegł przedostaniu się materiału do kanalizacji lub cieków wodnych' },
      { letter: 'B', text: 'dostarczają kierowcy potrzebnych informacji dotyczących przejazdu przez tunele transalpejskie' },
      { letter: 'C', text: 'są pisane przez inspektora BHP w firmie przewoźnika lub nadawcy towaru niebezpiecznego' }
    ]
  },
  {
    question: 'Towarem niebezpiecznym w transporcie drogowym jest:',
    correctAnswer: 0,
    answers: [
      { letter: 'A', text: 'stopiony metal, przewożony w temperaturze powyżej 300°C' },
      { letter: 'B', text: 'przedmiot niewyimieniony w wykazie towarów niebezpiecznych, ale zawierający materiał niebezpieczny' },
      { letter: 'C', text: 'każdy gaz' }
    ]
  },
  {
    question: 'Wyłączenie przewozów z przepisów ADR na podstawie przepisu 1.1.3.6 (bez tablic), pozwala na:',
    correctAnswer: 1,
    answers: [
      { letter: 'A', text: 'przewóz indywidualnym użytkownikom towarów ADR w małych ilościach, zwalniając kierowcę z niektórym wymagań przepisów ADR' },
      { letter: 'B', text: 'niestosowanie się do przepisów ADR' },
      { letter: 'C', text: 'zwolnienie kierowcy z posiadania jakichkolwiek dokumentów związanych z transportem towarów ADR' }
    ]
  },
  {
    question: 'Podczas przewozu próżnych, nieoczyszczonych DPPL:',
    correctAnswer: 2,
    answers: [
      { letter: 'A', text: 'należy otworzyć pokrywy w celu przewietrzenia wnętrza opakowania przed kolejnym jego napełnieniem' },
      { letter: 'B', text: 'należy usunąć ze ścianek nalepki i oznakowania, które dotyczyły wcześniej przewożonego towaru' },
      { letter: 'C', text: 'na ściankach zewnętrznych powinny pozostać nalepki i oznakowania, tak jak w stanie ładownym' }
    ]
  },
  {
    question: 'Jak długo powinien przechowywać, nadawca i przewoźnik, kopię dokumentu przewozowego?',
    correctAnswer: 0,
    answers: [
      { letter: 'A', text: 'przez okres co najmniej trzech miesięcy' },
      { letter: 'B', text: 'do czasu dostarczenia przesyłki do odbiorcy' },
      { letter: 'C', text: 'decyduje o czasie przechowywania doradca DGSA – nadawcy' }
    ]
  },
  {
    question: 'Plan ochronny, dotyczący transportu towarów dużego ryzyka, powinien zawierać:',
    correctAnswer: 1,
    answers: [
      { letter: 'A', text: 'wykaz środków transportowych' },
      { letter: 'B', text: 'wykaz osób uczestniczących w przewozie' },
      { letter: 'C', text: 'sposoby specjalnego oznakowania pojazdu' }
    ]
  },
  {
    question: 'Do klasy 1 należą:',
    correctAnswer: 2,
    answers: [
      { letter: 'A', text: 'materiały trujące' },
      { letter: 'B', text: 'gazy' },
      { letter: 'C', text: 'przedmioty z materiałami wybuchowymi' }
    ]
  },
  {
    question: 'Plan ochrony towarów niebezpiecznych w transporcie drogowym powinien dotyczyć przewozu:',
    correctAnswer: 1,
    answers: [
      { letter: 'A', text: 'wszystkich towarów w cysternach' },
      { letter: 'B', text: 'materiału trującego klasy 6.1 I grupy pakowania przewożonego w pojeździe oznaczonym pomarańczowymi tablicami' },
      { letter: 'C', text: 'przewozu wszystkich materiałów klasy 9' }
    ]
  },
  {
    question: 'Częściowe wyłączenie spod działania przepisów Załącznika B ADR, pod warunkiem zachowania określonych limitów ilościowych na jednostkę transportową zgodnie z 1.1.3.6 dotyczy:',
    correctAnswer: 2,
    answers: [
      { letter: 'A', text: 'przewozu wszystkich próżnych nieczyszczonych opakowań po towarach niebezpiecznych' },
      { letter: 'B', text: 'próżnych cystern po gazach grupy A lub O nietwarzających zagrożenia lub przewozu zbiorników stacjonarnych do miejsca zamontowania' },
      { letter: 'C', text: 'przewozu w atestowanych i oznakowanych sztukach przesyłki' }
    ]
  },
  {
    question: 'Towarem niebezpiecznym w transporcie drogowym jest:',
    correctAnswer: 0,
    answers: [
      { letter: 'A', text: 'odpad kliniczny' },
      { letter: 'B', text: 'każdy gaz' },
      { letter: 'C', text: 'przedmiot niewyimieniony w wykazie towarów niebezpiecznych, ale zawierający materiał niebezpieczny' }
    ]
  },
  {
    question: 'Do klasy 2 według ADR należą:',
    correctAnswer: 0,
    answers: [
      { letter: 'A', text: 'gazy skroplone' },
      { letter: 'B', text: 'materiały w podwyższonej temperaturze' },
      { letter: 'C', text: 'materiały stałe zapalne' }
    ]
  },
  {
    question: 'Co należy rozumieć jako transport multimodalny (kombinowany)',
    correctAnswer: 1,
    answers: [
      { letter: 'A', text: 'przewóz towarów przy pomocy przynajmniej dwóch pojazdów samochodowych' },
      { letter: 'B', text: 'przewóz towarów niebezpiecznych przy użyciu co najmniej dwóch różnych rodzajów transportu (drogowego, rzecznego, morskiego, kolejowego)' },
      { letter: 'C', text: 'przewóz towarów niebezpiecznych w kombinowanych opakowaniach' }
    ]
  },
  {
    question: 'Co powinien zrobić kierowca w przypadku braku wymaganego oznakowania na sztukach przesyłki?',
    correctAnswer: 2,
    answers: [
      { letter: 'A', text: 'żądać oświadczenia nadawcy o przejęciu odpowiedzialności za transport' },
      { letter: 'B', text: 'rozpocząć przewóz ponieważ za oznakowania odpowiada nadawca' },
      { letter: 'C', text: 'odmówić przyjęcia przesyłki jeśli nadawca nie uzupełni oznakowania' }
    ]
  },
  {
    question: 'Co oznacza trzycyfrowa liczba poprzedzona znakiem „X" w górnej części tablicy?',
    correctAnswer: null,
    answers: [
      { letter: 'A', text: 'Odpowiedź A' },
      { letter: 'B', text: 'Odpowiedź B' },
      { letter: 'C', text: 'Odpowiedź C' }
    ]
  },
  {
    question: 'Oznakowanie jednostki transportowej:',
    correctAnswer: 1,
    answers: [
      { letter: 'A', text: 'to obowiązek nadawcy towarów niebezpiecznych' },
      { letter: 'B', text: 'jest zawsze obowiązkiem kierowcy' },
      { letter: 'C', text: 'jest obowiązkiem kierowcy w przypadku przewozu towarów niebezpiecznych w sztukach przesyłką pojazdem skrzyniowym' }
    ]
  },
  {
    question: 'Numery znajdujące się na tablicy ostrzegawczej wskazują:',
    correctAnswer: null,
    answers: [
      { letter: 'A', text: 'Odpowiedź A' },
      { letter: 'B', text: 'Odpowiedź B' },
      { letter: 'C', text: 'Odpowiedź C' }
    ]
  }
]

// Funkcja zwracająca pytania dla danego quizu
const getQuizQuestions = (quizId) => {
  if (quizId === 1) return quiz1Questions
  // Quizy 2-15 będą dodane później
  return []
}

// Pobierz pytania dla wybranego quizu
const questions = computed(() => {
  if (selectedQuizId.value) {
    return getQuizQuestions(selectedQuizId.value)
  }
  return []
})

// Informacja o dostępności quizu
const isQuizAvailable = (quizId) => {
  return quizId === 1 // Tylko quiz 1 jest dostępny
}

onMounted(() => {
  const auth = localStorage.getItem(STORAGE_KEY)
  if (auth === 'true') {
    isAuthenticated.value = true
  }
})

const correctAnswers = computed(() => {
  let count = 0
  questions.value.forEach((question, index) => {
    if (userAnswers.value[index] !== undefined && userAnswers.value[index] === question.correctAnswer) {
      count++
    }
  })
  return count
})

const percentage = computed(() => {
  return Math.round((correctAnswers.value / questions.value.length) * 100)
})

const isQuestionAnswered = (questionNumber) => {
  return userAnswers.value[questionNumber - 1] !== undefined
}

const isAnswerCorrect = (questionNumber) => {
  const question = questions.value[questionNumber - 1]
  return userAnswers.value[questionNumber - 1] === question.correctAnswer
}

const checkPassword = () => {
  if (passwordInput.value === CORRECT_PASSWORD) {
    isAuthenticated.value = true
    localStorage.setItem(STORAGE_KEY, 'true')
    showError.value = false
    passwordInput.value = ''
  } else {
    showError.value = true
    passwordInput.value = ''
  }
}

const logout = () => {
  isAuthenticated.value = false
  localStorage.removeItem(STORAGE_KEY)
}

const selectQuiz = (quizId) => {
  if (isQuizAvailable(quizId)) {
    selectedQuizId.value = quizId
  }
}

const backToQuizList = () => {
  selectedQuizId.value = null
  quizStarted.value = false
  quizFinished.value = false
  currentQuestion.value = 1
  selectedAnswer.value = null
  userAnswers.value = []
  answeredQuestions.value = {}
}

const startQuiz = () => {
  quizStarted.value = true
  currentQuestion.value = 1
}

const selectAnswer = (index) => {
  selectedAnswer.value = index
  userAnswers.value[currentQuestion.value - 1] = index
}

const nextQuestion = () => {
  if (currentQuestion.value < questions.value.length) {
    currentQuestion.value++
    selectedAnswer.value = userAnswers.value[currentQuestion.value - 1] !== undefined ? userAnswers.value[currentQuestion.value - 1] : null
  }
}

const previousQuestion = () => {
  if (currentQuestion.value > 1) {
    currentQuestion.value--
    selectedAnswer.value = userAnswers.value[currentQuestion.value - 1] !== undefined ? userAnswers.value[currentQuestion.value - 1] : null
  }
}

const finishQuiz = async () => {
  quizFinished.value = true
  quizStarted.value = false
  
  // Update quiz as completed
  const quiz = availableQuizzes.value.find(q => q.id === selectedQuizId.value)
  if (quiz) {
    quiz.completed = true
    quiz.score = percentage.value
  }
  
  // Save quiz result to Supabase
  try {
    const { error } = await supabase
      .from('quiz_results')
      .insert([
        {
          quiz_type: `podstawowy_${selectedQuizId.value}`,
          correct_answers: correctAnswers.value,
          total_questions: questions.value.length,
          percentage: percentage.value,
          passed: percentage.value >= 75,
          answers: userAnswers.value,
          completed_at: new Date().toISOString()
        }
      ])
    
    if (error) {
      console.error('Error saving quiz result:', error)
    }
  } catch (error) {
    console.error('Error saving quiz result:', error)
  }
}

const restartQuiz = () => {
  quizStarted.value = false
  quizFinished.value = false
  currentQuestion.value = 1
  selectedAnswer.value = null
  userAnswers.value = []
  answeredQuestions.value = {}
}

const showResults = () => {
  quizStarted.value = true
  quizFinished.value = false
  currentQuestion.value = 1
}
</script>

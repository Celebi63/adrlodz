<template>
  <div class="min-h-screen bg-gray-100">
    <div class="flex items-center justify-center min-h-screen px-4">
      <div class="w-full max-w-md">
        <!-- Logo -->
        <div class="text-center mb-8">
          <img 
            src="../../assets/logo.png" 
            alt="ADR Łódź Logo" 
            class="h-24 mx-auto mb-4"
          />
          <h1 class="text-3xl font-bold text-text-main">Panel Administracyjny</h1>
          <p class="text-gray-600 mt-2">Zaloguj się do systemu zarządzania</p>
        </div>

        <!-- Login Form -->
        <div class="bg-white rounded-lg shadow-lg p-8">
          <form @submit.prevent="handleLogin" class="space-y-6">
            <!-- Email -->
            <div>
              <label for="email" class="block text-sm font-semibold text-text-main mb-2">
                Email
              </label>
              <input
                type="email"
                id="email"
                v-model="email"
                required
                class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent"
                placeholder="twoj@email.com"
              />
            </div>

            <!-- Password -->
            <div>
              <label for="password" class="block text-sm font-semibold text-text-main mb-2">
                Hasło
              </label>
              <input
                type="password"
                id="password"
                v-model="password"
                required
                class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent"
                placeholder="••••••••"
              />
            </div>

            <!-- Error Message -->
            <div v-if="errorMessage" class="p-4 bg-red-100 border border-red-400 rounded-lg text-red-700 text-sm">
              {{ errorMessage }}
            </div>

            <!-- Submit Button -->
            <button
              type="submit"
              :disabled="isLoading"
              class="w-full bg-primary text-white px-6 py-3 rounded-lg font-semibold hover:opacity-90 transition-opacity disabled:opacity-50 disabled:cursor-not-allowed"
            >
              {{ isLoading ? 'Logowanie...' : 'Zaloguj się' }}
            </button>
          </form>
        </div>

        <!-- Back to Home -->
        <div class="text-center mt-6">
          <router-link to="/" class="text-primary hover:underline">
            ← Powrót do strony głównej
          </router-link>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { supabase } from '../../lib/supabaseClient'

const router = useRouter()
const email = ref('')
const password = ref('')
const isLoading = ref(false)
const errorMessage = ref('')

const handleLogin = async () => {
  isLoading.value = true
  errorMessage.value = ''

  try {
    const { data, error } = await supabase.auth.signInWithPassword({
      email: email.value,
      password: password.value,
    })

    if (error) throw error

    // Redirect to admin dashboard
    router.push('/admin/dashboard')
  } catch (error) {
    console.error('Login error:', error)
    errorMessage.value = 'Nieprawidłowy email lub hasło. Spróbuj ponownie.'
  } finally {
    isLoading.value = false
  }
}
</script>

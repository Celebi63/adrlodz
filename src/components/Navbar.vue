<template>
  <div>
    <!-- Top Bar -->
    <div class="bg-surface py-2 px-8">
      <div class="mx-auto max-w-[1440px] flex justify-center items-center gap-4">
        <span class="text-sm text-text-main">
          Masz pytania? Skontaktuj się z nami
        </span>
        <button 
          @click="scrollToContact"
          class="bg-primary text-text-main px-6 py-1 text-sm font-semibold hover:opacity-90 transition-opacity uppercase"
        >
          KONTAKT
        </button>
      </div>
    </div>

    <!-- Main Navigation -->
    <nav class="bg-background shadow-md sticky top-0 z-50">
      <div class="mx-auto max-w-[1440px] px-8">
        <div class="flex items-center h-28 gap-8">
          <!-- Logo -->
          <router-link to="/" class="flex items-center">
            <img 
              src="../assets/logo.png" 
              alt="ADR Łódź Logo" 
              class="h-20 w-auto cursor-pointer hover:opacity-90 transition-opacity"
            />
          </router-link>

          <!-- Desktop Menu -->
          <div class="hidden lg:flex items-center space-x-8 flex-1 justify-between">
            <router-link to="/o-nas" class="text-text-main hover:text-primary transition-colors font-medium">
              O NAS
            </router-link>

            <!-- Kursy Dropdown with Invisible Bridge -->
            <div class="relative group">
              <button 
                class="flex items-center text-text-main hover:text-primary transition-colors font-medium py-6"
              >
                KURSY
                <ChevronDown 
                  class="ml-1 w-4 h-4 transition-transform group-hover:rotate-180"
                />
              </button>
              <!-- Invisible Bridge - padding creates hover zone -->
              <div class="absolute top-full left-0 pt-2 opacity-0 invisible group-hover:opacity-100 group-hover:visible transition-all duration-200">
                <div class="w-64 bg-background shadow-lg rounded-lg py-2 border border-gray-200">
                  <router-link to="/kursy/podstawowy" class="block px-4 py-3 text-text-main hover:bg-surface hover:text-primary transition-colors">
                    Kurs podstawowy ADR
                  </router-link>
                  <router-link to="/kursy/cysterny" class="block px-4 py-3 text-text-main hover:bg-surface hover:text-primary transition-colors">
                    Kurs ADR - Cysterny
                  </router-link>
                  <a href="#" class="block px-4 py-3 text-text-main hover:bg-surface hover:text-primary transition-colors">
                    Kurs odświeżający ADR
                  </a>
                </div>
              </div>
            </div>

            <!-- Przepisy Dropdown with Invisible Bridge -->
            <div class="relative group">
              <button 
                class="flex items-center text-text-main hover:text-primary transition-colors font-medium py-6"
              >
                PRZEPISY
                <ChevronDown 
                  class="ml-1 w-4 h-4 transition-transform group-hover:rotate-180"
                />
              </button>
              <!-- Invisible Bridge -->
              <div class="absolute top-full left-0 pt-2 opacity-0 invisible group-hover:opacity-100 group-hover:visible transition-all duration-200">
                <div class="w-64 bg-background shadow-lg rounded-lg py-2 border border-gray-200 max-h-96 overflow-y-auto">
                  <router-link to="/przepisy/wstep" class="block px-4 py-3 text-text-main hover:bg-surface hover:text-primary transition-colors">
                    Wstęp
                  </router-link>
                  <router-link to="/przepisy/klasyfikacja" class="block px-4 py-3 text-text-main hover:bg-surface hover:text-primary transition-colors">
                    Klasyfikacja
                  </router-link>
                  <router-link to="/przepisy/zwolnienia" class="block px-4 py-3 text-text-main hover:bg-surface hover:text-primary transition-colors">
                    Zwolnienia
                  </router-link>
                  <router-link to="/przepisy/oznakowanie" class="block px-4 py-3 text-text-main hover:bg-surface hover:text-primary transition-colors">
                    Oznakowanie
                  </router-link>
                  <router-link to="/przepisy/zagrozenia" class="block px-4 py-3 text-text-main hover:bg-surface hover:text-primary transition-colors">
                    Zagrożenia
                  </router-link>
                  <router-link to="/przepisy/tunele" class="block px-4 py-3 text-text-main hover:bg-surface hover:text-primary transition-colors">
                    Tunele
                  </router-link>
                  <router-link to="/przepisy/dokument-przewozowy" class="block px-4 py-3 text-text-main hover:bg-surface hover:text-primary transition-colors">
                    Dokument Przewozowy
                  </router-link>
                  <router-link to="/przepisy/instrukcja" class="block px-4 py-3 text-text-main hover:bg-surface hover:text-primary transition-colors">
                    Instrukcja
                  </router-link>
                  <router-link to="/przepisy/cysterny" class="block px-4 py-3 text-text-main hover:bg-surface hover:text-primary transition-colors">
                    Cysterny
                  </router-link>
                  <router-link to="/przepisy/hierarchizacja" class="block px-4 py-3 text-text-main hover:bg-surface hover:text-primary transition-colors">
                    Hierarchizacja
                  </router-link>
                  <router-link to="/przepisy/klasa-1" class="block px-4 py-3 text-text-main hover:bg-surface hover:text-primary transition-colors">
                    Klasa 1
                  </router-link>
                  <router-link to="/przepisy/klasa-7" class="block px-4 py-3 text-text-main hover:bg-surface hover:text-primary transition-colors">
                    Klasa 7
                  </router-link>
                </div>
              </div>
            </div>

            <!-- Quizy Dropdown with Invisible Bridge -->
            <div class="relative group">
              <button 
                class="flex items-center text-text-main hover:text-primary transition-colors font-medium py-6"
              >
                QUIZY
                <ChevronDown 
                  class="ml-1 w-4 h-4 transition-transform group-hover:rotate-180"
                />
              </button>
              <!-- Invisible Bridge -->
              <div class="absolute top-full left-0 pt-2 opacity-0 invisible group-hover:opacity-100 group-hover:visible transition-all duration-200">
                <div class="w-64 bg-background shadow-lg rounded-lg py-2 border border-gray-200">
                  <router-link to="/quizy/podstawowy" class="block px-4 py-3 text-text-main hover:bg-surface hover:text-primary transition-colors">
                    Quiz podstawowy
                  </router-link>
                  <router-link to="/quizy/cysterny" class="block px-4 py-3 text-text-main hover:bg-surface hover:text-primary transition-colors">
                    Quiz cysterny
                  </router-link>
                </div>
              </div>
            </div>

            <a 
              href="#kontakt" 
              @click="scrollToContact"
              class="text-text-main hover:text-primary transition-colors font-medium"
            >
              KONTAKT
            </a>
          </div>

          <!-- Mobile Menu Button -->
          <button 
            @click="mobileMenuOpen = !mobileMenuOpen"
            class="lg:hidden text-text-main hover:text-primary focus:outline-none w-8 h-8 relative flex items-center justify-center"
          >
            <div class="w-6 h-6 relative flex items-center justify-center">
              <span 
                :class="[
                  'absolute block h-0.5 w-full bg-current transition-all duration-300 ease-in-out',
                  mobileMenuOpen ? 'rotate-45' : '-translate-y-2'
                ]"
              ></span>
              <span 
                :class="[
                  'absolute block h-0.5 w-full bg-current transition-all duration-300 ease-in-out',
                  mobileMenuOpen ? 'opacity-0' : 'opacity-100'
                ]"
              ></span>
              <span 
                :class="[
                  'absolute block h-0.5 w-full bg-current transition-all duration-300 ease-in-out',
                  mobileMenuOpen ? '-rotate-45' : 'translate-y-2'
                ]"
              ></span>
            </div>
          </button>
        </div>

        <!-- Mobile Menu -->
        <div 
          v-if="mobileMenuOpen"
          class="lg:hidden py-4 border-t border-surface"
        >
          <router-link 
            to="/o-nas" 
            class="block py-3 text-text-main hover:text-primary transition-colors font-medium"
            @click="mobileMenuOpen = false"
          >
            O NAS
          </router-link>

          <!-- Mobile Kursy Accordion -->
          <div class="border-t border-surface">
            <button 
              @click="toggleMobileDropdown('kursy')"
              class="w-full flex items-center justify-between py-3 text-text-main hover:text-primary transition-colors font-medium"
            >
              KURSY
              <ChevronDown 
                :class="['w-4 h-4 transition-transform', mobileDropdowns.kursy ? 'rotate-180' : '']"
              />
            </button>
            <div v-show="mobileDropdowns.kursy" class="pl-4 pb-2 bg-background">
              <router-link to="/kursy/podstawowy" class="block py-2 text-sm text-text-main hover:text-primary" @click="mobileMenuOpen = false">
                Kurs podstawowy ADR
              </router-link>
              <router-link to="/kursy/cysterny" class="block py-2 text-sm text-text-main hover:text-primary" @click="mobileMenuOpen = false">
                Kurs ADR - Cysterny
              </router-link>
              <a href="#" class="block py-2 text-sm text-text-main hover:text-primary" @click="mobileMenuOpen = false">
                Kurs odświeżający ADR
              </a>
            </div>
          </div>

          <!-- Mobile Przepisy Accordion -->
          <div class="border-t border-surface">
            <button 
              @click="toggleMobileDropdown('przepisy')"
              class="w-full flex items-center justify-between py-3 text-text-main hover:text-primary transition-colors font-medium"
            >
              PRZEPISY
              <ChevronDown 
                :class="['w-4 h-4 transition-transform', mobileDropdowns.przepisy ? 'rotate-180' : '']"
              />
            </button>
            <div v-show="mobileDropdowns.przepisy" class="pl-4 pb-2 bg-background">
              <router-link to="/przepisy/wstep" class="block py-2 text-sm text-text-main hover:text-primary" @click="mobileMenuOpen = false">
                Wstęp
              </router-link>
              <router-link to="/przepisy/klasyfikacja" class="block py-2 text-sm text-text-main hover:text-primary" @click="mobileMenuOpen = false">
                Klasyfikacja
              </router-link>
              <router-link to="/przepisy/zwolnienia" class="block py-2 text-sm text-text-main hover:text-primary" @click="mobileMenuOpen = false">
                Zwolnienia
              </router-link>
              <router-link to="/przepisy/oznakowanie" class="block py-2 text-sm text-text-main hover:text-primary" @click="mobileMenuOpen = false">
                Oznakowanie
              </router-link>
              <router-link to="/przepisy/zagrozenia" class="block py-2 text-sm text-text-main hover:text-primary" @click="mobileMenuOpen = false">
                Zagrożenia
              </router-link>
              <router-link to="/przepisy/tunele" class="block py-2 text-sm text-text-main hover:text-primary" @click="mobileMenuOpen = false">
                Tunele
              </router-link>
              <router-link to="/przepisy/dokument-przewozowy" class="block py-2 text-sm text-text-main hover:text-primary" @click="mobileMenuOpen = false">
                Dokument Przewozowy
              </router-link>
              <router-link to="/przepisy/instrukcja" class="block py-2 text-sm text-text-main hover:text-primary" @click="mobileMenuOpen = false">
                Instrukcja
              </router-link>
              <router-link to="/przepisy/cysterny" class="block py-2 text-sm text-text-main hover:text-primary" @click="mobileMenuOpen = false">
                Cysterny
              </router-link>
              <router-link to="/przepisy/hierarchizacja" class="block py-2 text-sm text-text-main hover:text-primary" @click="mobileMenuOpen = false">
                Hierarchizacja
              </router-link>
              <router-link to="/przepisy/klasa-1" class="block py-2 text-sm text-text-main hover:text-primary" @click="mobileMenuOpen = false">
                Klasa 1
              </router-link>
              <router-link to="/przepisy/klasa-7" class="block py-2 text-sm text-text-main hover:text-primary" @click="mobileMenuOpen = false">
                Klasa 7
              </router-link>
            </div>
          </div>

          <!-- Mobile Quizy Accordion -->
          <div class="border-t border-surface">
            <button 
              @click="toggleMobileDropdown('quizy')"
              class="w-full flex items-center justify-between py-3 text-text-main hover:text-primary transition-colors font-medium"
            >
              QUIZY
              <ChevronDown 
                :class="['w-4 h-4 transition-transform', mobileDropdowns.quizy ? 'rotate-180' : '']"
              />
            </button>
            <div v-show="mobileDropdowns.quizy" class="pl-4 pb-2 bg-background">
              <router-link to="/quizy/podstawowy" class="block py-2 text-sm text-text-main hover:text-primary" @click="mobileMenuOpen = false">
                Quiz podstawowy
              </router-link>
              <router-link to="/quizy/cysterny" class="block py-2 text-sm text-text-main hover:text-primary" @click="mobileMenuOpen = false">
                Quiz cysterny
              </router-link>
            </div>
          </div>

          <a 
            href="#kontakt" 
            @click="scrollToContact"
            class="block py-3 text-text-main hover:text-primary transition-colors font-medium border-t border-surface"
          >
            KONTAKT
          </a>
        </div>
      </div>
    </nav>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { ChevronDown } from 'lucide-vue-next'

// Mobile menu state
const mobileMenuOpen = ref(false)
const mobileDropdowns = ref({
  kursy: false,
  przepisy: false,
  quizy: false
})

// Mobile dropdown functions
const toggleMobileDropdown = (name) => {
  mobileDropdowns.value[name] = !mobileDropdowns.value[name]
}

// Scroll to contact section
const scrollToContact = (event) => {
  event.preventDefault()
  mobileMenuOpen.value = false
  const contactSection = document.getElementById('kontakt')
  if (contactSection) {
    contactSection.scrollIntoView({ 
      behavior: 'smooth',
      block: 'start'
    })
  }
}
</script>

<style scoped>
/* Ensure smooth transitions and proper z-index */
</style>

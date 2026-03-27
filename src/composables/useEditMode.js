import { ref, computed } from 'vue'
import { supabase } from '../lib/supabaseClient'

// Global state for edit mode - OUTSIDE the function to be shared
const isEditMode = ref(false)
const isAuthenticated = ref(false)
const currentUser = ref(null)
const isSaving = ref(false)
const editingElement = ref(null)

// Initialize auth state on module load
const initAuth = async () => {
  const { data: { user } } = await supabase.auth.getUser()
  isAuthenticated.value = !!user
  currentUser.value = user
}

// Run on module load
initAuth()

// Listen to auth changes
supabase.auth.onAuthStateChange((event, session) => {
  isAuthenticated.value = !!session?.user
  currentUser.value = session?.user || null
  
  // Disable edit mode on logout
  if (event === 'SIGNED_OUT') {
    isEditMode.value = false
    editingElement.value = null
  }
})

export function useEditMode() {
  // Check if user is authenticated
  const checkAuth = async () => {
    const { data: { user } } = await supabase.auth.getUser()
    isAuthenticated.value = !!user
    currentUser.value = user
    return !!user
  }

  // Toggle edit mode
  const toggleEditMode = async () => {
    if (!isAuthenticated.value) {
      const authenticated = await checkAuth()
      if (!authenticated) {
        // Redirect to login
        window.location.href = '/#/admin/login'
        return
      }
    }
    isEditMode.value = !isEditMode.value
  }

  // Enable edit mode
  const enableEditMode = () => {
    isEditMode.value = true
  }

  // Disable edit mode
  const disableEditMode = () => {
    isEditMode.value = false
    editingElement.value = null
  }

  // Logout
  const logout = async () => {
    await supabase.auth.signOut()
    isAuthenticated.value = false
    currentUser.value = null
    isEditMode.value = false
    editingElement.value = null
  }

  // Set editing element
  const setEditingElement = (element) => {
    editingElement.value = element
  }

  // Save content to database
  const saveContent = async (table, id, data) => {
    isSaving.value = true
    try {
      const { error } = await supabase
        .from(table)
        .update(data)
        .eq('id', id)

      if (error) throw error
      return { success: true }
    } catch (error) {
      console.error('Error saving content:', error)
      return { success: false, error }
    } finally {
      isSaving.value = false
    }
  }

  // Save page section
  const savePageSection = async (pageId, sections) => {
    return await saveContent('page_contents', pageId, { content_sections: sections })
  }

  // Save setting
  const saveSetting = async (settingKey, value) => {
    isSaving.value = true
    try {
      const { error } = await supabase
        .from('site_settings')
        .update({ setting_value: value })
        .eq('setting_key', settingKey)

      if (error) throw error
      return { success: true }
    } catch (error) {
      console.error('Error saving setting:', error)
      return { success: false, error }
    } finally {
      isSaving.value = false
    }
  }

  // Save hero content
  const saveHeroContent = async (heroId, data) => {
    return await saveContent('hero_content', heroId, data)
  }

  return {
    isEditMode: computed(() => isEditMode.value),
    isAuthenticated: computed(() => isAuthenticated.value),
    currentUser: computed(() => currentUser.value),
    isSaving: computed(() => isSaving.value),
    editingElement: computed(() => editingElement.value),
    toggleEditMode,
    enableEditMode,
    disableEditMode,
    logout,
    setEditingElement,
    saveContent,
    savePageSection,
    saveSetting,
    saveHeroContent,
    checkAuth,
  }
}

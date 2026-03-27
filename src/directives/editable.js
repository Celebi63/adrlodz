import { useEditMode } from '../composables/useEditMode'
import { watch } from 'vue'

export const editableDirective = {
  mounted(el, binding) {
    const { isEditMode } = useEditMode()
    
    // Store original content
    el._originalContent = el.innerText
    el._saveKey = binding.value?.key || null
    el._saveCallback = binding.value?.save || null
    el._label = binding.value?.label || 'Element'
    
    // Add editable class when in edit mode
    const updateEditableState = () => {
      if (isEditMode.value) {
        el.classList.add('v-editable')
        el.setAttribute('data-label', el._label)
      } else {
        el.classList.remove('v-editable', 'v-editable-editing')
        el.removeAttribute('contenteditable')
      }
    }
    
    // Handle click
    const handleClick = (e) => {
      if (!isEditMode.value) return
      
      e.stopPropagation()
      e.preventDefault()
      
      el.classList.add('v-editable-editing')
      el.setAttribute('contenteditable', 'true')
      el.focus()
      
      // Select all text
      const range = document.createRange()
      range.selectNodeContents(el)
      const sel = window.getSelection()
      sel.removeAllRanges()
      sel.addRange(range)
    }
    
    // Handle blur (save)
    const handleBlur = async (e) => {
      if (!el.hasAttribute('contenteditable')) return
      
      const newValue = e.target.innerText.trim()
      
      // Save if callback provided
      if (el._saveCallback && newValue !== el._originalContent) {
        try {
          await el._saveCallback(newValue)
          el._originalContent = newValue
        } catch (error) {
          console.error('Error saving:', error)
          el.innerText = el._originalContent
        }
      }
      
      el.classList.remove('v-editable-editing')
      el.removeAttribute('contenteditable')
    }
    
    // Handle Enter key
    const handleKeydown = (e) => {
      if (e.key === 'Enter' && !e.shiftKey) {
        e.preventDefault()
        el.blur()
      }
    }
    
    // Add event listeners
    el.addEventListener('click', handleClick)
    el.addEventListener('blur', handleBlur)
    el.addEventListener('keydown', handleKeydown)
    
    // Store cleanup function
    el._cleanup = () => {
      el.removeEventListener('click', handleClick)
      el.removeEventListener('blur', handleBlur)
      el.removeEventListener('keydown', handleKeydown)
    }
    
    // Initial state
    updateEditableState()
    
    // Watch for edit mode changes reactively (replaces setInterval)
    el._stopWatch = watch(isEditMode, () => {
      updateEditableState()
    })
  },
  
  unmounted(el) {
    if (el._cleanup) el._cleanup()
    if (el._stopWatch) el._stopWatch()
  }
}

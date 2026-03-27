<template>
  <component
    :is="tag"
    :class="[
      originalClass,
      isEditMode && editable ? 'editable-element' : '',
      isEditing ? 'is-editing' : ''
    ]"
    :contenteditable="isEditMode && editable && isEditing ? 'true' : 'false'"
    @click.stop="handleClick"
    @blur="handleBlur"
    @keydown.enter.prevent="handleEnter"
    v-bind="$attrs"
    ref="elementRef"
  >
    {{ displayValue }}
  </component>
</template>

<script setup>
import { ref, computed, watch } from 'vue'
import { useEditMode } from '../composables/useEditMode'

const props = defineProps({
  tag: {
    type: String,
    default: 'div'
  },
  editable: {
    type: Boolean,
    default: true
  },
  modelValue: {
    type: String,
    default: ''
  },
  saveCallback: {
    type: Function,
    required: false
  },
  label: {
    type: String,
    default: 'Element'
  },
  originalClass: {
    type: String,
    default: ''
  }
})

const emit = defineEmits(['update:modelValue', 'save'])

const { isEditMode, setEditingElement } = useEditMode()
const isEditing = ref(false)
const elementRef = ref(null)
const displayValue = ref(props.modelValue)

// Watch for changes in modelValue
watch(() => props.modelValue, (newVal) => {
  displayValue.value = newVal
})

const handleClick = (e) => {
  if (isEditMode.value && props.editable && !isEditing.value) {
    e.preventDefault()
    e.stopPropagation()
    
    isEditing.value = true
    setEditingElement({
      label: props.label,
      tag: props.tag
    })
    
    // Focus and select all text
    setTimeout(() => {
      if (elementRef.value) {
        elementRef.value.focus()
        
        // Select all text
        const range = document.createRange()
        range.selectNodeContents(elementRef.value)
        const sel = window.getSelection()
        sel.removeAllRanges()
        sel.addRange(range)
      }
    }, 50)
  }
}

const handleEnter = (e) => {
  // For single-line elements, blur on Enter
  if (props.tag !== 'p' && props.tag !== 'div' && props.tag !== 'textarea') {
    elementRef.value?.blur()
  }
}

const handleBlur = async (e) => {
  if (isEditing.value) {
    const newValue = e.target.innerText.trim()
    displayValue.value = newValue
    
    // Save the value
    if (props.saveCallback && newValue !== props.modelValue) {
      try {
        await props.saveCallback(newValue)
        emit('update:modelValue', newValue)
        emit('save', newValue)
      } catch (error) {
        console.error('Error saving:', error)
        // Revert on error
        displayValue.value = props.modelValue
      }
    }
    
    isEditing.value = false
    setEditingElement(null)
  }
}
</script>

<style scoped>
.editable-element {
  position: relative;
  cursor: pointer;
  transition: all 0.2s ease;
  min-height: 1.2em;
}

.editable-element:hover {
  outline: 2px dashed #ff6b35;
  outline-offset: 4px;
  background-color: rgba(255, 107, 53, 0.05);
}

.editable-element.is-editing {
  outline: 3px solid #ff6b35 !important;
  outline-offset: 4px;
  background-color: rgba(255, 107, 53, 0.1) !important;
  padding: 4px 8px !important;
  cursor: text !important;
}

.editable-element:hover::before {
  content: '✏️ Kliknij aby edytować';
  position: absolute;
  bottom: calc(100% + 8px);
  left: 0;
  background: #ff6b35;
  color: white;
  padding: 4px 12px;
  border-radius: 6px;
  font-size: 12px;
  font-weight: 600;
  white-space: nowrap;
  z-index: 1000;
  pointer-events: none;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
}

.editable-element.is-editing::before {
  content: '💾 Kliknij poza lub Enter aby zapisać';
  background: #10b981;
}

/* Remove default contenteditable styling */
[contenteditable="true"] {
  outline: 0px solid transparent;
}

[contenteditable="true"]:focus {
  outline: 0px solid transparent;
}
</style>

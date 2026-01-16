import { useState, useCallback } from 'react'

export const useToast = () => {
  const [toast, setToast] = useState(null)

  const showToast = useCallback((message, type = 'info') => {
    setToast({ message, type })
  }, [])

  const showSuccess = useCallback((message) => {
    showToast(message, 'success')
  }, [showToast])

  const showError = useCallback((message) => {
    showToast(message, 'error')
  }, [showToast])

  const hideToast = useCallback(() => {
    setToast(null)
  }, [])

  return {
    toast,
    showToast,
    showSuccess,
    showError,
    hideToast
  }
}

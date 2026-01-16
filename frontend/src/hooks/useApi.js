import { useState, useCallback } from 'react'
import api from '../services/api'

export const useApi = () => {
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState(null)

  const request = useCallback(async (method, url, data = null, config = {}) => {
    setLoading(true)
    setError(null)
    
    try {
      const response = await api[method](url, data, config)
      setLoading(false)
      return { data: response.data, error: null }
    } catch (err) {
      const errorMessage = err.response?.data?.error?.message || 'Error en la solicitud'
      setError(errorMessage)
      setLoading(false)
      return { data: null, error: errorMessage }
    }
  }, [])

  const get = useCallback((url, config) => request('get', url, null, config), [request])
  const post = useCallback((url, data, config) => request('post', url, data, config), [request])
  const put = useCallback((url, data, config) => request('put', url, data, config), [request])
  const patch = useCallback((url, data, config) => request('patch', url, data, config), [request])
  const del = useCallback((url, config) => request('delete', url, null, config), [request])

  return {
    loading,
    error,
    get,
    post,
    put,
    patch,
    delete: del,
    request
  }
}

import axios from 'axios'

const api = axios.create({
  baseURL: import.meta.env.VITE_API_URL || '',
  headers: {
    'Content-Type': 'application/json'
  }
})

api.interceptors.request.use(config => {
  if (config.method?.toLowerCase() === 'get' && typeof config.url === 'string' && config.url.startsWith('/api/')) {
    config.headers = {
      ...config.headers,
      'Cache-Control': 'no-cache, no-store, must-revalidate',
      Pragma: 'no-cache',
      Expires: '0'
    }

    config.params = {
      ...(config.params || {}),
      _ts: Date.now()
    }
  }

  return config
})

api.interceptors.response.use(
  response => response,
  error => {
    if (error.response?.status === 401) {
      // Don't redirect if we're on auth routes (login/register) — 
      // 401 there means bad credentials, not expired session
      const requestUrl = error.config?.url || ''
      const isAuthRequest = requestUrl.includes('/api/auth/login') || requestUrl.includes('/api/auth/register')

      if (!isAuthRequest) {
        localStorage.removeItem('token')
        delete api.defaults.headers.common['Authorization']
        window.location.href = '/login'
      }
    }
    return Promise.reject(error)
  }
)

export default api

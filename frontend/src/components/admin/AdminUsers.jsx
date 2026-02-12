import { useState, useEffect } from 'react'
import api from '../../services/api'
import Modal from '../Modal'
import Toast from '../Toast'

export default function AdminUsers() {
  const [users, setUsers] = useState([])
  const [showModal, setShowModal] = useState(false)
  const [showPasswordModal, setShowPasswordModal] = useState(false)
  const [selectedUser, setSelectedUser] = useState(null)
  const [formData, setFormData] = useState({
    dni: '',
    password: ''
  })
  const [toast, setToast] = useState(null)
  const [loading, setLoading] = useState(false)

  useEffect(() => {
    fetchUsers()
  }, [])

  const fetchUsers = async () => {
    try {
      const response = await api.get('/api/admin/users')
      if (response.data.ok) {
        setUsers(response.data.data)
      }
    } catch (error) {
      console.error('Error fetching users:', error)
    }
  }

  const handleSubmit = async (e) => {
    e.preventDefault()
    setLoading(true)

    try {
      const response = await api.post('/api/admin/users', formData)
      if (response.data.ok) {
        setToast({ message: 'Usuario creado exitosamente', type: 'success' })
        setShowModal(false)
        setFormData({ dni: '', password: '' })
        fetchUsers()
      }
    } catch (error) {
      setToast({ message: error.response?.data?.error?.message || 'Error al crear usuario', type: 'error' })
    } finally {
      setLoading(false)
    }
  }

  const handleUpdatePassword = async (e) => {
    e.preventDefault()
    setLoading(true)

    try {
      const response = await api.patch(`/api/admin/users/${selectedUser.dni}/password`, {
        password: formData.password
      })
      if (response.data.ok) {
        setToast({ message: 'Contraseña actualizada', type: 'success' })
        setShowPasswordModal(false)
        setSelectedUser(null)
        setFormData({ dni: '', password: '' })
      }
    } catch (error) {
      setToast({ message: error.response?.data?.error?.message || 'Error', type: 'error' })
    } finally {
      setLoading(false)
    }
  }

  const handleDelete = async (dni) => {
    if (!confirm('¿Estás seguro de eliminar este usuario? El jugador no podrá acceder a la plataforma.')) return

    try {
      await api.delete(`/api/admin/users/${dni}`)
      setToast({ message: 'Usuario eliminado', type: 'success' })
      fetchUsers()
    } catch (error) {
      setToast({ message: error.response?.data?.error?.message || 'Error', type: 'error' })
    }
  }

  const openPasswordModal = (user) => {
    setSelectedUser(user)
    setFormData({ dni: user.dni, password: '' })
    setShowPasswordModal(true)
  }

  return (
    <div>
      {toast && <Toast message={toast.message} type={toast.type} onClose={() => setToast(null)} />}

      <div className="flex justify-between items-center mb-6">
        <h2 className="text-2xl font-bold text-gray-900">Usuarios de Jugadores</h2>
        <button
          onClick={() => {
            setFormData({ dni: '', password: '' })
            setShowModal(true)
          }}
          className="bg-primary-600 text-white px-4 py-2 rounded-md hover:bg-primary-700"
        >
          Crear Usuario
        </button>
      </div>

      <div className="bg-primary-50 border border-primary-200 rounded-md p-4 mb-6">
        <p className="text-sm text-primary-800">
          <strong>Nota:</strong> Para crear un usuario, primero debe existir el perfil del jugador. 
          El usuario se vincula automáticamente con el perfil mediante el DNI.
        </p>
      </div>

      <div className="bg-white shadow overflow-hidden sm:rounded-lg">
        {/* Desktop View - Table */}
        <div className="hidden md:block">
          <table className="min-w-full divide-y divide-gray-200">
            <thead className="bg-gray-50">
              <tr>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">DNI</th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Nombre</th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Localidad</th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Género</th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Categoría</th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Rol</th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Acciones</th>
              </tr>
            </thead>
            <tbody className="bg-white divide-y divide-gray-200">
              {users.map(user => (
                <tr key={user.dni}>
                  <td className="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">
                    {user.dni}
                  </td>
                  <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                    {user.profile ? `${user.profile.nombre} ${user.profile.apellido}` : '-'}
                  </td>
                  <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                    {user.profile?.genero || '-'}
                  </td>
                  <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                    {user.profile?.categoriaBase?.name ? `${user.profile.categoriaBase.name} (${user.profile.categoriaBase.gender})` : '-'}
                  </td>
                  <td className="px-6 py-4 whitespace-nowrap">
                    <span className={`px-2 py-1 text-xs rounded ${
                      user.role === 'admin' ? 'bg-purple-100 text-purple-800' : 'bg-green-100 text-green-800'
                    }`}>
                      {user.role === 'admin' ? 'Admin' : 'Jugador'}
                    </span>
                  </td>
                  <td className="px-6 py-4 whitespace-nowrap text-sm space-x-3">
                    {user.role !== 'admin' && (
                      <>
                        <button
                          onClick={() => openPasswordModal(user)}
                          className="text-yellow-600 hover:text-yellow-900"
                        >
                          Cambiar Contraseña
                        </button>
                        <button
                          onClick={() => handleDelete(user.dni)}
                          className="text-red-600 hover:text-red-900"
                        >
                          Eliminar
                        </button>
                      </>
                    )}
                    {user.role === 'admin' && (
                      <span className="text-gray-400 text-xs">No editable</span>
                    )}
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>

        {/* Mobile View - Cards */}
        <div className="md:hidden">
          <ul className="divide-y divide-gray-200">
            {users.map(user => (
              <li key={user.dni} className="p-4">
                <div className="flex justify-between items-start mb-2">
                  <div>
                    <span className="block text-sm font-medium text-gray-900">
                       {user.profile ? `${user.profile.nombre} ${user.profile.apellido}` : 'Usuario sin perfil'}
                    </span>
                    <span className="block text-xs text-gray-500">DNI: {user.dni}</span>
                  </div>
                  <span className={`px-2 py-1 text-xs rounded ${
                    user.role === 'admin' ? 'bg-purple-100 text-purple-800' : 'bg-green-100 text-green-800'
                  }`}>
                    {user.role === 'admin' ? 'Admin' : 'Jugador'}
                  </span>
                </div>
                
                <div className="mb-3">
                  <span className="text-xs text-gray-500 block">Categoría: {user.profile?.categoriaBase?.name || '-'}</span>
                </div>

                <div className="flex justify-end gap-3 mt-2">
                   {user.role !== 'admin' ? (
                      <>
                        <button
                          onClick={() => openPasswordModal(user)}
                          className="text-xs border border-yellow-300 text-yellow-700 bg-yellow-50 px-2 py-1 rounded"
                        >
                          Contraseña
                        </button>
                        <button
                          onClick={() => handleDelete(user.dni)}
                          className="text-xs border border-red-300 text-red-700 bg-red-50 px-2 py-1 rounded"
                        >
                          Eliminar
                        </button>
                      </>
                    ) : (
                      <span className="text-gray-400 text-xs italic">Admin no editable</span>
                    )}
                </div>
              </li>
            ))}
          </ul>
        </div>

        {users.length === 0 && (
          <div className="text-center py-8 text-gray-500">
            No hay usuarios registrados
          </div>
        )}
      </div>

      <Modal isOpen={showModal} onClose={() => setShowModal(false)} title="Crear Usuario para Jugador">
        <form onSubmit={handleSubmit} className="space-y-4">
          <div>
            <label className="block text-sm font-medium text-gray-700">DNI del Jugador</label>
            <input
              type="text"
              value={formData.dni}
              onChange={(e) => setFormData({ ...formData, dni: e.target.value })}
              required
              className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-primary-500 focus:border-primary-500"
              placeholder="Ej: 30000001"
            />
            <p className="mt-1 text-xs text-gray-500">
              Debe existir un perfil de jugador con este DNI
            </p>
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700">Contraseña</label>
            <input
              type="password"
              value={formData.password}
              onChange={(e) => setFormData({ ...formData, password: e.target.value })}
              required
              minLength="4"
              className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-primary-500 focus:border-primary-500"
              placeholder="Mínimo 4 caracteres"
            />
          </div>
          <div className="flex justify-end space-x-3">
            <button type="button" onClick={() => setShowModal(false)} className="px-4 py-2 border border-gray-300 rounded-md text-sm font-medium text-gray-700 hover:bg-gray-50">
              Cancelar
            </button>
            <button type="submit" disabled={loading} className="px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-primary-600 hover:bg-primary-700 disabled:opacity-50">
              {loading ? 'Creando...' : 'Crear Usuario'}
            </button>
          </div>
        </form>
      </Modal>

      <Modal isOpen={showPasswordModal} onClose={() => setShowPasswordModal(false)} title="Cambiar Contraseña">
        <form onSubmit={handleUpdatePassword} className="space-y-4">
          <div>
            <label className="block text-sm font-medium text-gray-700">Usuario</label>
            <p className="mt-1 text-sm text-gray-900">
              {selectedUser?.profile ? `${selectedUser.profile.nombre} ${selectedUser.profile.apellido}` : selectedUser?.dni}
            </p>
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700">Nueva Contraseña</label>
            <input
              type="password"
              value={formData.password}
              onChange={(e) => setFormData({ ...formData, password: e.target.value })}
              required
              minLength="4"
              className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-primary-500 focus:border-primary-500"
              placeholder="Mínimo 4 caracteres"
            />
          </div>
          <div className="flex justify-end space-x-3">
            <button type="button" onClick={() => setShowPasswordModal(false)} className="px-4 py-2 border border-gray-300 rounded-md text-sm font-medium text-gray-700 hover:bg-gray-50">
              Cancelar
            </button>
            <button type="submit" disabled={loading} className="px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-primary-600 hover:bg-primary-700 disabled:opacity-50">
              {loading ? 'Actualizando...' : 'Actualizar Contraseña'}
            </button>
          </div>
        </form>
      </Modal>
    </div>
  )
}

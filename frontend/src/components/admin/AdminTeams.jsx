import { useState, useEffect } from 'react'
import api from '../../services/api'
import Modal from '../Modal'
import Toast from '../Toast'

export default function AdminTeams() {
  const [teams, setTeams] = useState([])
  const [filteredTeams, setFilteredTeams] = useState([])
  const [categories, setCategories] = useState([])
  const [selectedCategory, setSelectedCategory] = useState('')
  const [selectedStatus, setSelectedStatus] = useState('')
  const [showModal, setShowModal] = useState(false)
  const [formData, setFormData] = useState({
    player1_dni: '',
    player2_dni: ''
  })
  const [toast, setToast] = useState(null)
  const [loading, setLoading] = useState(false)

  useEffect(() => {
    fetchTeams()
    fetchCategories()
  }, [])

  useEffect(() => {
    filterTeams()
  }, [teams, selectedCategory, selectedStatus])

  const fetchTeams = async () => {
    try {
      const response = await api.get('/api/admin/teams')
      if (response.data.ok) {
        setTeams(response.data.data)
      }
    } catch (error) {
      console.error('Error fetching teams:', error)
    }
  }

  const fetchCategories = async () => {
    try {
      const response = await api.get('/api/categories')
      if (response.data.ok) {
        setCategories(response.data.data)
      }
    } catch (error) {
      console.error('Error fetching categories:', error)
    }
  }

  const filterTeams = () => {
    let filtered = [...teams]

    if (selectedCategory) {
      filtered = filtered.filter(team => 
        team.player1.categoria_base_id === parseInt(selectedCategory) ||
        team.player2.categoria_base_id === parseInt(selectedCategory)
      )
    }

    if (selectedStatus) {
      filtered = filtered.filter(team => team.estado === selectedStatus)
    }

    setFilteredTeams(filtered)
  }

  const handleSubmit = async (e) => {
    e.preventDefault()
    setLoading(true)

    try {
      const response = await api.post('/api/admin/teams', formData)
      if (response.data.ok) {
        setToast({ message: 'Pareja creada exitosamente', type: 'success' })
        setShowModal(false)
        setFormData({ player1_dni: '', player2_dni: '' })
        fetchTeams()
      }
    } catch (error) {
      setToast({ message: error.response?.data?.error?.message || 'Error al crear pareja', type: 'error' })
    } finally {
      setLoading(false)
    }
  }

  const handleToggleStatus = async (teamId, currentStatus) => {
    const newStatus = currentStatus === 'activa' ? 'inactiva' : 'activa'
    
    if (!confirm(`¿Cambiar estado de la pareja a ${newStatus}?`)) return

    try {
      const response = await api.patch(`/api/admin/teams/${teamId}/status`, { estado: newStatus })
      if (response.data.ok) {
        setToast({ message: 'Estado actualizado', type: 'success' })
        fetchTeams()
      }
    } catch (error) {
      setToast({ message: error.response?.data?.error?.message || 'Error', type: 'error' })
    }
  }

  return (
    <div>
      {toast && <Toast message={toast.message} type={toast.type} onClose={() => setToast(null)} />}

      <div className="flex justify-between items-center mb-6">
        <h2 className="text-2xl font-bold text-gray-900">Gestión de Parejas</h2>
        <button
          onClick={() => setShowModal(true)}
          className="bg-primary-600 text-white px-4 py-2 rounded-md hover:bg-primary-700"
        >
          Nueva Pareja
        </button>
      </div>

      <div className="mb-6 flex gap-4">
        <div className="flex-1">
          <label className="block text-sm font-medium text-gray-700 mb-2">Filtrar por Categoría</label>
          <select
            value={selectedCategory}
            onChange={(e) => setSelectedCategory(e.target.value)}
            className="block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-primary-500 focus:border-primary-500"
          >
            <option value="">Todas las categorías</option>
            {categories.map(cat => (
              <option key={cat.id} value={cat.id}>{cat.name}</option>
            ))}
          </select>
        </div>
        <div className="flex-1">
          <label className="block text-sm font-medium text-gray-700 mb-2">Filtrar por Estado</label>
          <select
            value={selectedStatus}
            onChange={(e) => setSelectedStatus(e.target.value)}
            className="block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-primary-500 focus:border-primary-500"
          >
            <option value="">Todos los estados</option>
            <option value="activa">Activa</option>
            <option value="inactiva">Inactiva</option>
          </select>
        </div>
      </div>

      <div className="bg-white shadow overflow-hidden sm:rounded-lg">
        {/* Desktop View - Table */}
        <div className="hidden md:block">
          <table className="min-w-full divide-y divide-gray-200">
            <thead className="bg-gray-50">
              <tr>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Jugador 1</th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Categoría</th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Jugador 2</th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Categoría</th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Estado</th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Acciones</th>
              </tr>
            </thead>
            <tbody className="bg-white divide-y divide-gray-200">
              {filteredTeams.map(team => (
                <tr key={team.id}>
                  <td className="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">
                    {team.player1.nombre} {team.player1.apellido}
                    <div className="text-xs text-gray-500">DNI: {team.player1.dni}</div>
                  </td>
                  <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                    {team.player1.categoriaBase.name}
                  </td>
                  <td className="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">
                    {team.player2.nombre} {team.player2.apellido}
                    <div className="text-xs text-gray-500">DNI: {team.player2.dni}</div>
                  </td>
                  <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                    {team.player2.categoriaBase.name}
                  </td>
                  <td className="px-6 py-4 whitespace-nowrap">
                    <span className={`px-2 py-1 text-xs rounded ${
                      team.estado === 'activa' ? 'bg-green-100 text-green-800' : 'bg-gray-100 text-gray-800'
                    }`}>
                      {team.estado}
                    </span>
                  </td>
                  <td className="px-6 py-4 whitespace-nowrap text-sm">
                    <button
                      onClick={() => handleToggleStatus(team.id, team.estado)}
                      className={`${
                        team.estado === 'activa' 
                          ? 'text-yellow-600 hover:text-yellow-900' 
                          : 'text-green-600 hover:text-green-900'
                      }`}
                    >
                      {team.estado === 'activa' ? 'Desactivar' : 'Activar'}
                    </button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>

        {/* Mobile View - Cards */}
        <div className="md:hidden">
          <ul className="divide-y divide-gray-200">
            {filteredTeams.map(team => (
              <li key={team.id} className="p-4">
                <div className="flex justify-between items-start mb-3">
                  <div className="flex-1">
                    <div className="mb-2">
                       <p className="text-sm font-bold text-gray-900">Jugador 1:</p>
                       <p className="text-sm text-gray-800">{team.player1.nombre} {team.player1.apellido}</p>
                       <p className="text-xs text-gray-500">Cat: {team.player1.categoriaBase.name}</p>
                    </div>
                    <div>
                       <p className="text-sm font-bold text-gray-900">Jugador 2:</p>
                       <p className="text-sm text-gray-800">{team.player2.nombre} {team.player2.apellido}</p>
                       <p className="text-xs text-gray-500">Cat: {team.player2.categoriaBase.name}</p>
                    </div>
                  </div>
                  <div>
                    <span className={`px-2 py-1 text-xs rounded ${
                      team.estado === 'activa' ? 'bg-green-100 text-green-800' : 'bg-gray-100 text-gray-800'
                    }`}>
                      {team.estado}
                    </span>
                  </div>
                </div>
                
                <div className="flex justify-end pt-2 border-t border-gray-100">
                    <button
                      onClick={() => handleToggleStatus(team.id, team.estado)}
                      className={`text-sm font-medium ${
                        team.estado === 'activa' 
                          ? 'text-yellow-600 hover:text-yellow-900' 
                          : 'text-green-600 hover:text-green-900'
                      }`}
                    >
                      {team.estado === 'activa' ? '🔴 Desactivar Pareja' : '🟢 Activar Pareja'}
                    </button>
                </div>
              </li>
            ))}
          </ul>
        </div>

        {filteredTeams.length === 0 && (
          <div className="text-center py-8 text-gray-500">
            No se encontraron parejas con los filtros seleccionados
          </div>
        )}
      </div>

      <Modal isOpen={showModal} onClose={() => setShowModal(false)} title="Nueva Pareja">
        <form onSubmit={handleSubmit} className="space-y-4">
          <div>
            <label className="block text-sm font-medium text-gray-700">DNI Jugador 1</label>
            <input
              type="text"
              value={formData.player1_dni}
              onChange={(e) => setFormData({ ...formData, player1_dni: e.target.value })}
              required
              className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-primary-500 focus:border-primary-500"
              placeholder="Ej: 30000001"
            />
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700">DNI Jugador 2</label>
            <input
              type="text"
              value={formData.player2_dni}
              onChange={(e) => setFormData({ ...formData, player2_dni: e.target.value })}
              required
              className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-primary-500 focus:border-primary-500"
              placeholder="Ej: 30000002"
            />
          </div>
          <div className="bg-primary-50 border border-primary-200 rounded-md p-3">
            <p className="text-sm text-primary-800">
              <strong>Nota:</strong> Los jugadores deben estar registrados en el sistema previamente.
            </p>
          </div>
          <div className="flex justify-end space-x-3">
            <button 
              type="button" 
              onClick={() => setShowModal(false)} 
              className="px-4 py-2 border border-gray-300 rounded-md text-sm font-medium text-gray-700 hover:bg-gray-50"
            >
              Cancelar
            </button>
            <button 
              type="submit" 
              disabled={loading} 
              className="px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-primary-600 hover:bg-primary-700 disabled:opacity-50"
            >
              {loading ? 'Creando...' : 'Crear Pareja'}
            </button>
          </div>
        </form>
      </Modal>
    </div>
  )
}

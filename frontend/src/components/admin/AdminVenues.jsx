import { useState, useEffect } from 'react'
import api from '../../services/api'
import Modal from '../Modal'
import Toast from '../Toast'

export default function AdminVenues() {
  const [venues, setVenues] = useState([])
  const [showModal, setShowModal] = useState(false)
  const [editingVenue, setEditingVenue] = useState(null)
  const [formData, setFormData] = useState({
    name: '',
    address: '',
    courts_count: 1
  })
  const [toast, setToast] = useState(null)
  const [loading, setLoading] = useState(false)

  useEffect(() => {
    fetchVenues()
  }, [])

  const fetchVenues = async () => {
    try {
      const response = await api.get('/api/admin/venues')
      if (response.data.ok) {
        setVenues(response.data.data)
      }
    } catch (error) {
      console.error('Error fetching venues:', error)
    }
  }

  const handleSubmit = async (e) => {
    e.preventDefault()
    setLoading(true)

    try {
      if (editingVenue) {
        const response = await api.put(`/api/admin/venues/${editingVenue.id}`, formData)
        if (response.data.ok) {
          setToast({ message: 'Complejo actualizado', type: 'success' })
        }
      } else {
        const response = await api.post('/api/admin/venues', formData)
        if (response.data.ok) {
          setToast({ message: 'Complejo creado', type: 'success' })
        }
      }
      setShowModal(false)
      setFormData({ name: '', address: '', courts_count: 1 })
      setEditingVenue(null)
      fetchVenues()
    } catch (error) {
      setToast({ message: error.response?.data?.error?.message || 'Error', type: 'error' })
    } finally {
      setLoading(false)
    }
  }

  const handleEdit = (venue) => {
    setEditingVenue(venue)
    setFormData({
      name: venue.name,
      address: venue.address || '',
      courts_count: venue.courts_count || 1
    })
    setShowModal(true)
  }

  const handleDelete = async (id) => {
    if (!confirm('¿Estás seguro de eliminar este complejo?')) return

    try {
      await api.delete(`/api/admin/venues/${id}`)
      setToast({ message: 'Complejo eliminado', type: 'success' })
      fetchVenues()
    } catch (error) {
      setToast({ message: error.response?.data?.error?.message || 'Error', type: 'error' })
    }
  }

  const handleToggleActive = async (venue) => {
    try {
      const response = await api.put(`/api/admin/venues/${venue.id}`, {
        ...venue,
        active: !venue.active
      })
      if (response.data.ok) {
        setToast({ message: 'Estado actualizado', type: 'success' })
        fetchVenues()
      }
    } catch (error) {
      setToast({ message: error.response?.data?.error?.message || 'Error', type: 'error' })
    }
  }

  return (
    <div>
      {toast && <Toast message={toast.message} type={toast.type} onClose={() => setToast(null)} />}

      <div className="flex justify-between items-center mb-6">
        <h2 className="text-2xl font-bold text-gray-900">Complejos</h2>
        <button
          onClick={() => {
            setEditingVenue(null)
            setFormData({ name: '', address: '', courts_count: 1 })
            setShowModal(true)
          }}
          className="bg-primary-600 text-white px-4 py-2 rounded-md hover:bg-primary-700"
        >
          Nuevo Complejo
        </button>
      </div>

      <div className="bg-white shadow overflow-hidden sm:rounded-lg">
        {/* Desktop View - Table */}
        <div className="hidden md:block">
          <table className="min-w-full divide-y divide-gray-200">
            <thead className="bg-gray-50">
              <tr>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Nombre</th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Dirección</th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Canchas</th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Estado</th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Acciones</th>
              </tr>
            </thead>
            <tbody className="bg-white divide-y divide-gray-200">
              {venues.map(venue => (
                <tr key={venue.id}>
                  <td className="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">
                    {venue.name}
                  </td>
                  <td className="px-6 py-4 text-sm text-gray-500">
                    {venue.address || '-'}
                  </td>
                  <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                    {venue.courts_count}
                  </td>
                  <td className="px-6 py-4 whitespace-nowrap">
                    <span className={`px-2 py-1 text-xs rounded ${
                      venue.active ? 'bg-green-100 text-green-800' : 'bg-gray-100 text-gray-800'
                    }`}>
                      {venue.active ? 'Activo' : 'Inactivo'}
                    </span>
                  </td>
                  <td className="px-6 py-4 whitespace-nowrap text-sm space-x-3">
                    <button
                      onClick={() => handleEdit(venue)}
                      className="text-primary-600 hover:text-primary-900"
                    >
                      Editar
                    </button>
                    <button
                      onClick={() => handleToggleActive(venue)}
                      className="text-yellow-600 hover:text-yellow-900"
                    >
                      {venue.active ? 'Desactivar' : 'Activar'}
                    </button>
                    <button
                      onClick={() => handleDelete(venue.id)}
                      className="text-red-600 hover:text-red-900"
                    >
                      Eliminar
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
            {venues.map(venue => (
              <li key={venue.id} className="p-4">
                <div className="flex justify-between items-start mb-2">
                  <div>
                    <span className="block text-sm font-bold text-gray-900">{venue.name}</span>
                    <span className="block text-xs text-gray-500">{venue.address || 'Sin dirección'}</span>
                    <span className="block text-xs text-gray-500">Canchas: {venue.courts_count}</span>
                  </div>
                  <span className={`px-2 py-1 text-xs rounded ${
                    venue.active ? 'bg-green-100 text-green-800' : 'bg-gray-100 text-gray-800'
                  }`}>
                    {venue.active ? 'Activo' : 'Inactivo'}
                  </span>
                </div>
                
                <div className="flex justify-end gap-3 mt-3 pt-3 border-t border-gray-100">
                    <button
                      onClick={() => handleEdit(venue)}
                      className="text-sm font-medium text-primary-600 hover:text-primary-900"
                    >
                      Editar
                    </button>
                    <button
                      onClick={() => handleToggleActive(venue)}
                      className="text-sm font-medium text-yellow-600 hover:text-yellow-900"
                    >
                      {venue.active ? 'Desactivar' : 'Activar'}
                    </button>
                    <button
                      onClick={() => handleDelete(venue.id)}
                      className="text-sm font-medium text-red-600 hover:text-red-900"
                    >
                      Eliminar
                    </button>
                </div>
              </li>
            ))}
          </ul>
        </div>
      </div>

      <Modal isOpen={showModal} onClose={() => setShowModal(false)} title={editingVenue ? 'Editar Complejo' : 'Nuevo Complejo'}>
        <form onSubmit={handleSubmit} className="space-y-4">
          <div>
            <label className="block text-sm font-medium text-gray-700">Nombre</label>
            <input
              type="text"
              value={formData.name}
              onChange={(e) => setFormData({ ...formData, name: e.target.value })}
              required
              className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-primary-500 focus:border-primary-500"
              placeholder="Ej: Club Deportivo Central"
            />
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700">Dirección</label>
            <input
              type="text"
              value={formData.address}
              onChange={(e) => setFormData({ ...formData, address: e.target.value })}
              className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-primary-500 focus:border-primary-500"
              placeholder="Ej: Av. Principal 123"
            />
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700">Cantidad de Canchas</label>
            <input
              type="number"
              min="1"
              value={formData.courts_count}
              onChange={(e) => setFormData({ ...formData, courts_count: parseInt(e.target.value) })}
              required
              className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-primary-500 focus:border-primary-500"
            />
          </div>
          <div className="flex justify-end space-x-3">
            <button type="button" onClick={() => setShowModal(false)} className="px-4 py-2 border border-gray-300 rounded-md text-sm font-medium text-gray-700 hover:bg-gray-50">
              Cancelar
            </button>
            <button type="submit" disabled={loading} className="px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-primary-600 hover:bg-primary-700 disabled:opacity-50">
              {loading ? 'Guardando...' : 'Guardar'}
            </button>
          </div>
        </form>
      </Modal>
    </div>
  )
}

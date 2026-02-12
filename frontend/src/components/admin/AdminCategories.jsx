import { useState, useEffect } from 'react'
import api from '../../services/api'
import Modal from '../Modal'
import Toast from '../Toast'

export default function AdminCategories() {
  const [categories, setCategories] = useState([])
  const [showModal, setShowModal] = useState(false)
  const [editingCategory, setEditingCategory] = useState(null)
  const [formData, setFormData] = useState({ name: '', rank: '', gender: 'caballeros' })
  const [toast, setToast] = useState(null)
  const [loading, setLoading] = useState(false)

  useEffect(() => {
    fetchCategories()
  }, [])

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

  const handleSubmit = async (e) => {
    e.preventDefault()
    setLoading(true)

    try {
      if (editingCategory) {
        const response = await api.put(`/api/admin/categories/${editingCategory.id}`, formData)
        if (response.data.ok) {
          setToast({ message: 'Categoría actualizada', type: 'success' })
        }
      } else {
        const response = await api.post('/api/admin/categories', formData)
        if (response.data.ok) {
          setToast({ message: 'Categoría creada', type: 'success' })
        }
      }
      setShowModal(false)
      setFormData({ name: '', rank: '', gender: 'caballeros' })
      setEditingCategory(null)
      fetchCategories()
    } catch (error) {
      setToast({ message: error.response?.data?.error?.message || 'Error', type: 'error' })
    } finally {
      setLoading(false)
    }
  }

  const handleEdit = (category) => {
    setEditingCategory(category)
    setFormData({ name: category.name, rank: category.rank, gender: category.gender || 'caballeros' })
    setShowModal(true)
  }

  const handleDelete = async (id) => {
    if (!confirm('¿Estás seguro de desactivar esta categoría?')) return

    try {
      await api.delete(`/api/admin/categories/${id}`)
      setToast({ message: 'Categoría desactivada', type: 'success' })
      fetchCategories()
    } catch (error) {
      setToast({ message: error.response?.data?.error?.message || 'Error', type: 'error' })
    }
  }

  return (
    <div>
      {toast && <Toast message={toast.message} type={toast.type} onClose={() => setToast(null)} />}

      <div className="flex justify-between items-center mb-6">
        <h2 className="text-2xl font-bold text-gray-900">Categorías</h2>
        <button
          onClick={() => {
            setEditingCategory(null)
            setFormData({ name: '', rank: '' })
            setShowModal(true)
          }}
          className="bg-primary-600 text-white px-4 py-2 rounded-md hover:bg-primary-700"
        >
          Nueva Categoría
        </button>
      </div>

      <div className="bg-white shadow overflow-hidden sm:rounded-lg">
        {/* Desktop View - Table */}
        <div className="hidden md:block">
          <table className="min-w-full divide-y divide-gray-200">
            <thead className="bg-gray-50">
              <tr>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Nombre</th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Género</th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Rank</th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Estado</th>
                <th className="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase">Acciones</th>
              </tr>
            </thead>
            <tbody className="bg-white divide-y divide-gray-200">
              {categories.map(category => (
                <tr key={category.id}>
                  <td className="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">{category.name}</td>
                  <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500 capitalize">{category.gender}</td>
                  <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">{category.rank}</td>
                  <td className="px-6 py-4 whitespace-nowrap">
                    <span className={`px-2 py-1 text-xs rounded ${category.active ? 'bg-green-100 text-green-800' : 'bg-gray-100 text-gray-800'}`}>
                      {category.active ? 'Activa' : 'Inactiva'}
                    </span>
                  </td>
                  <td className="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                    <button onClick={() => handleEdit(category)} className="text-primary-600 hover:text-primary-900 mr-4">
                      Editar
                    </button>
                    <button onClick={() => handleDelete(category.id)} className="text-red-600 hover:text-red-900">
                      Desactivar
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
            {categories.map(category => (
              <li key={category.id} className="p-4">
                <div className="flex justify-between items-start mb-2">
                  <div>
                    <span className="block text-sm font-bold text-gray-900">{category.name} <span className="text-xs font-normal text-gray-500 capitalize">({category.gender})</span></span>
                    <span className="block text-xs text-gray-500">Rank/Orden: {category.rank}</span>
                  </div>
                  <span className={`px-2 py-1 text-xs rounded ${category.active ? 'bg-green-100 text-green-800' : 'bg-gray-100 text-gray-800'}`}>
                      {category.active ? 'Activa' : 'Inactiva'}
                  </span>
                </div>
                
                <div className="flex justify-end gap-3 mt-3 pt-3 border-t border-gray-100">
                   <button onClick={() => handleEdit(category)} className="text-sm font-medium text-primary-600 hover:text-primary-900">
                      Editar
                   </button>
                   <button onClick={() => handleDelete(category.id)} className="text-sm font-medium text-red-600 hover:text-red-900">
                      Desactivar
                   </button>
                </div>
              </li>
            ))}
          </ul>
        </div>
      </div>

      <Modal isOpen={showModal} onClose={() => setShowModal(false)} title={editingCategory ? 'Editar Categoría' : 'Nueva Categoría'}>
        <form onSubmit={handleSubmit} className="space-y-4">
          <div>
            <label className="block text-sm font-medium text-gray-700">Nombre</label>
            <input
              type="text"
              value={formData.name}
              onChange={(e) => setFormData({ ...formData, name: e.target.value })}
              required
              className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-primary-500 focus:border-primary-500"
            />
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700">Género</label>
            <select
              value={formData.gender}
              onChange={(e) => setFormData({ ...formData, gender: e.target.value })}
              className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-primary-500 focus:border-primary-500"
            >
              <option value="caballeros">Caballeros</option>
              <option value="damas">Damas</option>
            </select>
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700">Rank (menor = más alto)</label>
            <input
              type="number"
              value={formData.rank}
              onChange={(e) => setFormData({ ...formData, rank: e.target.value })}
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

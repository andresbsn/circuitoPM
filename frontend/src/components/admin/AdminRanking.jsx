import { useState, useEffect } from 'react';
import api from '../../services/api';

export default function AdminRanking() {
  const [ranking, setRanking] = useState([]);
  const [categories, setCategories] = useState([]);
  const [selectedCategory, setSelectedCategory] = useState('');
  const [loading, setLoading] = useState(false);
  const [toast, setToast] = useState(null);

  useEffect(() => {
    fetchCategories();
  }, []);

  useEffect(() => {
    if (toast) {
      const timer = setTimeout(() => setToast(null), 3000);
      return () => clearTimeout(timer);
    }
  }, [toast]);

  const fetchCategories = async () => {
    try {
      const response = await api.get('/api/player/categories');
      if (response.data.ok) {
        setCategories(response.data.data);
      }
    } catch (error) {
      console.error('Error loading categories:', error);
    }
  };

  const fetchRanking = async (categoryId) => {
    if (!categoryId) {
      setRanking([]);
      return;
    }

    setLoading(true);
    try {
      const response = await api.get(`/api/public/ranking?category_id=${categoryId}`);
      if (response.data.ok) {
        setRanking(response.data.data);
      }
    } catch (error) {
      console.error('Error loading ranking:', error);
      setToast({ message: 'Error al cargar ranking', type: 'error' });
    } finally {
      setLoading(false);
    }
  };

  const handleCategoryChange = (e) => {
    const categoryId = e.target.value;
    setSelectedCategory(categoryId);
    fetchRanking(categoryId);
  };

  return (
    <div className="max-w-7xl mx-auto">
      {toast && (
        <div className={`fixed top-4 right-4 px-6 py-3 rounded-lg shadow-lg ${
          toast.type === 'success' ? 'bg-green-500' : 'bg-red-500'
        } text-white z-50`}>
          {toast.message}
        </div>
      )}

      <div className="mb-6">
        <h2 className="text-2xl font-bold text-gray-900 mb-4">Ranking de Jugadores por Categoría</h2>
        
        <div className="bg-primary-50 border border-primary-200 rounded-lg p-4 mb-4">
          <p className="text-sm text-primary-800">
            ℹ️ Los puntos son <strong>independientes por categoría</strong>. Un jugador puede tener puntos diferentes en cada categoría que juegue.
          </p>
        </div>

        <div className="flex gap-4 items-center">
          <div className="flex-1">
            <label className="block text-sm font-medium text-gray-700 mb-2">
              Seleccionar Categoría *
            </label>
            <select
              value={selectedCategory}
              onChange={handleCategoryChange}
              className="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-primary-500 focus:border-primary-500"
            >
              <option value="">-- Seleccione una categoría --</option>
              {categories.map(cat => (
                <option key={cat.id} value={cat.id}>{cat.name} ({cat.gender})</option>
              ))}
            </select>
          </div>
        </div>
      </div>

      {loading ? (
        <div className="text-center py-12">
          <div className="inline-block animate-spin rounded-full h-8 w-8 border-b-2 border-primary-600"></div>
          <p className="mt-2 text-gray-600">Cargando ranking...</p>
        </div>
      ) : !selectedCategory ? (
        <div className="bg-white rounded-lg shadow p-6 text-center text-gray-500">
          <p className="text-lg mb-2">👆 Seleccione una categoría para ver el ranking</p>
          <p className="text-sm">Los puntos son independientes por categoría</p>
        </div>
      ) : ranking.length === 0 ? (
        <div className="bg-white rounded-lg shadow p-6 text-center text-gray-500">
          No hay jugadores con puntos en esta categoría
        </div>
      ) : (
        <div className="bg-white rounded-lg shadow overflow-hidden">
          {/* Desktop View - Table */}
          <div className="hidden md:block">
            <table className="min-w-full divide-y divide-gray-200">
              <thead className="bg-gray-50">
                <tr>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                    Posición
                  </th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                    Jugador
                  </th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                    DNI
                  </th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                    Categoría
                  </th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                    Puntos Totales
                  </th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                    Torneos Jugados
                  </th>
                </tr>
              </thead>
              <tbody className="bg-white divide-y divide-gray-200">
                {ranking.map((player, index) => (
                  <tr key={player.dni} className={index < 3 ? 'bg-yellow-50' : ''}>
                    <td className="px-6 py-4 whitespace-nowrap">
                      <div className="flex items-center">
                        {index === 0 && <span className="text-2xl mr-2">🥇</span>}
                        {index === 1 && <span className="text-2xl mr-2">🥈</span>}
                        {index === 2 && <span className="text-2xl mr-2">🥉</span>}
                        <span className="text-sm font-medium text-gray-900">
                          {index + 1}
                        </span>
                      </div>
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap">
                      <div className="text-sm font-medium text-gray-900">
                        {player.nombre} {player.apellido}
                      </div>
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                      {player.dni}
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap">
                      <span className="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-primary-100 text-primary-800">
                        {player.categoria}
                      </span>
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap">
                      <span className="text-lg font-bold text-primary-600">
                        {player.totalPoints}
                      </span>
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                      {player.tournamentsPlayed}
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>

          {/* Mobile View - Cards */}
          <div className="md:hidden">
            <ul className="divide-y divide-gray-200">
              {ranking.map((player, index) => (
                <li key={player.dni} className={`p-4 ${index < 3 ? 'bg-yellow-50' : 'bg-white'}`}>
                  <div className="flex items-center justify-between mb-2">
                    <div className="flex items-center gap-2">
                      <span className="font-bold text-lg w-8 text-center">{index + 1}</span>
                      {index === 0 && <span className="text-xl">🥇</span>}
                      {index === 1 && <span className="text-xl">🥈</span>}
                      {index === 2 && <span className="text-xl">🥉</span>}
                      <span className="font-medium text-gray-900">{player.nombre} {player.apellido}</span>
                    </div>
                    <span className="px-2 py-0.5 text-xs font-semibold rounded-full bg-primary-100 text-primary-800">
                      {player.categoria}
                    </span>
                  </div>
                  
                  <div className="grid grid-cols-2 gap-2 mt-2 text-sm">
                    <div className="text-gray-500">
                      <span className="block text-xs uppercase">Puntos</span>
                      <span className="text-primary-600 font-bold text-lg">{player.totalPoints}</span>
                    </div>
                     <div className="text-gray-500 text-right">
                      <span className="block text-xs uppercase">Torneos</span>
                      <span className="text-gray-900 font-medium">{player.tournamentsPlayed}</span>
                    </div>
                  </div>
                  <div className="mt-1 text-xs text-gray-400">
                    DNI: {player.dni}
                  </div>
                </li>
              ))}
            </ul>
          </div>
        </div>
      )}

      <div className="mt-6 bg-primary-50 border border-primary-200 rounded-lg p-4">
        <h3 className="text-sm font-semibold text-primary-900 mb-2">Sistema de Puntos</h3>
        <div className="grid grid-cols-2 md:grid-cols-3 gap-2 text-sm text-primary-800">
          <div>🏆 Campeón: <span className="font-bold">10 puntos</span></div>
          <div>🥈 Subcampeón: <span className="font-bold">8 puntos</span></div>
          <div>🎯 Semifinal: <span className="font-bold">6 puntos</span></div>
          <div>📊 Cuartos: <span className="font-bold">4 puntos</span></div>
          <div>📈 Octavos: <span className="font-bold">2 puntos</span></div>
          <div>✅ Zona: <span className="font-bold">1 punto</span></div>
        </div>
      </div>
    </div>
  );
}

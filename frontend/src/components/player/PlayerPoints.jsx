import { useState, useEffect } from 'react';
import { useAuth } from '../../context/AuthContext';
import api from '../../services/api';

export default function PlayerPoints() {
  const { user } = useAuth();
  const [playerData, setPlayerData] = useState(null);
  const [loading, setLoading] = useState(false);
  const [toast, setToast] = useState(null);

  useEffect(() => {
    if (user?.dni) {
      fetchPlayerPoints();
    }
  }, [user]);

  useEffect(() => {
    if (toast) {
      const timer = setTimeout(() => setToast(null), 3000);
      return () => clearTimeout(timer);
    }
  }, [toast]);

  const fetchPlayerPoints = async () => {
    setLoading(true);
    try {
      const response = await api.get(`/api/public/ranking/player/${user.dni}`);
      if (response.data.ok) {
        setPlayerData(response.data.data);
      }
    } catch (error) {
      console.error('Error loading player points:', error);
      setToast({ message: 'Error al cargar puntos', type: 'error' });
    } finally {
      setLoading(false);
    }
  };

  if (loading) {
    return (
      <div className="text-center py-12">
        <div className="inline-block animate-spin rounded-full h-8 w-8 border-b-2 border-primary-600"></div>
        <p className="mt-2 text-gray-600">Cargando puntos...</p>
      </div>
    );
  }

  if (!playerData) {
    return (
      <div className="bg-white rounded-lg shadow p-6 text-center text-gray-500">
        No hay datos de puntos disponibles
      </div>
    );
  }

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
        <h2 className="text-2xl font-bold text-gray-900 mb-2">Mis Puntos</h2>
        <p className="text-gray-600">
          {playerData.player.nombre} {playerData.player.apellido} (DNI: {playerData.player.dni})
        </p>
      </div>

      <div className="bg-primary-50 border border-primary-200 rounded-lg p-4 mb-6">
        <p className="text-sm text-primary-800">
          ℹ️ Los puntos son <strong>independientes por categoría</strong>. Tus puntos en cada categoría se acumulan por separado.
        </p>
      </div>

      {playerData.categories.length === 0 ? (
        <div className="bg-white rounded-lg shadow p-6 text-center text-gray-500">
          <p className="text-lg mb-2">Aún no has acumulado puntos</p>
          <p className="text-sm">Participa en torneos para comenzar a sumar puntos</p>
        </div>
      ) : (
        <div className="space-y-6">
          {playerData.categories.map(category => (
            <div key={category.categoryId} className="bg-white rounded-lg shadow overflow-hidden">
              <div className="bg-gradient-to-r from-primary-600 to-primary-700 px-6 py-4">
                <div className="flex justify-between items-center">
                  <h3 className="text-xl font-bold text-white">{category.categoryName}</h3>
                  <div className="text-right">
                    <p className="text-3xl font-bold text-white">{category.totalPoints}</p>
                    <p className="text-sm text-primary-100">puntos totales</p>
                  </div>
                </div>
                <p className="text-sm text-primary-100 mt-2">
                  {category.tournamentsPlayed} {category.tournamentsPlayed === 1 ? 'torneo jugado' : 'torneos jugados'}
                </p>
              </div>

              <div className="p-6">
                <h4 className="text-sm font-semibold text-gray-700 mb-3">Historial de Torneos</h4>
                <div className="space-y-3">
                  {category.pointsHistory.map((history, index) => (
                    <div key={index} className="flex justify-between items-center border-b border-gray-200 pb-3">
                      <div className="flex-1">
                        <div className="flex items-center gap-2">
                          <p className="text-sm font-medium text-gray-900">{history.tournament}</p>
                          {history.isDoublePoints && (
                            <span className="px-1.5 py-0.5 text-xs font-semibold rounded bg-yellow-100 text-yellow-800">
                              ⭐x2
                            </span>
                          )}
                        </div>
                        <p className="text-xs text-gray-500">
                          {new Date(history.date).toLocaleDateString('es-AR')}
                        </p>
                      </div>
                      <div className="text-right">
                        <span className={`inline-flex items-center px-3 py-1 rounded-full text-sm font-semibold ${
                          history.position === 'Campeón' ? 'bg-yellow-100 text-yellow-800' :
                          history.position === 'Subcampeón' ? 'bg-gray-100 text-gray-800' :
                          history.position === 'Semifinal' ? 'bg-orange-100 text-orange-800' :
                          history.position === 'Cuartos de Final' ? 'bg-primary-100 text-primary-800' :
                          history.position === 'Octavos de Final' ? 'bg-green-100 text-green-800' :
                          'bg-gray-100 text-gray-600'
                        }`}>
                          {history.position === 'Campeón' && '🏆 '}
                          {history.position === 'Subcampeón' && '🥈 '}
                          {history.position}
                        </span>
                        <p className="text-lg font-bold text-primary-600 mt-1">
                          +{history.points} pts
                        </p>
                      </div>
                    </div>
                  ))}
                </div>
              </div>
            </div>
          ))}
        </div>
      )}

      <div className="mt-6 bg-white rounded-lg shadow p-6">
        <h3 className="text-sm font-semibold text-gray-700 mb-3">Sistema de Puntos</h3>
        <div className="grid grid-cols-2 md:grid-cols-3 gap-3 text-sm">
          <div className="flex items-center gap-2">
            <span className="text-2xl">🏆</span>
            <div>
              <p className="font-semibold text-gray-900">Campeón</p>
              <p className="text-gray-600">10 puntos</p>
            </div>
          </div>
          <div className="flex items-center gap-2">
            <span className="text-2xl">🥈</span>
            <div>
              <p className="font-semibold text-gray-900">Subcampeón</p>
              <p className="text-gray-600">8 puntos</p>
            </div>
          </div>
          <div className="flex items-center gap-2">
            <span className="text-2xl">🎯</span>
            <div>
              <p className="font-semibold text-gray-900">Semifinal</p>
              <p className="text-gray-600">6 puntos</p>
            </div>
          </div>
          <div className="flex items-center gap-2">
            <span className="text-2xl">📊</span>
            <div>
              <p className="font-semibold text-gray-900">Cuartos</p>
              <p className="text-gray-600">4 puntos</p>
            </div>
          </div>
          <div className="flex items-center gap-2">
            <span className="text-2xl">📈</span>
            <div>
              <p className="font-semibold text-gray-900">Octavos</p>
              <p className="text-gray-600">2 puntos</p>
            </div>
          </div>
          <div className="flex items-center gap-2">
            <span className="text-2xl">✅</span>
            <div>
              <p className="font-semibold text-gray-900">Zona</p>
              <p className="text-gray-600">1 punto</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

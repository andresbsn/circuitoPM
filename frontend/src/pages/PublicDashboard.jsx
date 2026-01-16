import { useState, useEffect } from 'react'
import { useNavigate } from 'react-router-dom'
import Card from '../components/Card'
import Badge from '../components/Badge'
import api from '../services/api'
import { tabStyles } from '../utils/styles'
import { useAuth } from '../context/AuthContext'

import fapLogo from '../assets/fap.jpg'
import logo from '../assets/logo.jpeg'
import Layout from '../components/Layout'

export default function PublicDashboard() {
  const { user } = useAuth()
  const navigate = useNavigate()
  const [activeTab, setActiveTab] = useState('tournaments')
  const [tournaments, setTournaments] = useState([])
  const [categories, setCategories] = useState([])
  const [selectedCategory, setSelectedCategory] = useState('')
  const [ranking, setRanking] = useState([])
  const [loading, setLoading] = useState(false)

  useEffect(() => {
    fetchTournaments()
    fetchCategories()
  }, [])

  useEffect(() => {
    if (activeTab === 'ranking' && selectedCategory) {
      fetchRanking(selectedCategory)
    }
  }, [activeTab, selectedCategory])

  const fetchCategories = async () => {
    try {
      const response = await api.get('/api/categories')
      if (response.data.ok) {
        setCategories(response.data.data)
        if (response.data.data.length > 0) {
          setSelectedCategory(response.data.data[0].id)
        }
      }
    } catch (error) {
      console.error('Error fetching categories:', error)
    }
  }

  const fetchTournaments = async () => {
    try {
      setLoading(true)
      const response = await api.get('/api/tournaments')
      if (response.data.ok) {
        setTournaments(response.data.data)
      }
    } catch (error) {
      console.error('Error fetching tournaments:', error)
    } finally {
      setLoading(false)
    }
  }

  const fetchRanking = async (categoryId) => {
    try {
      setLoading(true)
      const response = await api.get(`/api/tournament-categories/ranking?category_id=${categoryId}`)
      if (response.data.ok) {
        setRanking(response.data.data || [])
      } else {
         setRanking([])
      }
    } catch (error) {
      console.error('Error fetching ranking:', error)
      setRanking([])
    } finally {
      setLoading(false)
    }
  }
  const navigation = [
    { name: 'Torneos', onClick: () => setActiveTab('tournaments'), current: activeTab === 'tournaments' },
    { name: 'Ranking', onClick: () => setActiveTab('ranking'), current: activeTab === 'ranking' }
  ]

  return (
    <Layout title="Circuito Pádel PM" navigationItems={navigation}>
       {/* Hero Section */}
       <div className="relative bg-gray-900 rounded-2xl overflow-hidden mb-12 shadow-2xl">
          <div className="absolute inset-0 bg-gradient-to-r from-primary-900 to-gray-900 opacity-90 z-10"></div>
          <div className="absolute inset-0 bg-[url('https://images.unsplash.com/photo-1554068865-24cecd4e34b8?auto=format&fit=crop&q=80')] bg-cover bg-center mix-blend-overlay opacity-50"></div>
          
          <div className="relative z-20 px-8 py-12 md:py-16 md:px-12 flex flex-col md:flex-row items-center justify-between gap-8">
            <div className="text-center md:text-left max-w-2xl">
               <img src={logo} alt="Circuito PM" className="h-20 w-auto mb-6 mx-auto md:mx-0 rounded-xl shadow-lg border border-white/20" />
               <h2 className="text-3xl md:text-5xl font-extrabold text-white tracking-tight leading-tight mb-4">
                 Siente la pasión <span className="text-primary-400">en cada punto.</span>
               </h2>
               <p className="text-gray-300 text-lg md:text-xl leading-relaxed">
                 La plataforma oficial del circuito más competitivo. Inscríbete a torneos, consulta tu ranking y desafía tus límites.
               </p>
            </div>
            
            <div className="flex-shrink-0 bg-white/10 backdrop-blur-md p-6 rounded-xl border border-white/20 flex items-center gap-4 transform hover:scale-105 transition-transform duration-300">
               <img src={fapLogo} alt="FAP Logo" className="h-16 w-auto rounded-lg bg-white p-1 shadow-md" />
               <div className="text-left">
                  <p className="text-xs text-primary-300 font-bold uppercase tracking-widest">Avalado por</p>
                  <p className="text-white font-bold text-lg leading-tight">Federación<br/>Argentina de Pádel</p>
               </div>
            </div>
          </div>
       </div>

        {activeTab === 'tournaments' && (
          <div className="space-y-8 animate-fade-in-up">
            <div className="text-center md:text-left border-b border-gray-200 pb-4">
              <h2 className="text-3xl font-bold text-gray-900">Torneos Disponibles</h2>
              <p className="mt-2 text-gray-600 text-lg">Próximos eventos y competencias activas.</p>
            </div>
            
            {loading && tournaments.length === 0 ? (
               <div className="flex justify-center items-center py-20">
                 <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary-600"></div>
               </div>
            ) : tournaments.length === 0 ? (
              <div className="bg-white rounded-xl shadow-lg p-12 text-center border border-gray-100">
                <svg className="mx-auto h-12 w-12 text-gray-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 11H5m14 0a2 2 0 012 2v6a2 2 0 01-2 2H5a2 2 0 01-2-2v-6a2 2 0 012-2m14 0V9a2 2 0 00-2-2M5 11V9a2 2 0 012-2m0 0V5a2 2 0 012-2h6a2 2 0 012 2v2M7 7h10" />
                </svg>
                <p className="mt-4 text-gray-500 text-lg">No hay torneos disponibles en este momento.</p>
              </div>
            ) : (
              <div className="grid gap-8 md:grid-cols-2 lg:grid-cols-3">
                {tournaments.map(tournament => (
                  <div key={tournament.id} className="group bg-white rounded-2xl shadow-lg border border-gray-100 overflow-hidden hover:shadow-2xl transition-all duration-300 transform hover:-translate-y-1 flex flex-col h-full">
                    <div className="h-32 bg-gradient-to-r from-primary-500 to-primary-700 p-6 flex items-start justify-between relative overflow-hidden">
                       <div className="absolute inset-0 bg-white/10 opacity-0 group-hover:opacity-20 transition-opacity"></div>
                       {/* Abstract pattern could go here */}
                       <Badge status={tournament.estado} className="relative z-10 shadow-sm" />
                       <span className="text-xs font-bold text-white bg-white/20 backdrop-blur-sm px-3 py-1 rounded-full relative z-10">
                         {new Date(tournament.fecha_inicio).toLocaleDateString()}
                       </span>
                    </div>
                    
                    <div className="p-6 flex-1 flex flex-col">
                      <h3 className="text-2xl font-bold text-gray-900 mb-2 group-hover:text-primary-600 transition-colors">
                        {tournament.nombre}
                      </h3>
                      <p className="text-gray-600 mb-6 flex-grow line-clamp-3 text-sm leading-relaxed">
                        {tournament.descripcion}
                      </p>
                      
                      <div className="mt-auto pt-4 border-t border-gray-100">
                         <div className="mb-4">
                            <p className="text-xs font-bold text-gray-400 uppercase tracking-wider mb-2">Categorías</p>
                            <div className="flex flex-wrap gap-2">
                              {tournament.categories?.slice(0, 5).map(tc => (
                                <span key={tc.id} className="inline-flex items-center px-2.5 py-1 rounded-md text-xs font-medium bg-gray-50 text-gray-700 border border-gray-200">
                                  {tc.category.name}
                                </span>
                              ))}
                              {tournament.categories?.length > 5 && (
                                <span className="inline-flex items-center px-2 py-1 rounded-md text-xs text-gray-500 bg-gray-50">
                                  +{tournament.categories.length - 5}
                                </span>
                              )}
                            </div>
                         </div>
                         
                         <button
                            onClick={() => navigate(`/tournaments/${tournament.id}`)}
                            className="w-full bg-white border border-gray-200 text-gray-900 py-3 px-4 rounded-xl text-sm font-bold shadow-sm hover:bg-primary-600 hover:text-white hover:border-transparent transition-all duration-200 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary-500"
                         >
                            Ver Detalles
                         </button>
                      </div>
                    </div>
                  </div>
                ))}
              </div>
            )}
          </div>
        )}

        {activeTab === 'ranking' && (
          <div className="space-y-8 animate-fade-in-up">
            <div className="flex flex-col md:flex-row md:items-end justify-between gap-6 border-b border-gray-200 pb-6">
              <div>
                <h2 className="text-3xl font-bold text-gray-900">Ranking Oficial</h2>
                <p className="mt-2 text-gray-600 text-lg">Consulta las posiciones actualizadas por categoría.</p>
              </div>
              <div className="w-full md:w-72">
                <label htmlFor="category-select" className="block text-sm font-medium text-gray-700 mb-1 ml-1">
                  Filtrar por Categoría
                </label>
                <div className="relative">
                  <select
                    id="category-select"
                    value={selectedCategory}
                    onChange={(e) => setSelectedCategory(e.target.value)}
                    className="block w-full pl-4 pr-10 py-3 text-base border-gray-300 focus:outline-none focus:ring-primary-500 focus:border-primary-500 sm:text-sm rounded-xl shadow-sm bg-white"
                  >
                    {categories.map(cat => (
                      <option key={cat.id} value={cat.id}>{cat.name}</option>
                    ))}
                  </select>
                </div>
              </div>
            </div>

            {loading && ranking.length === 0 ? (
               <div className="flex justify-center items-center py-20">
                  <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary-600"></div>
               </div>
            ) : ranking.length === 0 ? (
              <div className="bg-white rounded-xl shadow-lg p-12 text-center border border-gray-100">
                <p className="text-gray-500 text-lg">No hay datos de ranking disponibles para esta categoría.</p>
              </div>
            ) : (
               <div className="bg-white rounded-2xl shadow-xl border border-gray-100 overflow-hidden">
                  {/* Desktop Table View */}
                  <div className="hidden md:block overflow-x-auto">
                    <table className="min-w-full divide-y divide-gray-200">
                      <thead className="bg-gray-50">
                        <tr>
                          <th scope="col" className="px-6 py-4 text-left text-xs font-bold text-gray-500 uppercase tracking-wider">
                            Posición
                          </th>
                          <th scope="col" className="px-6 py-4 text-left text-xs font-bold text-gray-500 uppercase tracking-wider">
                            Jugador
                          </th>
                          <th scope="col" className="px-6 py-4 text-left text-xs font-bold text-gray-500 uppercase tracking-wider">
                            Puntos
                          </th>
                           <th scope="col" className="px-6 py-4 text-left text-xs font-bold text-gray-500 uppercase tracking-wider">
                            Torneos
                          </th>
                        </tr>
                      </thead>
                      <tbody className="bg-white divide-y divide-gray-100">
                        {ranking.map((player, index) => (
                          <tr key={player.dni || index} className={index < 3 ? 'bg-yellow-50/50' : 'hover:bg-gray-50'}>
                            <td className="px-6 py-4 whitespace-nowrap">
                              <div className="flex items-center">
                                 {index === 0 && <span className="text-2xl mr-2">🥇</span>}
                                 {index === 1 && <span className="text-2xl mr-2">🥈</span>}
                                 {index === 2 && <span className="text-2xl mr-2">🥉</span>}
                                 <span className={`text-sm font-bold ${index < 3 ? 'text-gray-900' : 'text-gray-600'}`}>{index + 1}</span>
                              </div>
                            </td>
                            <td className="px-6 py-4 whitespace-nowrap">
                              <div className="text-sm font-medium text-gray-900">{player.nombre} {player.apellido}</div>
                              <div className="text-xs text-gray-400">DNI: {player.dni}</div>
                            </td>
                            <td className="px-6 py-4 whitespace-nowrap">
                              <span className="inline-flex items-center px-2.5 py-0.5 rounded-full text-sm font-bold bg-primary-50 text-primary-700">
                               {player.points} pts
                              </span>
                            </td>
                            <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                               {player.tournaments_played || '-'}
                            </td>
                          </tr>
                        ))}
                      </tbody>
                    </table>
                  </div>
                  
                  {/* Mobile Card View */}
                  <div className="md:hidden">
                    <ul className="divide-y divide-gray-100">
                       {ranking.map((player, index) => (
                          <li key={player.dni || index} className={`p-4 ${index < 3 ? 'bg-gradient-to-r from-yellow-50 to-white' : ''}`}>
                             <div className="flex items-center justify-between mb-2">
                                <div className="flex items-center gap-3">
                                   <div className={`flex items-center justify-center w-8 h-8 rounded-full font-bold text-sm ${
                                      index === 0 ? 'bg-yellow-100 text-yellow-800' :
                                      index === 1 ? 'bg-gray-200 text-gray-800' :
                                      index === 2 ? 'bg-orange-100 text-orange-800' :
                                      'bg-gray-100 text-gray-600'
                                   }`}>
                                      {index + 1}
                                   </div>
                                   <div>
                                      <p className="font-bold text-gray-900">{player.nombre} {player.apellido}</p>
                                      {index < 3 && <p className="text-[10px] text-yellow-600 font-semibold uppercase tracking-wide">Top {index + 1}</p>}
                                   </div>
                                </div>
                                <div className="text-right">
                                   <span className="block text-lg font-bold text-primary-600">{player.points}</span>
                                   <span className="text-xs text-gray-400">Puntos</span>
                                </div>
                             </div>
                             <div className="flex justify-between items-center text-xs text-gray-500 mt-2 pl-11">
                                <span>DNI: {player.dni}</span>
                                <span>{player.tournaments_played || 0} Torneos</span>
                             </div>
                          </li>
                       ))}
                    </ul>
                  </div>
               </div>
            )}
          </div>
        )}
    </Layout>

  )
}

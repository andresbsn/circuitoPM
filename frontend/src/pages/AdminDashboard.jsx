import { Routes, Route } from 'react-router-dom'
import Layout from '../components/Layout'
import AdminCategories from '../components/admin/AdminCategories'
import AdminTournaments from '../components/admin/AdminTournaments'
import AdminTournamentDetail from '../components/admin/AdminTournamentDetail'
import AdminTeams from '../components/admin/AdminTeams'
import AdminVenues from '../components/admin/AdminVenues'
import AdminUsers from '../components/admin/AdminUsers'
import AdminRanking from '../components/admin/AdminRanking'
import AdminPlayers from '../components/admin/AdminPlayers'

export default function AdminDashboard() {
  const navigation = [
    { name: 'Torneos', href: '/admin' },
    { name: 'Categorías', href: '/admin/categories' },
    { name: 'Jugadores', href: '/admin/players' },
    { name: 'Parejas', href: '/admin/teams' },
    { name: 'Complejos', href: '/admin/venues' },
    { name: 'Usuarios', href: '/admin/users' },
    { name: 'Ranking', href: '/admin/ranking' },
  ]

  return (
    <Layout title="Panel Administrativo" navigationItems={navigation}>
      <Routes>
        <Route path="/" element={<AdminTournaments />} />
        <Route path="/categories" element={<AdminCategories />} />
        <Route path="/players" element={<AdminPlayers />} />
        <Route path="/teams" element={<AdminTeams />} />
        <Route path="/venues" element={<AdminVenues />} />
        <Route path="/users" element={<AdminUsers />} />
        <Route path="/ranking" element={<AdminRanking />} />
        <Route path="/tournaments/:id" element={<AdminTournamentDetail />} />
      </Routes>
    </Layout>
  )
}


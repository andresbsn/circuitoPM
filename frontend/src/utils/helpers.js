export const formatDate = (dateString) => {
  if (!dateString) return ''
  const date = new Date(dateString)
  return date.toLocaleDateString('es-AR', {
    year: 'numeric',
    month: 'long',
    day: 'numeric'
  })
}

export const formatDateTime = (dateString) => {
  if (!dateString) return ''
  const date = new Date(dateString)
  return date.toLocaleString('es-AR', {
    year: 'numeric',
    month: 'long',
    day: 'numeric',
    hour: '2-digit',
    minute: '2-digit',
    hour12: false,
    timeZone: 'America/Argentina/Buenos_Aires'
  })
}

export const formatDateForInput = (dateString) => {
  if (!dateString) return ''
  const date = new Date(dateString)
  // Get Argentina time parts
  const formatter = new Intl.DateTimeFormat('en-GB', {
    timeZone: 'America/Argentina/Buenos_Aires',
    year: 'numeric',
    month: '2-digit',
    day: '2-digit',
    hour: '2-digit',
    minute: '2-digit',
    hour12: false
  })
  
  const parts = formatter.formatToParts(date)
  const getPart = (type) => parts.find(p => p.type === type).value
  
  // en-GB parts: day, month, year, hour, minute
  // We need YYYY-MM-DDTHH:mm
  return `${getPart('year')}-${getPart('month')}-${getPart('day')}T${getPart('hour')}:${getPart('minute')}`
}

export const formatMatchDate = (dateString) => {
  if (!dateString) return 'A confirmar'
  const date = new Date(dateString)
  
  const weekday = date.toLocaleDateString('es-AR', { 
    weekday: 'short', 
    timeZone: 'America/Argentina/Buenos_Aires' 
  }).toUpperCase().replace('.', '')

  const formatter = new Intl.DateTimeFormat('es-AR', {
    timeZone: 'America/Argentina/Buenos_Aires',
    day: '2-digit',
    month: '2-digit',
    year: 'numeric',
    hour: '2-digit',
    minute: '2-digit',
    hour12: false
  })

  const parts = formatter.formatToParts(date)
  const getPart = (type) => parts.find(p => p.type === type).value

  return `${weekday}, ${getPart('day')}-${getPart('month')}-${getPart('year')} ${getPart('hour')}:${getPart('minute')}`
}

export const getPlayerFullName = (player) => {
  if (!player) return ''
  return `${player.nombre} ${player.apellido}`
}

export const getTeamName = (team) => {
  if (!team) return ''
  const player1Name = getPlayerFullName(team.player1)
  const player2Name = getPlayerFullName(team.player2)
  return `${player1Name} / ${player2Name}`
}

export const handleApiError = (error) => {
  return error.response?.data?.error?.message || 'Error en la solicitud'
}

export const isActiveTeam = (team) => {
  return team?.estado === 'activa'
}

export const filterActiveTeams = (teams) => {
  return teams.filter(isActiveTeam)
}

export const getVenueStyle = (venueId) => {
  switch (venueId) {
    case 1: // Las Palmeras (Azul)
      return { 
        border: 'border-blue-500', 
        bg: 'bg-blue-50', 
        badge: 'bg-blue-100 text-blue-800',
        text: 'text-blue-900'
      }
    case 3: // El Triunfo (Verde)
      return { 
        border: 'border-green-500', 
        bg: 'bg-green-50', 
        badge: 'bg-green-100 text-green-800',
        text: 'text-green-900'
      }
    case 4: // Padel House (Rojo)
      return { 
        border: 'border-red-500', 
        bg: 'bg-red-50', 
        badge: 'bg-red-100 text-red-800',
        text: 'text-red-900'
      }
    default: 
      return { 
        border: 'border-gray-200', 
        bg: 'bg-white', 
        badge: 'bg-gray-100 text-gray-800',
        text: 'text-gray-900'
      }
  }
}

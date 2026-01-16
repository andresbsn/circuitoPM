export const buttonStyles = {
  primary: 'bg-primary-600 text-white px-4 py-2 rounded-md hover:bg-primary-700 disabled:opacity-50',
  secondary: 'px-4 py-2 border border-gray-300 rounded-md text-sm font-medium text-gray-700 hover:bg-gray-50',
  danger: 'bg-red-600 text-white px-4 py-2 rounded-md hover:bg-red-700 disabled:opacity-50',
  small: 'text-xs bg-primary-600 text-white px-3 py-1 rounded hover:bg-primary-700'
}

export const inputStyles = {
  base: 'mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-primary-500 focus:border-primary-500',
  error: 'mt-1 block w-full px-3 py-2 border border-red-300 rounded-md shadow-sm focus:outline-none focus:ring-red-500 focus:border-red-500'
}

export const cardStyles = {
  base: 'bg-white rounded-lg shadow p-6',
  hover: 'bg-white rounded-lg shadow p-6 hover:shadow-lg transition-shadow'
}

export const badgeStyles = {
  success: 'px-2 py-1 text-xs rounded bg-green-100 text-green-800',
  info: 'px-2 py-1 text-xs rounded bg-primary-100 text-primary-800',
  warning: 'px-2 py-1 text-xs rounded bg-yellow-100 text-yellow-800',
  error: 'px-2 py-1 text-xs rounded bg-red-100 text-red-800',
  neutral: 'px-2 py-1 text-xs rounded bg-gray-100 text-gray-800'
}

export const tabStyles = {
  active: 'border-primary-500 text-primary-600 whitespace-nowrap py-4 px-1 border-b-2 font-medium text-sm',
  inactive: 'border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300 whitespace-nowrap py-4 px-1 border-b-2 font-medium text-sm'
}

export const getStatusBadgeStyle = (status) => {
  const statusMap = {
    'activa': badgeStyles.success,
    'inactiva': badgeStyles.neutral,
    'inscripto': badgeStyles.info,
    'confirmado': badgeStyles.success,
    'cancelado': badgeStyles.error,
    'pending': badgeStyles.warning,
    'played': badgeStyles.success,
    'scheduled': badgeStyles.info
  }
  return statusMap[status] || badgeStyles.neutral
}

import { getStatusBadgeStyle } from '../utils/styles'

export default function Badge({ status, children, variant }) {
  const className = variant ? variant : getStatusBadgeStyle(status)
  
  return (
    <span className={className}>
      {children || status}
    </span>
  )
}

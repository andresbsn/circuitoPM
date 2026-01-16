import { cardStyles } from '../utils/styles'

export default function Card({ children, hover = false, className = '' }) {
  const baseStyle = hover ? cardStyles.hover : cardStyles.base
  
  return (
    <div className={`${baseStyle} ${className}`}>
      {children}
    </div>
  )
}

import { buttonStyles } from '../utils/styles'

export default function Button({ 
  children, 
  variant = 'primary', 
  type = 'button',
  disabled = false,
  onClick,
  className = '',
  ...props 
}) {
  const baseStyle = buttonStyles[variant] || buttonStyles.primary
  
  return (
    <button
      type={type}
      disabled={disabled}
      onClick={onClick}
      className={`${baseStyle} ${className}`}
      {...props}
    >
      {children}
    </button>
  )
}

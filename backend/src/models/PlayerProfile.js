const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const PlayerProfile = sequelize.define('PlayerProfile', {
  dni: {
    type: DataTypes.STRING(20),
    primaryKey: true
  },
  nombre: {
    type: DataTypes.STRING(100),
    allowNull: false
  },
  apellido: {
    type: DataTypes.STRING(100),
    allowNull: false
  },
  telefono: {
    type: DataTypes.STRING(20),
    allowNull: true
  },
  categoria_base_id: {
    type: DataTypes.INTEGER,
    allowNull: false
  },
  genero: {
    type: DataTypes.ENUM('M', 'F'),
    allowNull: false,
    defaultValue: 'M'
  },
  activo: {
    type: DataTypes.BOOLEAN,
    defaultValue: true
  }
}, {
  tableName: 'player_profiles',
  timestamps: true,
  createdAt: 'created_at',
  updatedAt: 'updated_at'
});

module.exports = PlayerProfile;

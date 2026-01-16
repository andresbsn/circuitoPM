const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const Registration = sequelize.define('Registration', {
  id: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true
  },
  tournament_category_id: {
    type: DataTypes.INTEGER,
    allowNull: false
  },
  team_id: {
    type: DataTypes.INTEGER,
    allowNull: false
  },
  estado: {
    type: DataTypes.ENUM('inscripto', 'baja', 'confirmado'),
    defaultValue: 'inscripto'
  }
}, {
  tableName: 'registrations',
  timestamps: true,
  createdAt: 'created_at',
  updatedAt: 'updated_at',
  indexes: [
    {
      unique: true,
      fields: ['tournament_category_id', 'team_id']
    }
  ]
});

module.exports = Registration;

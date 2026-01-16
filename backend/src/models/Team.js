const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const Team = sequelize.define('Team', {
  id: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true
  },
  player1_dni: {
    type: DataTypes.STRING(20),
    allowNull: false
  },
  player2_dni: {
    type: DataTypes.STRING(20),
    allowNull: false
  },
  estado: {
    type: DataTypes.ENUM('activa', 'inactiva'),
    defaultValue: 'activa'
  }
}, {
  tableName: 'teams',
  timestamps: true,
  createdAt: 'created_at',
  updatedAt: 'updated_at',
  indexes: [
    {
      unique: true,
      fields: [
        sequelize.fn('LEAST', sequelize.col('player1_dni'), sequelize.col('player2_dni')),
        sequelize.fn('GREATEST', sequelize.col('player1_dni'), sequelize.col('player2_dni'))
      ],
      name: 'unique_team_pair'
    }
  ]
});

module.exports = Team;

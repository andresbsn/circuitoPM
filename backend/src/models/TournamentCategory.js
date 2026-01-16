const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const TournamentCategory = sequelize.define('TournamentCategory', {
  id: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true
  },
  tournament_id: {
    type: DataTypes.INTEGER,
    allowNull: false
  },
  category_id: {
    type: DataTypes.INTEGER,
    allowNull: false
  },
  cupo: {
    type: DataTypes.INTEGER,
    allowNull: true
  },
  inscripcion_abierta: {
    type: DataTypes.BOOLEAN,
    defaultValue: true
  },
  match_format: {
    type: DataTypes.ENUM('BEST_OF_3_SUPER_TB', 'BEST_OF_3_FULL'),
    defaultValue: 'BEST_OF_3_SUPER_TB'
  },
  super_tiebreak_points: {
    type: DataTypes.INTEGER,
    defaultValue: 10
  },
  tiebreak_in_sets: {
    type: DataTypes.BOOLEAN,
    defaultValue: true
  },
  win_points: {
    type: DataTypes.INTEGER,
    defaultValue: 2
  },
  loss_points: {
    type: DataTypes.INTEGER,
    defaultValue: 0
  },
  zone_size: {
    type: DataTypes.INTEGER,
    allowNull: true
  },
  qualifiers_per_zone: {
    type: DataTypes.INTEGER,
    allowNull: true
  },
  estado: {
    type: DataTypes.ENUM('draft', 'inscripcion_abierta', 'inscripcion_cerrada', 'zonas_generadas', 'zonas_en_curso', 'playoffs_generados', 'playoffs_en_curso', 'finalizado'),
    defaultValue: 'draft'
  }
}, {
  tableName: 'tournament_categories',
  timestamps: true,
  createdAt: 'created_at',
  updatedAt: 'updated_at',
  indexes: [
    {
      unique: true,
      fields: ['tournament_id', 'category_id']
    }
  ]
});

module.exports = TournamentCategory;

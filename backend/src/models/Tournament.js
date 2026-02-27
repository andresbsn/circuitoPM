const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const Tournament = sequelize.define('Tournament', {
  id: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true
  },
  nombre: {
    type: DataTypes.STRING(200),
    allowNull: false,
    set(val) {
      this.setDataValue('nombre', val ? val.toUpperCase() : val);
    }
  },
  fecha_inicio: {
    type: DataTypes.DATE,
    allowNull: true
  },
  fecha_fin: {
    type: DataTypes.DATE,
    allowNull: true
  },
  estado: {
    type: DataTypes.ENUM('draft', 'inscripcion', 'en_curso', 'finalizado'),
    defaultValue: 'draft'
  },
  descripcion: {
    type: DataTypes.TEXT,
    allowNull: true
  },
  double_points: {
    type: DataTypes.BOOLEAN,
    defaultValue: false,
    allowNull: false,
    comment: 'Si es true, los puntos asignados se duplican'
  }
}, {
  tableName: 'tournaments',
  timestamps: true,
  createdAt: 'created_at',
  updatedAt: 'updated_at'
});

module.exports = Tournament;

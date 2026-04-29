'use strict';

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.createTable('player_category_adjustments', {
      id: {
        type: Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement: true,
        allowNull: false
      },
      player_dni: {
        type: Sequelize.STRING(20),
        allowNull: false,
        references: {
          model: 'player_profiles',
          key: 'dni'
        },
        onUpdate: 'CASCADE',
        onDelete: 'CASCADE'
      },
      category_id: {
        type: Sequelize.INTEGER,
        allowNull: false,
        references: {
          model: 'categories',
          key: 'id'
        },
        onUpdate: 'CASCADE',
        onDelete: 'RESTRICT'
      },
      source_category_id: {
        type: Sequelize.INTEGER,
        allowNull: false,
        references: {
          model: 'categories',
          key: 'id'
        },
        onUpdate: 'CASCADE',
        onDelete: 'RESTRICT'
      },
      points: {
        type: Sequelize.INTEGER,
        allowNull: false,
        defaultValue: 0
      },
      reason: {
        type: Sequelize.STRING(50),
        allowNull: false,
        defaultValue: 'ascenso'
      },
      created_at: {
        type: Sequelize.DATE,
        allowNull: false,
        defaultValue: Sequelize.fn('NOW')
      },
      updated_at: {
        type: Sequelize.DATE,
        allowNull: false,
        defaultValue: Sequelize.fn('NOW')
      }
    });

    await queryInterface.addIndex('player_category_adjustments', ['player_dni']);
    await queryInterface.addIndex('player_category_adjustments', ['category_id']);
    await queryInterface.addIndex('player_category_adjustments', ['source_category_id']);
  },

  async down(queryInterface, Sequelize) {
    await queryInterface.dropTable('player_category_adjustments');
  }
};

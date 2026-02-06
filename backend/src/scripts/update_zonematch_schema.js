const fs = require('fs');
const path = require('path');
const { Sequelize, DataTypes } = require('sequelize');
require('dotenv').config({ path: path.join(__dirname, '../../.env') });

const sequelize = new Sequelize(
    process.env.DB_NAME,
    process.env.DB_USER,
    process.env.DB_PASS,
    {
        host: process.env.DB_HOST,
        port: process.env.DB_PORT,
        dialect: 'postgres',
        logging: console.log,
        schema: process.env.DB_SCHEMA || 'padel_circuit'
    }
);

async function run() {
    try {
        await sequelize.authenticate();
        console.log('Connection has been established successfully.');

        const queryInterface = sequelize.getQueryInterface();
        const table = { tableName: 'zone_matches', schema: process.env.DB_SCHEMA || 'padel_circuit' };

        // 1. Make team_home_id and team_away_id nullable
        console.log('Altering team columns to allow NULL...');
        await queryInterface.changeColumn(table, 'team_home_id', {
            type: DataTypes.INTEGER,
            allowNull: true
        });
        await queryInterface.changeColumn(table, 'team_away_id', {
            type: DataTypes.INTEGER,
            allowNull: true
        });

        // 2. Add parent columns
        console.log('Adding parent columns...');

        // Check if columns exist first (optional but good for re-running)
        // We'll just try/catch generic addColumn

        try {
            await queryInterface.addColumn(table, 'parent_match_home_id', {
                type: DataTypes.INTEGER,
                allowNull: true
            });
        } catch (e) { console.log('parent_match_home_id might already exist'); }

        try {
            await queryInterface.addColumn(table, 'parent_match_away_id', {
                type: DataTypes.INTEGER,
                allowNull: true
            });
        } catch (e) { console.log('parent_match_away_id might already exist'); }

        try {
            await queryInterface.addColumn(table, 'parent_condition_home', {
                type: DataTypes.STRING(20), // 'winner' or 'loser'
                allowNull: true
            });
        } catch (e) { console.log('parent_condition_home might already exist'); }

        try {
            await queryInterface.addColumn(table, 'parent_condition_away', {
                type: DataTypes.STRING(20), // 'winner' or 'loser'
                allowNull: true
            });
        } catch (e) { console.log('parent_condition_away might already exist'); }


        console.log('Schema update completed.');

    } catch (error) {
        console.error('Unable to connect to the database:', error);
    } finally {
        await sequelize.close();
    }
}

run();

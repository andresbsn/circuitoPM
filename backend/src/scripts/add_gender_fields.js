const { Sequelize } = require('sequelize');
const sequelize = require('../config/database');

const SCHEMA = sequelize.options.define.schema || 'public';

async function migrate() {
  const transaction = await sequelize.transaction();

  try {
    console.log(`Starting migration to add gender fields in schema: ${SCHEMA}...`);

    // 1. Add gender column to categories
    console.log('Adding gender to categories...');
    await sequelize.query(`
      DO $$
      BEGIN
          IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'enum_categories_gender' AND typnamespace = (SELECT oid FROM pg_namespace WHERE nspname = '${SCHEMA}')) THEN
              CREATE TYPE "${SCHEMA}"."enum_categories_gender" AS ENUM ('caballeros', 'damas');
          END IF;
      END
      $$;
    `, { transaction });

    // Check if column exists
    const [columns] = await sequelize.query(`
      SELECT column_name 
      FROM information_schema.columns 
      WHERE table_schema = '${SCHEMA}' AND table_name = 'categories' AND column_name = 'gender';
    `, { transaction });

    if (columns.length === 0) {
      await sequelize.query(`
        ALTER TABLE "${SCHEMA}"."categories" 
        ADD COLUMN gender "${SCHEMA}"."enum_categories_gender" DEFAULT 'caballeros' NOT NULL;
      `, { transaction });
    }

    // 2. Drop old unique constraints on categories
    console.log('Updating constraints on categories...');
    
    // We need to find the constraint names first
    try {
      await sequelize.query(`ALTER TABLE "${SCHEMA}"."categories" DROP CONSTRAINT IF EXISTS categories_name_key;`, { transaction });
      await sequelize.query(`ALTER TABLE "${SCHEMA}"."categories" DROP CONSTRAINT IF EXISTS categories_rank_key;`, { transaction });
    } catch (e) {
      console.log('Constraints might not exist or have different names:', e.message);
    }

    // Add new composite constraints
    // We need to check if they exist first or just try-catch (Postgres doesn't support IF NOT EXISTS for constraints easily in one line without DO block)
    // But since we are inside a transaction, if it fails, the whole thing fails. 
    // Let's use DO block or catch specific error.
    
    // Actually, let's just try to add them. If they exist, it might fail.
    // A safer way is to check pg_constraint but let's try dropping the potential new ones first to be idempotent-ish
    try {
        await sequelize.query(`ALTER TABLE "${SCHEMA}"."categories" DROP CONSTRAINT IF EXISTS categories_name_gender_key;`, { transaction });
        await sequelize.query(`ALTER TABLE "${SCHEMA}"."categories" DROP CONSTRAINT IF EXISTS categories_rank_gender_key;`, { transaction });
    } catch (e) {
        // Ignore
    }

    try {
        await sequelize.query(`
            ALTER TABLE "${SCHEMA}"."categories" 
            ADD CONSTRAINT categories_name_gender_key UNIQUE (name, gender);
        `, { transaction });

        await sequelize.query(`
            ALTER TABLE "${SCHEMA}"."categories" 
            ADD CONSTRAINT categories_rank_gender_key UNIQUE (rank, gender);
        `, { transaction });
    } catch (e) {
        console.log('New constraints might already exist:', e.message);
    }

    // 3. Add genero column to player_profiles
    console.log('Adding genero to player_profiles...');
    await sequelize.query(`
      DO $$
      BEGIN
          IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'enum_player_profiles_genero' AND typnamespace = (SELECT oid FROM pg_namespace WHERE nspname = '${SCHEMA}')) THEN
              CREATE TYPE "${SCHEMA}"."enum_player_profiles_genero" AS ENUM ('M', 'F');
          END IF;
      END
      $$;
    `, { transaction });

    const [playerColumns] = await sequelize.query(`
      SELECT column_name 
      FROM information_schema.columns 
      WHERE table_schema = '${SCHEMA}' AND table_name = 'player_profiles' AND column_name = 'genero';
    `, { transaction });

    if (playerColumns.length === 0) {
      await sequelize.query(`
        ALTER TABLE "${SCHEMA}"."player_profiles" 
        ADD COLUMN genero "${SCHEMA}"."enum_player_profiles_genero" DEFAULT 'M' NOT NULL;
      `, { transaction });
    }

    await transaction.commit();
    console.log('Migration completed successfully.');
  } catch (error) {
    await transaction.rollback();
    console.error('Migration failed:', error);
    process.exit(1);
  } finally {
    await sequelize.close();
  }
}

migrate();

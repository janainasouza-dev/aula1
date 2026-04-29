const { Pool } = require('pg');

const pool = new Pool({
  host: process.env.DB_HOST || 'postgres',
  port: process.env.DB_PORT || 5432,
  database: process.env.DB_NAME || 'matricula_db',
  user: process.env.DB_USER || 'admin',
  password: process.env.DB_PASSWORD || 'senha123',
});

const query = (text, params) => pool.query(text, params);

module.exports = { query, pool };

import Redis from 'ioredis';
import dotenv from 'dotenv';

dotenv.config();

const redis = new Redis({
  host: process.env.REDIS_HOST || '127.0.0.1', // Redis server address
  port: process.env.REDIS_PORT || 6379, // Redis default port
  password: process.env.REDIS_PASSWORD || undefined, // Password if required
  db: 0, // Default database index
});

redis.on('connect', () => {
  console.log('Connected to Redis ✅');
});

redis.on('error', (err) => {
  console.error('Redis Error ❌:', err);
});

export default redis;
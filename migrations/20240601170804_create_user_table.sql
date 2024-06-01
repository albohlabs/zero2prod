-- Add migration script here
CREATE TABLE IF NOT EXISTS users (
  user_id uuid PRIMARY KEY,
  username TEXT NOT NULL UNIQUE,
  password TEXT NOT NULL
)

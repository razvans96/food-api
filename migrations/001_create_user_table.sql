CREATE TABLE IF NOT EXISTS users (
  user_uid TEXT PRIMARY KEY,
  user_email TEXT NOT NULL,
  user_name TEXT NOT NULL,
  user_surname TEXT,
  user_phone TEXT,
  user_dob DATE,
  user_created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  user_modified_at TIMESTAMP WITH TIME ZONE,
);
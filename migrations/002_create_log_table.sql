CREATE TABLE log (
  log_id SERIAL PRIMARY KEY,
  log_level VARCHAR(20) NOT NULL,
  log_logger_name VARCHAR(100) NOT NULL,
  log_message TEXT NOT NULL,
  log_created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  log_modified_at TIMESTAMP WITH TIME ZONE,
);
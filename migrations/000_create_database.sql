CREATE TABLE IF NOT EXISTS users (
  user_uid TEXT PRIMARY KEY,
  user_email TEXT NOT NULL,
  user_name TEXT NOT NULL,
  user_surname TEXT,
  user_phone TEXT,
  user_dob DATE,
  user_dietary_restrictions JSONB,
  user_created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  user_modified_at TIMESTAMP WITH TIME ZONE
);

ALTER TABLE users ADD COLUMN IF NOT EXISTS user_dietary_restrictions JSONB;

CREATE TABLE IF NOT EXISTS log (
  log_id SERIAL PRIMARY KEY,
  log_level VARCHAR(20) NOT NULL,
  log_logger_name VARCHAR(100) NOT NULL,
  log_message TEXT NOT NULL,
  log_created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  log_modified_at TIMESTAMP WITH TIME ZONE
);

CREATE TABLE IF NOT EXISTS products (
    product_barcode VARCHAR(14) PRIMARY KEY,
    product_name VARCHAR(255),
    product_brand VARCHAR(255),
    product_quantity VARCHAR(100),
    product_nutriscore_grade CHAR(1) CHECK (product_nutriscore_grade IN ('a', 'b', 'c', 'd', 'e')),
    product_ecoscore_grade CHAR(1) CHECK (product_ecoscore_grade IN ('a', 'b', 'c', 'd', 'e')),
    product_nova_group INTEGER CHECK (product_nova_group BETWEEN 1 AND 4),
    product_image_url TEXT,
    product_nutritional_data JSONB,
    product_ingredients JSONB,
    product_allergens JSONB,
    product_additives JSONB,
    product_categories JSONB,
    product_created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    product_updated_at TIMESTAMP WITH TIME ZONE
);

CREATE INDEX IF NOT EXISTS idx_products_name ON products (product_name);
CREATE INDEX IF NOT EXISTS idx_products_brand ON products (product_brand);
CREATE INDEX IF NOT EXISTS idx_products_nutriscore ON products (product_nutriscore_grade);
CREATE INDEX IF NOT EXISTS idx_products_created_at ON products (product_created_at);
CREATE INDEX IF NOT EXISTS idx_users_email ON users (user_email);
CREATE INDEX IF NOT EXISTS idx_users_created_at ON users (user_created_at);

CREATE INDEX IF NOT EXISTS idx_products_additives_gin ON products USING GIN (product_additives);
CREATE INDEX IF NOT EXISTS idx_products_allergens_gin ON products USING GIN (product_allergens);
CREATE INDEX IF NOT EXISTS idx_products_categories_gin ON products USING GIN (product_categories);
CREATE INDEX IF NOT EXISTS idx_products_ingredients_gin ON products USING GIN (product_ingredients);
CREATE INDEX IF NOT EXISTS idx_products_nutritional_data_gin ON products USING GIN (product_nutritional_data);
CREATE INDEX IF NOT EXISTS idx_users_dietary_restrictions_gin ON users USING GIN (user_dietary_restrictions);

CREATE INDEX IF NOT EXISTS idx_products_name ON products (product_name);
CREATE INDEX IF NOT EXISTS idx_products_brand ON products (product_brand);
CREATE INDEX IF NOT EXISTS idx_products_nutriscore ON products (product_nutriscore_grade);
CREATE INDEX IF NOT EXISTS idx_products_created_at ON products (product_created_at);

CREATE INDEX IF NOT EXISTS idx_products_additives_gin ON products USING GIN (product_additives);
CREATE INDEX IF NOT EXISTS idx_products_allergens_gin ON products USING GIN (product_allergens);
CREATE INDEX IF NOT EXISTS idx_products_categories_gin ON products USING GIN (product_categories);
CREATE INDEX IF NOT EXISTS idx_products_ingredients_gin ON products USING GIN (product_ingredients);
CREATE INDEX IF NOT EXISTS idx_products_nutritional_data_gin ON products USING GIN (product_nutritional_data);
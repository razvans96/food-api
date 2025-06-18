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

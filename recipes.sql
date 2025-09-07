-- recipes
CREATE TABLE recipes (
  id   BIGSERIAL PRIMARY KEY,
  name TEXT NOT NULL UNIQUE
);

-- categories
CREATE TABLE categories (
  id   BIGSERIAL PRIMARY KEY,
  name TEXT NOT NULL UNIQUE
);

-- ingredients
CREATE TABLE ingredients (
  id   BIGSERIAL PRIMARY KEY,
  name TEXT NOT NULL UNIQUE
);

-- recipes ↔ categories (M:N)
CREATE TABLE recipe_categories (
  recipe_id   BIGINT NOT NULL REFERENCES recipes(id)    ON DELETE CASCADE,
  category_id BIGINT NOT NULL REFERENCES categories(id) ON DELETE CASCADE,
  PRIMARY KEY (recipe_id, category_id)
);

-- recipes ↔ ingredients (M:N)
CREATE TABLE recipe_ingredients (
  recipe_id     BIGINT NOT NULL REFERENCES recipes(id)     ON DELETE CASCADE,
  ingredient_id BIGINT NOT NULL REFERENCES ingredients(id) ON DELETE RESTRICT,
  quantity      NUMERIC(10,3),
  unit          TEXT,
  PRIMARY KEY (recipe_id, ingredient_id)
);

-- steps of recipeses
CREATE TABLE recipe_instructions (
  recipe_id        BIGINT NOT NULL REFERENCES recipes(id) ON DELETE CASCADE,
  step_number      INT    NOT NULL,
  text             TEXT   NOT NULL,
  duration_minutes INT,
  PRIMARY KEY (recipe_id, step_number)
);

-- indexes
CREATE INDEX idx_recipe_categories_category   ON recipe_categories(category_id);
CREATE INDEX idx_recipe_categories_recipe     ON recipe_categories(recipe_id);
CREATE INDEX idx_recipe_ingredients_ingr      ON recipe_ingredients(ingredient_id);
CREATE INDEX idx_recipe_ingredients_recipe    ON recipe_ingredients(recipe_id);
CREATE INDEX idx_recipe_instructions_recipe   ON recipe_instructions(recipe_id);
CREATE INDEX idx_recipes_name                 ON recipes(name);
CREATE INDEX idx_categories_name              ON categories(name);
CREATE INDEX idx_ingredients_name             ON ingredients(name);

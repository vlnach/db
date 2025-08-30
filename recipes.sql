-- recipes
CREATE TABLE recipes (
  id            BIGSERIAL PRIMARY KEY,
  name          TEXT NOT NULL UNIQUE
);

-- categories
CREATE TABLE categories (
  id            BIGSERIAL PRIMARY KEY,
  name          TEXT NOT NULL UNIQUE
);

-- ingredients
CREATE TABLE ingredients (
  id            BIGSERIAL PRIMARY KEY,
  name          TEXT NOT NULL UNIQUE
);

-- instructions 
CREATE TABLE instructions (
  id            BIGSERIAL PRIMARY KEY,
  text          TEXT NOT NULL UNIQUE
);

-- recipe_categories (M:N)
CREATE TABLE recipe_categories (
  recipe_id     BIGINT NOT NULL REFERENCES recipes(id) ON DELETE CASCADE,
  category_id   BIGINT NOT NULL REFERENCES categories(id) ON DELETE CASCADE,
  PRIMARY KEY (recipe_id, category_id)
);

-- recipe_ingredients (M:N)
CREATE TABLE recipe_ingredients (
  recipe_id       BIGINT NOT NULL REFERENCES recipes(id) ON DELETE CASCADE,
  ingredient_id   BIGINT NOT NULL REFERENCES ingredients(id) ON DELETE RESTRICT,
  quantity        NUMERIC(10,3),
  unit            TEXT,
  PRIMARY KEY (recipe_id, ingredient_id)
);

-- recipe_instructions (M:N)
CREATE TABLE recipe_instructions (
  recipe_id        BIGINT NOT NULL REFERENCES recipes(id) ON DELETE CASCADE,
  instruction_id   BIGINT NOT NULL REFERENCES instructions(id) ON DELETE RESTRICT,
  step_number      INT    NOT NULL,
  duration_minutes INT,
  PRIMARY KEY (recipe_id, instruction_id),
  UNIQUE (recipe_id, step_number)
);

-- index
CREATE INDEX idx_recipes_name        ON recipes(name);
CREATE INDEX idx_categories_name     ON categories(name);
CREATE INDEX idx_ingredients_name    ON ingredients(name);
CREATE INDEX idx_rc_category         ON recipe_categories(category_id);

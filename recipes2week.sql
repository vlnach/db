-- ================================
-- DATA FOR PREP EXERCISE WEEK 2
-- ================================

-- 1) Recipes
INSERT INTO recipes (name) VALUES
  ('No-Bake Cheesecake'),
  ('Roasted Brussels Sprouts'),
  ('Mac & Cheese'),
  ('Tamagoyaki Japanese Omelette')
ON CONFLICT (name) DO NOTHING;

-- 2) Categories
INSERT INTO categories (name) VALUES
  ('Cake'), ('No-Bake'), ('Vegetarian'),
  ('Vegan'), ('Gluten-Free'), ('Japanese')
ON CONFLICT (name) DO NOTHING;

-- 3) Ingredients
INSERT INTO ingredients (name) VALUES
  ('Condensed milk'), ('Cream Cheese'), ('Lemon Juice'), ('Pie Crust'), ('Cherry Jam'),
  ('Brussels Sprouts'), ('Sesame seeds'), ('Pepper'), ('Salt'), ('Olive oil'),
  ('Macaroni'), ('Butter'), ('Flour'), ('Milk'), ('Shredded Cheddar cheese'),
  ('Eggs'), ('Soy sauce'), ('Sugar')
ON CONFLICT (name) DO NOTHING;

-- 4) Instructions
INSERT INTO instructions (text) VALUES
  -- Cheesecake
  ('Beat Cream Cheese'),
  ('Add condensed Milk and blend'),
  ('Add Lemon Juice and blend'),
  ('Add the mix to the pie crust'),
  ('Spread the Cherry Jam'),
  ('Place in refrigerator for 3h'),
  -- Brussels sprouts
  ('Preheat the oven'),
  ('Mix the ingredients in a bowl'),
  ('Spread the mix on baking sheet'),
  ('Bake for 30 minutes'),
  -- Mac & Cheese
  ('Cook Macaroni for 8 minutes'),
  ('Melt butter in a saucepan'),
  ('Add flour, salt, pepper and mix'),
  ('Add Milk and mix'),
  ('Cook until mix is smooth'),
  ('Add cheddar cheese'),
  ('Add the macaroni'),
  -- Tamagoyaki
  ('Beat the eggs'),
  ('Add soya sauce, sugar and salt'),
  ('Add oil to a sauce pan'),
  ('Bring to medium heat'),
  ('Add some mix to the sauce pan'),
  ('Let it cook for 1 minute'),
  ('Remove pan from fire')
ON CONFLICT (text) DO NOTHING;

-- ================================
-- RELATIONS
-- ================================

-- Recipe → Categories
-- Cheesecake
INSERT INTO recipe_categories (recipe_id, category_id)
SELECT r.id, c.id
FROM recipes r, categories c
WHERE r.name = 'No-Bake Cheesecake' AND c.name IN ('Cake','No-Bake','Vegetarian');

-- Brussels Sprouts
INSERT INTO recipe_categories (recipe_id, category_id)
SELECT r.id, c.id
FROM recipes r, categories c
WHERE r.name = 'Roasted Brussels Sprouts' AND c.name IN ('Vegan','Gluten-Free');

-- Mac & Cheese
INSERT INTO recipe_categories (recipe_id, category_id)
SELECT r.id, c.id
FROM recipes r, categories c
WHERE r.name = 'Mac & Cheese' AND c.name = 'Vegetarian';

-- Tamagoyaki
INSERT INTO recipe_categories (recipe_id, category_id)
SELECT r.id, c.id
FROM recipes r, categories c
WHERE r.name = 'Tamagoyaki Japanese Omelette' AND c.name IN ('Vegetarian','Japanese');

-- Recipe → Ingredients (пример, без количества)
-- Cheesecake
INSERT INTO recipe_ingredients (recipe_id, ingredient_id)
SELECT r.id, i.id FROM recipes r, ingredients i
WHERE r.name = 'No-Bake Cheesecake'
  AND i.name IN ('Condensed milk','Cream Cheese','Lemon Juice','Pie Crust','Cherry Jam');

-- Brussels Sprouts
INSERT INTO recipe_ingredients (recipe_id, ingredient_id)
SELECT r.id, i.id FROM recipes r, ingredients i
WHERE r.name = 'Roasted Brussels Sprouts'
  AND i.name IN ('Brussels Sprouts','Lemon Juice','Sesame seeds','Pepper','Salt','Olive oil');

-- Mac & Cheese
INSERT INTO recipe_ingredients (recipe_id, ingredient_id)
SELECT r.id, i.id FROM recipes r, ingredients i
WHERE r.name = 'Mac & Cheese'
  AND i.name IN ('Macaroni','Butter','Flour','Salt','Pepper','Milk','Shredded Cheddar cheese');

-- Tamagoyaki
INSERT INTO recipe_ingredients (recipe_id, ingredient_id)
SELECT r.id, i.id FROM recipes r, ingredients i
WHERE r.name = 'Tamagoyaki Japanese Omelette'
  AND i.name IN ('Eggs','Soy sauce','Sugar','Salt','Olive oil');

-- Recipe → Instructions (пример: пошагово)
-- Cheesecake
INSERT INTO recipe_instructions (recipe_id, instruction_id, step_number)
SELECT r.id, ins.id, ROW_NUMBER() OVER ()
FROM recipes r, instructions ins
WHERE r.name = 'No-Bake Cheesecake'
  AND ins.text IN ('Beat Cream Cheese','Add condensed Milk and blend','Add Lemon Juice and blend',
                   'Add the mix to the pie crust','Spread the Cherry Jam','Place in refrigerator for 3h');

-- Brussels Sprouts
INSERT INTO recipe_instructions (recipe_id, instruction_id, step_number)
SELECT r.id, ins.id, ROW_NUMBER() OVER ()
FROM recipes r, instructions ins
WHERE r.name = 'Roasted Brussels Sprouts'
  AND ins.text IN ('Preheat the oven','Mix the ingredients in a bowl',
                   'Spread the mix on baking sheet','Bake for 30 minutes');

-- Mac & Cheese
INSERT INTO recipe_instructions (recipe_id, instruction_id, step_number)
SELECT r.id, ins.id, ROW_NUMBER() OVER ()
FROM recipes r, instructions ins
WHERE r.name = 'Mac & Cheese'
  AND ins.text IN ('Cook Macaroni for 8 minutes','Melt butter in a saucepan',
                   'Add flour, salt, pepper and mix','Add Milk and mix',
                   'Cook until mix is smooth','Add cheddar cheese','Add the macaroni');

-- Tamagoyaki
INSERT INTO recipe_instructions (recipe_id, instruction_id, step_number)
SELECT r.id, ins.id, ROW_NUMBER() OVER ()
FROM recipes r, instructions ins
WHERE r.name = 'Tamagoyaki Japanese Omelette'
  AND ins.text IN ('Beat the eggs','Add soya sauce, sugar and salt','Add oil to a sauce pan',
                   'Bring to medium heat','Add some mix to the sauce pan','Let it cook for 1 minute',
                   'Remove pan from fire');

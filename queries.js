import pkg from "pg";
const { Client } = pkg;

const client = new Client({
  user: "hyfuser",
  host: "localhost",
  database: "postgres",
  password: "hyfpassword",
  port: 5432,
});

async function runQueries() {
  try {
    await client.connect();
    console.log("Connected to database");

    // vegan
    const vegetarianPotato = await client.query(`
      SELECT r.name
      FROM recipes r
      JOIN recipe_categories rc ON r.id = rc.recipe_id
      JOIN categories c ON rc.category_id = c.id
      JOIN recipe_ingredients ri ON r.id = ri.recipe_id
      JOIN ingredients i ON ri.ingredient_id = i.id
      WHERE c.name = 'Vegetarian'
        AND i.name ILIKE 'potato%';
    `);
    console.log("Vegetarian recipes with potatoes:", vegetarianPotato.rows);

    // cakes
    const noBakeCakes = await client.query(`
      SELECT DISTINCT r.name
      FROM recipes r
      JOIN recipe_categories rc1 ON r.id = rc1.recipe_id
      JOIN categories c1 ON rc1.category_id = c1.id
      JOIN recipe_categories rc2 ON r.id = rc2.recipe_id
      JOIN categories c2 ON rc2.category_id = c2.id
      WHERE c1.name = 'Cake'
        AND c2.name = 'No-Bake';
    `);
    console.log("No-bake cakes:", noBakeCakes.rows);

    // vegan & japanese
    const veganJapanese = await client.query(`
      SELECT DISTINCT r.name
      FROM recipes r
      JOIN recipe_categories rc1 ON r.id = rc1.recipe_id
      JOIN categories c1 ON rc1.category_id = c1.id
      JOIN recipe_categories rc2 ON r.id = rc2.recipe_id
      JOIN categories c2 ON rc2.category_id = c2.id
      WHERE c1.name = 'Vegan'
        AND c2.name = 'Japanese';
    `);
    console.log("Vegan & Japanese recipes:", veganJapanese.rows);
  } catch (err) {
    console.error("Error executing queries:", err);
  } finally {
    await client.end();
    console.log("Connection closed");
  }
}

runQueries();

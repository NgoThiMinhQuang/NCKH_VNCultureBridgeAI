const { query } = require('./db/sql');

async function check() {
    try {
        const columns = await query("SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'AmThuc'");
        console.log('Columns in AmThuc:', columns.map(c => c.COLUMN_NAME).join(', '));
        
        const sample = await query("SELECT TOP 1 * FROM AmThuc");
        console.log('Sample data:', sample[0]);
    } catch (err) {
        console.error(err);
    }
}

check();

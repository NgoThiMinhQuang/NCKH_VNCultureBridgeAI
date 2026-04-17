const { query } = require('./db/sql');

async function check() {
    try {
        const tables = await query("SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo'");
        console.log('Tables:', tables.map(t => t.TABLE_NAME).join(', '));

        const columns = await query("SELECT COLUMN_NAME, DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'NguoiDung'");
        if (columns.length > 0) {
            console.log('Columns in NguoiDung:', columns.map(c => `${c.COLUMN_NAME} (${c.DATA_TYPE})`).join(', '));
        } else {
            console.log('Table NguoiDung does not exist.');
        }
    } catch (err) {
        console.error(err);
    }
}

check();

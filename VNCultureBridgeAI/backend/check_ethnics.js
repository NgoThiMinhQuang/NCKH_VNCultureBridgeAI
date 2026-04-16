const { query } = require('./db/sql');

async function check() {
  try {
    const ethnics = await query('SELECT DanTocID, TenVI FROM dbo.DanToc');
    console.log('TOTAL ETHNICS IN DB:', ethnics.length);
    console.log('ETHNICS:', ethnics.map(e => e.TenVI));
    process.exit(0);
  } catch (err) {
    console.error(err);
    process.exit(1);
  }
}

check();

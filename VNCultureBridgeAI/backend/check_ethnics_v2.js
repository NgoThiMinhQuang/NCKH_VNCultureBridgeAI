const { query } = require('./db/sql');

async function check() {
  try {
    const ethnics = await query('SELECT DanTocID, MaDanToc, TenVI FROM dbo.DanToc');
    console.log('TOTAL ETHNICS IN DB:', ethnics.length);
    ethnics.forEach(e => console.log(`${e.MaDanToc}: ${e.TenVI}`));
    process.exit(0);
  } catch (err) {
    console.error(err);
    process.exit(1);
  }
}

check();

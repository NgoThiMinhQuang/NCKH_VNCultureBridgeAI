const msnodesqlv8 = require('msnodesqlv8');
const connectionString = "server=NGMINHVUONG\\SQLEXPRESS;Database=VNCultureBridgeAI;Trusted_Connection=Yes;Driver={ODBC Driver 17 for SQL Server}";

console.log("Attempting to connect with msnodesqlv8 directly...");
msnodesqlv8.query(connectionString, "SELECT 1 as test", (err, rows) => {
    if (err) {
        console.error("Connection failed!");
        console.error(err);
    } else {
        console.log("Connection successful!");
        console.log(rows);
    }
});

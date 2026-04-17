const { query } = require('./db/sql');

async function updateSchema() {
    try {
        console.log('Starting schema update...');
        
        // 1. Add MaNguoiDung if it doesn't exist
        await query(`
            IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('dbo.NguoiDung') AND name = 'MaNguoiDung')
            BEGIN
                ALTER TABLE dbo.NguoiDung ADD MaNguoiDung nvarchar(50);
            END
        `);
        console.log('Added MaNguoiDung column.');

        // 2. Add TrangThai if it doesn't exist
        await query(`
            IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('dbo.NguoiDung') AND name = 'TrangThai')
            BEGIN
                ALTER TABLE dbo.NguoiDung ADD TrangThai nvarchar(20) DEFAULT 'ACTIVE';
            END
        `);
        console.log('Added TrangThai column.');

        // 3. Ensure Email is unique
        await query(`
            IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'UQ_NguoiDung_Email' AND object_id = OBJECT_ID('dbo.NguoiDung'))
            BEGIN
                ALTER TABLE dbo.NguoiDung ADD CONSTRAINT UQ_NguoiDung_Email UNIQUE (Email);
            END
        `);
        console.log('Added unique constraint on Email.');

        // 4. Ensure TenDangNhap is unique
        await query(`
            IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'UQ_NguoiDung_TenDangNhap' AND object_id = OBJECT_ID('dbo.NguoiDung'))
            BEGIN
                ALTER TABLE dbo.NguoiDung ADD CONSTRAINT UQ_NguoiDung_TenDangNhap UNIQUE (TenDangNhap);
            END
        `);
        console.log('Added unique constraint on TenDangNhap.');

        // 5. Update existing records if MaNguoiDung is null
        await query(`
            UPDATE dbo.NguoiDung 
            SET MaNguoiDung = 'U' + RIGHT('0000000' + CAST(NguoiDungID AS varchar(7)), 7),
                TrangThai = 'ACTIVE'
            WHERE MaNguoiDung IS NULL OR TrangThai IS NULL;
        `);
        console.log('Updated existing records.');

        console.log('Schema update completed successfully.');
    } catch (err) {
        console.error('Schema update failed:', err);
    }
}

updateSchema();

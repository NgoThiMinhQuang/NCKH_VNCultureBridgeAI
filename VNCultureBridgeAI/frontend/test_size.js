import fs from 'fs';
function getPngSize(filePath) {
    try {
        const data = fs.readFileSync(filePath);
        if (data.slice(0, 8).toString('hex') === '89504e470d0a1a0a') {
            const width = data.readUInt32BE(16);
            const height = data.readUInt32BE(20);
            return width + 'x' + height;
        }
    } catch(e) {}
    return 'unknown';
}
console.log('base:', getPngSize('public/maps/vietnam-map-base.png'));
console.log('north:', getPngSize('public/maps/vietnam-map-north-active.png'));
console.log('central:', getPngSize('public/maps/vietnam-map-central-active.png'));
console.log('south:', getPngSize('public/maps/vietnam-map-south-active.png'));

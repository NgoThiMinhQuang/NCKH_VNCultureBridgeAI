const service = require('./services/content.service')

async function test() {
    try {
        const data = await service.listCuisines({}, 'vi')
        console.log('Keys:', Object.keys(data))
        if (data.philosophy) {
            console.log('Philosophy found!')
        } else {
            console.log('Philosophy MISSING!')
        }
    } catch (err) {
        console.error(err)
    }
}

test()

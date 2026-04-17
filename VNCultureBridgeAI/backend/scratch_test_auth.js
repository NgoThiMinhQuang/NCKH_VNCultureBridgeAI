async function testAuth() {
    const API_URL = 'http://localhost:3001/api';
    const testEmail = `test_${Date.now()}@example.com`;
    const testPassword = 'Password123';
    const testFullName = 'Nguyen Van Test';

    async function apiRequest(path, data) {
        const response = await fetch(`${API_URL}${path}`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(data)
        });
        const result = await response.json();
        return { status: response.status, data: result };
    }

    try {
        console.log('--- Testing Registration ---');
        const regRes = await apiRequest('/auth/register', {
            fullName: testFullName,
            email: testEmail,
            password: testPassword
        });
        console.log('Registration Status:', regRes.status);
        console.log('Registration Data:', JSON.stringify(regRes.data));

        if (regRes.status !== 201) {
             console.error('Registration failed!');
             return;
        }

        console.log('\n--- Testing Login ---');
        const loginRes = await apiRequest('/auth/login', {
            email: testEmail,
            password: testPassword
        });
        console.log('Login Status:', loginRes.status);
        console.log('Login Data:', JSON.stringify(loginRes.data));

        console.log('\n--- Testing Login with Wrong Password ---');
        const wrongPassRes = await apiRequest('/auth/login', {
            email: testEmail,
            password: 'wrong_password'
        });
        console.log('Wrong Password Status:', wrongPassRes.status);
        console.log('Wrong Password Message:', wrongPassRes.data.message);

        console.log('\n--- Testing Registration with Existing Email ---');
        const duplicateRes = await apiRequest('/auth/register', {
            fullName: testFullName,
            email: testEmail,
            password: testPassword
        });
        console.log('Duplicate Email Status:', duplicateRes.status);
        console.log('Duplicate Email Message:', duplicateRes.data.message);

    } catch (err) {
        console.error('Test error:', err);
    }
}

testAuth();

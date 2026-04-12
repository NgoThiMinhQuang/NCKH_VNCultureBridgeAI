import React, { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { post } from '../../services/http';
import './LoginPage.css';

export default function LoginPage() {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [errorMessage, setErrorMessage] = useState('');
  const [isSubmitting, setIsSubmitting] = useState(false);
  const navigate = useNavigate();

  const handleSubmit = async (e) => {
    e.preventDefault();
    setErrorMessage('');
    setIsSubmitting(true);

    try {
      const data = await post('/auth/login', { email, password });
      localStorage.setItem('authToken', data.token);
      localStorage.setItem('currentUser', JSON.stringify(data.user));
      localStorage.setItem('isAuthenticated', 'true');
      window.dispatchEvent(new Event('auth-changed'));
      navigate('/');
    } catch (error) {
      setErrorMessage(error.message || 'Đăng nhập thất bại');
    } finally {
      setIsSubmitting(false);
    }
  };

  return (
    <div className="login-v2-page">
      {/* Background elements for depth */}
      <div className="login-v2-bg-shape shape-1"></div>
      <div className="login-v2-bg-shape shape-2"></div>

      <button className="back-to-home-btn" onClick={() => navigate('/')} aria-label="Về trang chủ">
        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="none" viewBox="0 0 24 24" stroke="currentColor">
          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M10 19l-7-7m0 0l7-7m-7 7h18" />
        </svg>
        <span>Trang Chủ</span>
      </button>

      <div className="login-v2-container">
        
        {/* Left Side: Visual Showcase */}
        <div className="login-v2-showcase">
          <div className="showcase-image-wrapper">
            <img 
              src="https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?ixlib=rb-4.0.3&auto=format&fit=crop&w=1200&q=80" 
              alt="Vietnam Culture" 
              className="showcase-img"
            />
            <div className="showcase-overlay"></div>
            <div className="showcase-content">
              <span className="showcase-badge">VNCultureBridgeAI</span>
              <h2 className="showcase-title">Hành trình khám phá di sản Việt</h2>
              <p className="showcase-desc">
                Tham gia cùng chúng tôi để kết nối, bảo tồn và lan tỏa những giá trị văn hóa ngàn năm hùng tráng.
              </p>
            </div>
          </div>
        </div>

        {/* Right Side: Form */}
        <div className="login-v2-form-wrapper box-fade-in">
          <div className="login-v2-form-inner">
            <div className="form-header">
              <h1>Đăng Nhập</h1>
              <p>Chào mừng trở lại! Điền thông tin để tiếp tục trải nghiệm.</p>
            </div>

            {errorMessage && <div className="form-error-message">{errorMessage}</div>}

            <form className="v2-form" onSubmit={handleSubmit}>
              <div className="v2-input-group">
                <label>Email</label>
                <div className="input-with-icon">
                  <svg className="input-icon" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M16 12a4 4 0 10-8 0 4 4 0 008 0zm0 0v1.5a2.5 2.5 0 005 0V12a9 9 0 10-9 9m4.5-1.206a8.959 8.959 0 01-4.5 1.207" />
                  </svg>
                  <input 
                    type="email" 
                    value={email} 
                    onChange={(e) => setEmail(e.target.value)}
                    placeholder="Nhập email của bạn"
                    required 
                  />
                </div>
              </div>

              <div className="v2-input-group">
                <label>Mật khẩu</label>
                <div className="input-with-icon">
                  <svg className="input-icon" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z" />
                  </svg>
                  <input 
                    type="password" 
                    value={password} 
                    onChange={(e) => setPassword(e.target.value)}
                    placeholder="••••••••"
                    required 
                  />
                </div>
              </div>

              <div className="v2-form-options">
                <label className="v2-checkbox-label">
                  <input type="checkbox" />
                  <span className="checkmark"></span>
                  Ghi nhớ đăng nhập
                </label>
                <Link to="/forgot-password" className="v2-forgot-link">Quên mật khẩu?</Link>
              </div>

              <button type="submit" className="v2-submit-btn" disabled={isSubmitting}>
                <span>{isSubmitting ? 'Đang đăng nhập...' : 'Đăng Nhập'}</span>
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" width="20" height="20">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M14 5l7 7m0 0l-7 7m7-7H3" />
                </svg>
              </button>
            </form>

            <div className="v2-form-footer">
              <p>Bạn chưa có tài khoản? <Link to="/register">Đăng ký ngay</Link></p>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

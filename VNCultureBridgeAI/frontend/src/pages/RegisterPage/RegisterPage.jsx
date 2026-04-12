import React, { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import './RegisterPage.css';

export default function RegisterPage() {
  const [formData, setFormData] = useState({
    fullName: '',
    email: '',
    password: '',
    confirmPassword: ''
  });
  const navigate = useNavigate();

  const handleChange = (e) => {
    setFormData({
      ...formData,
      [e.target.name]: e.target.value
    });
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    if(formData.password !== formData.confirmPassword) {
      alert("Mật khẩu xác nhận không khớp!");
      return;
    }
    console.log('Register attempt with:', formData);
    // Thêm logic gọi API tạo tài khoản ở đây
  };

  return (
    <div className="register-page">
      {/* Nền mờ ảo */}
      <div className="register-bg-shape shape-1"></div>
      <div className="register-bg-shape shape-2"></div>

      <button className="back-to-home-btn" onClick={() => navigate('/')} aria-label="Về trang chủ">
        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="none" viewBox="0 0 24 24" stroke="currentColor">
          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M10 19l-7-7m0 0l7-7m-7 7h18" />
        </svg>
        <span>Trang Chủ</span>
      </button>

      <div className="register-container">
        
        {/* Left Side: Visual Showcase */}
        <div className="register-showcase">
          <div className="showcase-image-wrapper">
            <img 
              src="https://images.unsplash.com/photo-1528164344705-47542687000d?ixlib=rb-4.0.3&auto=format&fit=crop&w=1200&q=80" 
              alt="Vietnam Scenic" 
              className="showcase-img"
            />
            <div className="showcase-overlay"></div>
            <div className="showcase-content">
              <span className="showcase-badge">VNCultureBridgeAI</span>
              <h2 className="showcase-title">Mở khóa tri thức, kết nối di sản</h2>
              <p className="showcase-desc">
                Đăng ký ngay hôm nay để trở thành một phần của cộng đồng bảo tồn và phát triển văn hóa Việt.
              </p>
            </div>
          </div>
        </div>

        {/* Right Side: Form */}
        <div className="register-form-wrapper box-fade-in">
          <div className="register-form-inner">
            <div className="form-header">
              <h1>Đăng Ký</h1>
              <p>Tạo tài khoản mới để bắt đầu hành trình của bạn.</p>
            </div>

            <form className="register-form" onSubmit={handleSubmit}>
              <div className="register-input-group">
                <label>Họ và tên</label>
                <div className="input-with-icon">
                  <svg className="input-icon" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                     <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
                  </svg>
                  <input 
                    type="text" 
                    name="fullName"
                    value={formData.fullName} 
                    onChange={handleChange}
                    placeholder="Nhập họ và tên"
                    required 
                  />
                </div>
              </div>

              <div className="register-input-group">
                <label>Email</label>
                <div className="input-with-icon">
                  <svg className="input-icon" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M16 12a4 4 0 10-8 0 4 4 0 008 0zm0 0v1.5a2.5 2.5 0 005 0V12a9 9 0 10-9 9m4.5-1.206a8.959 8.959 0 01-4.5 1.207" />
                  </svg>
                  <input 
                    type="email" 
                    name="email"
                    value={formData.email} 
                    onChange={handleChange}
                    placeholder="Nhập email của bạn"
                    required 
                  />
                </div>
              </div>

              <div className="register-input-group">
                <label>Mật khẩu</label>
                <div className="input-with-icon">
                  <svg className="input-icon" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z" />
                  </svg>
                  <input 
                    type="password" 
                    name="password"
                    value={formData.password} 
                    onChange={handleChange}
                    placeholder="Tạo mật khẩu"
                    required 
                  />
                </div>
              </div>

              <div className="register-input-group">
                <label>Xác nhận mật khẩu</label>
                <div className="input-with-icon">
                  <svg className="input-icon" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z" />
                  </svg>
                  <input 
                    type="password" 
                    name="confirmPassword"
                    value={formData.confirmPassword} 
                    onChange={handleChange}
                    placeholder="Nhập lại mật khẩu"
                    required 
                  />
                </div>
              </div>

              <div className="register-form-options">
                <label className="register-checkbox-label">
                  <input type="checkbox" required />
                  <span className="checkmark"></span>
                  Tôi đồng ý với các Điều khoản & Chính sách bảo mật
                </label>
              </div>

              <button type="submit" className="register-submit-btn">
                <span>Đăng Ký Tài Khoản</span>
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" width="20" height="20">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M14 5l7 7m0 0l-7 7m7-7H3" />
                </svg>
              </button>
            </form>

            <div className="register-form-footer">
              <p>Đã có tài khoản? <Link to="/login">Đăng nhập</Link></p>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

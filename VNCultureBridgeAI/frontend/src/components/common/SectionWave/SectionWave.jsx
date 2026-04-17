import React from 'react';

const SectionWave = ({ position = 'bottom', color = '#fffcf8' }) => (
  <div 
    className={`section-wave section-wave--${position}`} 
    style={{ 
      position: 'absolute', 
      width: '100%', 
      height: '100px', 
      left: 0, 
      zIndex: 10, 
      [position]: position === 'bottom' ? '-1px' : '0' 
    }}
  >
    <svg viewBox="0 0 1440 120" fill="none" xmlns="http://www.w3.org/2000/svg" style={{ width: '100%', height: '100%', display: 'block' }}>
      <path 
        d="M0 120L48 110C96 100 192 80 288 70C384 60 480 60 576 70C672 80 768 100 864 100C960 100 1056 80 1152 70C1248 60 1344 60 1392 60L1440 60V120H1392C1344 120 1248 120 1152 120C1056 120 960 120 864 120C768 120 672 120 576 120C480 120 384 120 288 120C192 120 96 120 48 120H0Z" 
        fill={color} 
      />
    </svg>
  </div>
);

export default SectionWave;

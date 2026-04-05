import { useState } from 'react';

export default function VietnamMap({ activeKey, onSelectRegion, lang }) {
  const isVi = lang === 'vi';
  const [hoveredKey, setHoveredKey] = useState(null);

  const visibleKey = hoveredKey ?? activeKey;

  return (
    <div className="regions-map-container">
      <div className="vietnam-map-wrapper">
        {/* Base Map */}
        <img src="/maps/vietnam-map-base.png" alt="Vietnam map" className="vietnam-map-base" />

        {/* Overlay Images */}
        <div className={`vietnam-map-overlay vietnam-map-overlay--north ${visibleKey === 'north' ? 'is-visible' : ''} ${hoveredKey === 'north' ? 'is-hovered' : ''} ${activeKey === 'north' ? 'is-active' : ''}`}>
          <img src="/maps/vietnam-map-north-active.png" alt="Northern Vietnam Overlay" />
        </div>

        <div className={`vietnam-map-overlay vietnam-map-overlay--central ${visibleKey === 'central' ? 'is-visible' : ''} ${hoveredKey === 'central' ? 'is-hovered' : ''} ${activeKey === 'central' ? 'is-active' : ''}`}>
          <img src="/maps/vietnam-map-central-active.png" alt="Central Vietnam Overlay" />
        </div>

        <div className={`vietnam-map-overlay vietnam-map-overlay--south ${visibleKey === 'south' ? 'is-visible' : ''} ${hoveredKey === 'south' ? 'is-hovered' : ''} ${activeKey === 'south' ? 'is-active' : ''}`}>
          <img src="/maps/vietnam-map-south-active.png" alt="Southern Vietnam Overlay" />
        </div>

        {/* Markers for regions (Star for capital, Dots for others) */}
        <div className="vietnam-map-marker vietnam-map-marker--north">★</div>
        <div className="vietnam-map-marker vietnam-map-marker--central">●</div>
        <div className="vietnam-map-marker vietnam-map-marker--south">●</div>

        {/* Texts for regions that change color on active */}
        <div className={`vietnam-map-text vietnam-map-text--north ${activeKey === 'north' ? 'is-active' : ''}`}>NORTHERN VIETNAM</div>
        <div className={`vietnam-map-text vietnam-map-text--central ${activeKey === 'central' ? 'is-active' : ''}`}>CENTRAL VIETNAM</div>
        <div className={`vietnam-map-text vietnam-map-text--south ${activeKey === 'south' ? 'is-active' : ''}`}>SOUTHERN VIETNAM</div>

        {/* Hover interaction zones (invisible) to perfectly route mouse events */}
        <button
          type="button"
          className="hover-zone north-zone"
          onMouseEnter={() => {
            setHoveredKey('north');
            onSelectRegion('north');
          }}
          onMouseLeave={() => setHoveredKey(null)}
          onClick={() => onSelectRegion('north')}
          aria-label={isVi ? 'Chọn Miền Bắc' : 'Select Northern Vietnam'}
        />
        <button
          type="button"
          className="hover-zone central-zone"
          onMouseEnter={() => {
            setHoveredKey('central');
            onSelectRegion('central');
          }}
          onMouseLeave={() => setHoveredKey(null)}
          onClick={() => onSelectRegion('central')}
          aria-label={isVi ? 'Chọn Miền Trung' : 'Select Central Vietnam'}
        />
        <button
          type="button"
          className="hover-zone south-zone"
          onMouseEnter={() => {
            setHoveredKey('south');
            onSelectRegion('south');
          }}
          onMouseLeave={() => setHoveredKey(null)}
          onClick={() => onSelectRegion('south')}
          aria-label={isVi ? 'Chọn Miền Nam' : 'Select Southern Vietnam'}
        />
      </div>
    </div>
  )
}

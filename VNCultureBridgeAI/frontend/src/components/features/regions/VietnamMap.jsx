import { useMemo, useState } from 'react';

export default function VietnamMap({ activeKey, onSelectRegion, lang, regions = [] }) {
  const [hoveredKey, setHoveredKey] = useState(null);

  const visibleKey = hoveredKey ?? activeKey;
  const labels = useMemo(() => {
    const defaults = {
      north: 'MIỀN BẮC',
      central: 'MIỀN TRUNG',
      south: 'MIỀN NAM',
    }

    for (const region of regions) {
      if (region?.key && region?.badge) {
        defaults[region.key] = String(region.badge).toUpperCase()
      }
    }

    return defaults
  }, [regions])

  return (
    <div className="regions-map-container">
      <div className="vietnam-map-wrapper">
        {/* Base Map */}
        <img src="/maps/vietnam-map-base.png" alt="Bản đồ Việt Nam" className="vietnam-map-base" />

        {/* Overlay Images */}
        <div className={`vietnam-map-overlay vietnam-map-overlay--north ${visibleKey === 'north' ? 'is-visible' : ''} ${hoveredKey === 'north' ? 'is-hovered' : ''} ${activeKey === 'north' ? 'is-active' : ''}`}>
          <img src="/maps/vietnam-map-north-active.png" alt="Lớp phủ Miền Bắc" />
        </div>

        <div className={`vietnam-map-overlay vietnam-map-overlay--central ${visibleKey === 'central' ? 'is-visible' : ''} ${hoveredKey === 'central' ? 'is-hovered' : ''} ${activeKey === 'central' ? 'is-active' : ''}`}>
          <img src="/maps/vietnam-map-central-active.png" alt="Lớp phủ Miền Trung" />
        </div>

        <div className={`vietnam-map-overlay vietnam-map-overlay--south ${visibleKey === 'south' ? 'is-visible' : ''} ${hoveredKey === 'south' ? 'is-hovered' : ''} ${activeKey === 'south' ? 'is-active' : ''}`}>
          <img src="/maps/vietnam-map-south-active.png" alt="Lớp phủ Miền Nam" />
        </div>

        {/* Markers for regions (Star for capital, Dots for others) */}
        <div className="vietnam-map-marker vietnam-map-marker--north">★</div>
        <div className="vietnam-map-marker vietnam-map-marker--central">●</div>
        <div className="vietnam-map-marker vietnam-map-marker--south">●</div>

        {/* Texts for regions that change color on active */}
        <div className={`vietnam-map-text vietnam-map-text--north ${activeKey === 'north' ? 'is-active' : ''}`}>{labels.north}</div>
        <div className={`vietnam-map-text vietnam-map-text--central ${activeKey === 'central' ? 'is-active' : ''}`}>{labels.central}</div>
        <div className={`vietnam-map-text vietnam-map-text--south ${activeKey === 'south' ? 'is-active' : ''}`}>{labels.south}</div>

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
          aria-label="Chọn Miền Bắc"
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
          aria-label="Chọn Miền Trung"
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
          aria-label="Chọn Miền Nam"
        />
      </div>
    </div>
  )
}

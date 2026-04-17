import { useMemo, useState } from 'react';
import { useNavigate } from 'react-router-dom';

export default function VietnamMap({ activeKey, onSelectRegion, lang, regions = [] }) {
  const [hoveredKey, setHoveredKey] = useState(null);
  const navigate = useNavigate();

  const KEY_MAP = {
    BAC_BO: 'north',
    TRUNG_BO: 'central',
    NAM_BO: 'south'
  };

  const internalActiveKey = KEY_MAP[activeKey] || activeKey;
  const visibleKey = hoveredKey;

  const labels = useMemo(() => {
    const defaults = {
      north: 'MIỀN BẮC',
      central: 'MIỀN TRUNG',
      south: 'MIỀN NAM',
    }

    for (const region of regions) {
      const key = region?.key || region?.id;
      const internalKey = KEY_MAP[key] || key;
      if (internalKey && region?.badge) {
        defaults[internalKey] = String(region.badge).toUpperCase()
      }
    }

    return defaults
  }, [regions])

  const handleRegionClick = (regionId) => {
    onSelectRegion(regionId);
    navigate(`/regions/${regionId}`);
  };

  return (
    <div className="regions-map-container">
      <div className="vietnam-map-wrapper">
        {/* Base Map */}
        <img src="/maps/vietnam-map-base.png" alt="Bản đồ Việt Nam" className="vietnam-map-base" />

        {/* Overlay Images */}
        <div className={`vietnam-map-overlay vietnam-map-overlay--north ${visibleKey === 'north' ? 'is-visible' : ''} ${hoveredKey === 'north' ? 'is-hovered' : ''} ${internalActiveKey === 'north' ? 'is-active' : ''}`}>
          <img src="/maps/vietnam-map-north-active.png" alt="Lớp phủ Miền Bắc" />
        </div>

        <div className={`vietnam-map-overlay vietnam-map-overlay--central ${visibleKey === 'central' ? 'is-visible' : ''} ${hoveredKey === 'central' ? 'is-hovered' : ''} ${internalActiveKey === 'central' ? 'is-active' : ''}`}>
          <img src="/maps/vietnam-map-central-active.png" alt="Lớp phủ Miền Trung" />
        </div>

        <div className={`vietnam-map-overlay vietnam-map-overlay--south ${visibleKey === 'south' ? 'is-visible' : ''} ${hoveredKey === 'south' ? 'is-hovered' : ''} ${internalActiveKey === 'south' ? 'is-active' : ''}`}>
          <img src="/maps/vietnam-map-south-active.png" alt="Lớp phủ Miền Nam" />
        </div>

        {/* Markers for regions (Star for capital, Dots for others) */}
        <div className="vietnam-map-marker vietnam-map-marker--north">★</div>
        <div className="vietnam-map-marker vietnam-map-marker--central">●</div>
        <div className="vietnam-map-marker vietnam-map-marker--south">●</div>

        {/* Texts for regions that change color on active */}
        <div className={`vietnam-map-text vietnam-map-text--north ${internalActiveKey === 'north' ? 'is-active' : ''}`}>{labels.north}</div>
        <div className={`vietnam-map-text vietnam-map-text--central ${internalActiveKey === 'central' ? 'is-active' : ''}`}>{labels.central}</div>
        <div className={`vietnam-map-text vietnam-map-text--south ${internalActiveKey === 'south' ? 'is-active' : ''}`}>{labels.south}</div>

        {/* Hover interaction zones (invisible) to perfectly route mouse events */}
        <button
          type="button"
          className="hover-zone north-zone"
          onMouseEnter={() => {
            setHoveredKey('north');
            onSelectRegion('BAC_BO');
          }}
          onMouseLeave={() => setHoveredKey(null)}
          onClick={() => handleRegionClick('BAC_BO')}
          aria-label="Chọn Miền Bắc"
        />
        <button
          type="button"
          className="hover-zone central-zone"
          onMouseEnter={() => {
            setHoveredKey('central');
            onSelectRegion('TRUNG_BO');
          }}
          onMouseLeave={() => setHoveredKey(null)}
          onClick={() => handleRegionClick('TRUNG_BO')}
          aria-label="Chọn Miền Trung"
        />
        <button
          type="button"
          className="hover-zone south-zone"
          onMouseEnter={() => {
            setHoveredKey('south');
            onSelectRegion('NAM_BO');
          }}
          onMouseLeave={() => setHoveredKey(null)}
          onClick={() => handleRegionClick('NAM_BO')}
          aria-label="Chọn Miền Nam"
        />

      </div>
    </div>
  )
}


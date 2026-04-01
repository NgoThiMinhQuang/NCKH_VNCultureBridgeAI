/**
 * Dữ liệu bản đồ điểm đặc trưng theo vùng và ngôn ngữ.
 * Tách ra khỏi RegionsPage để dễ bảo trì.
 */
export const featuredMapPoints = {
  vi: {
    north: [
      { id: 'hn', label: 'Hà Nội', x: 58, y: 20, labelX: 78, labelY: 19 },
      { id: 'hl', label: 'Hạ Long', x: 70, y: 24, labelX: 80, labelY: 27 },
      { id: 'sp', label: 'Sa Pa', x: 39, y: 18, labelX: 16, labelY: 18 },
    ],
    central: [
      { id: 'hue', label: 'Huế', x: 57, y: 50, labelX: 76, labelY: 49 },
      { id: 'dn', label: 'Đà Nẵng', x: 58, y: 56, labelX: 78, labelY: 56 },
      { id: 'ha', label: 'Hội An', x: 57, y: 60, labelX: 76, labelY: 61 },
    ],
    south: [
      { id: 'hcm', label: 'TP.HCM', x: 45, y: 81, labelX: 65, labelY: 80 },
      { id: 'ct', label: 'Cần Thơ', x: 37, y: 84, labelX: 13, labelY: 84 },
      { id: 'pq', label: 'Phú Quốc', x: 22, y: 77, labelX: 2, labelY: 76 },
    ],
  },
  en: {
    north: [
      { id: 'hn', label: 'Hanoi', x: 58, y: 20, labelX: 78, labelY: 19 },
      { id: 'hl', label: 'Ha Long', x: 70, y: 24, labelX: 81, labelY: 27 },
      { id: 'sp', label: 'Sa Pa', x: 39, y: 18, labelX: 16, labelY: 18 },
    ],
    central: [
      { id: 'hue', label: 'Hue', x: 57, y: 50, labelX: 77, labelY: 49 },
      { id: 'dn', label: 'Da Nang', x: 58, y: 56, labelX: 79, labelY: 56 },
      { id: 'ha', label: 'Hoi An', x: 57, y: 60, labelX: 77, labelY: 61 },
    ],
    south: [
      { id: 'hcm', label: 'Ho Chi Minh City', x: 45, y: 81, labelX: 64, labelY: 80 },
      { id: 'ct', label: 'Can Tho', x: 37, y: 84, labelX: 14, labelY: 84 },
      { id: 'pq', label: 'Phu Quoc', x: 22, y: 77, labelX: 2, labelY: 76 },
    ],
  },
}

/**
 * Bản đồ tương tác Việt Nam với 3 vùng và các điểm đặc trưng.
 *
 * @param {{
 *   items: object[],
 *   activeKey: 'north'|'central'|'south',
 *   activePointId: string,
 *   onSelectRegion: (key: string) => void,
 *   onSelectPoint: (id: string) => void,
 *   lang: string
 * }} props
 */
export default function VietnamMap({ items, activeKey, activePointId, onSelectRegion, onSelectPoint, lang }) {
  const activeItem = items.find((item) => item.key === activeKey)
  const points = featuredMapPoints[lang]?.[activeKey] || []

  return (
    <div className="regions-map">
      <div className="regions-map__canvas">
        <div className="regions-map__country" aria-label="Vietnam regions map">
          <img src="/maps/vietnam-map-base.png" alt="Vietnam map" className="regions-map__base" />
          <button
            type="button"
            className={`regions-map__overlay regions-map__overlay--north${activeKey === 'north' ? ' is-active' : ''}`}
            onMouseEnter={() => onSelectRegion('north')}
            onClick={() => onSelectRegion('north')}
            aria-label="Northern Vietnam"
          >
            <img src="/maps/vietnam-map-north-active.png" alt="Northern Vietnam" />
          </button>
          <button
            type="button"
            className={`regions-map__overlay regions-map__overlay--central${activeKey === 'central' ? ' is-active' : ''}`}
            onMouseEnter={() => onSelectRegion('central')}
            onClick={() => onSelectRegion('central')}
            aria-label="Central Vietnam"
          >
            <img src="/maps/vietnam-map-central-active.png" alt="Central Vietnam" />
          </button>
          <button
            type="button"
            className={`regions-map__overlay regions-map__overlay--south${activeKey === 'south' ? ' is-active' : ''}`}
            onMouseEnter={() => onSelectRegion('south')}
            onClick={() => onSelectRegion('south')}
            aria-label="Southern Vietnam"
          >
            <img src="/maps/vietnam-map-south-active.png" alt="Southern Vietnam" />
          </button>

          {points.map((point) => (
            <div
              key={point.id}
              className={`regions-map__point-group${activePointId === point.id ? ' is-active' : ''}`}
              style={{ left: `${point.x}%`, top: `${point.y}%` }}
            >
              <button
                type="button"
                className="regions-map__point"
                onMouseEnter={() => onSelectPoint(point.id)}
                onClick={() => onSelectPoint(point.id)}
                aria-label={point.label}
              />
              <span className="regions-map__pulse" aria-hidden="true" />
              <span
                className="regions-map__connector"
                style={{ width: `${Math.max(Math.abs(point.labelX - point.x) * 1.2, 22)}%` }}
                aria-hidden="true"
              />
              <button
                type="button"
                className="regions-map__point-label"
                style={{ left: `${point.labelX - point.x}%`, top: `${point.labelY - point.y}%` }}
                onMouseEnter={() => onSelectPoint(point.id)}
                onClick={() => onSelectPoint(point.id)}
              >
                {point.label}
              </button>
            </div>
          ))}
        </div>

        <div className={`regions-map__title regions-map__title--north${activeKey === 'north' ? ' is-active' : ''}`}>NORTHERN VIETNAM</div>
        <div className={`regions-map__title regions-map__title--central${activeKey === 'central' ? ' is-active' : ''}`}>CENTRAL VIETNAM</div>
        <div className={`regions-map__title regions-map__title--south${activeKey === 'south' ? ' is-active' : ''}`}>SOUTHERN VIETNAM</div>
      </div>

      <div className="regions-map__mobile-caption">{activeItem?.badge}</div>
    </div>
  )
}

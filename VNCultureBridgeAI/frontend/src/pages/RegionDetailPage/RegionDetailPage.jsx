import { Link, useParams } from 'react-router-dom'
import { getRegion } from '../../services/region.service'
import { useDetailLoader } from '../../hooks/useDetailLoader'
import LoadingState from '../../components/common/LoadingState/LoadingState'

export default function RegionDetailPage({ lang = 'vi' }) {
  const { code } = useParams()
  const { status, data, error } = useDetailLoader(getRegion, lang, code)

  if (status === 'loading') return <LoadingState message="Loading region..." />
  if (status === 'error') return <LoadingState type="error" message={error} />

  return (
    <div className="detail-page">
      <div className="detail-page__inner fade-up">
        <Link to="/" className="text-link back-link">← Back home</Link>
        <h1>{data.name}</h1>
        <p className="detail-lead">{data.type}</p>
      </div>
    </div>
  )
}

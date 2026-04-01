import { Link, useParams } from 'react-router-dom'
import { getEthnicity } from '../../services/ethnicity.service'
import { useDetailLoader } from '../../hooks/useDetailLoader'
import LoadingState from '../../components/common/LoadingState/LoadingState'

export default function EthnicityDetailPage({ lang = 'vi' }) {
  const { code } = useParams()
  const { status, data, error } = useDetailLoader(getEthnicity, lang, code)

  if (status === 'loading') return <LoadingState message="Loading ethnic group..." />
  if (status === 'error') return <LoadingState type="error" message={error} />

  return (
    <div className="detail-page">
      <div className="detail-page__inner fade-up">
        <Link to="/" className="text-link back-link">← Back home</Link>
        <h1>{data.name}</h1>
        <p className="detail-lead">{data.description}</p>
      </div>
    </div>
  )
}

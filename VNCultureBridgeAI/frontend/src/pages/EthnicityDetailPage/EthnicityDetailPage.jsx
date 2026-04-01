import { useState } from 'react'
import { useParams } from 'react-router-dom'
import { getEthnicity } from '../../services/ethnicity.service'
import { useDetailLoader } from '../../hooks/useDetailLoader'
import LoadingState from '../../components/common/LoadingState/LoadingState'
import PageHeader from '../../components/layout/PageHeader/PageHeader'
import Footer from '../../components/layout/Footer/Footer'

export default function EthnicityDetailPage() {
  const { code } = useParams()
  const [lang, setLang] = useState('vi')
  const { status, data, error } = useDetailLoader(getEthnicity, lang, code)

  if (status === 'loading') return <LoadingState message={lang === 'vi' ? 'Đang tải dân tộc...' : 'Loading ethnic group...'} />
  if (status === 'error') return <LoadingState type="error" message={error} />

  return (
    <div className="detail-page">
      <PageHeader
        lang={lang}
        onLangChange={setLang}
        breadcrumb={[
          { label: lang === 'vi' ? 'Văn hoá dân tộc' : 'Ethnic Cultures' },
          { label: data?.name || code },
        ]}
      />
      <div className="detail-page__inner fade-up">
        <h1>{data.name}</h1>
        <p className="detail-lead">{data.description}</p>
      </div>
      <Footer lang={lang} />
    </div>
  )
}

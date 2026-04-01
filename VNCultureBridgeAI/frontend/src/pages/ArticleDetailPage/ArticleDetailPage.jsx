import { useState } from 'react'
import { useParams } from 'react-router-dom'
import { getArticle } from '../../services/content.service'
import { useDetailLoader } from '../../hooks/useDetailLoader'
import { formatDate } from '../../utils/formatDate'
import LoadingState from '../../components/common/LoadingState/LoadingState'
import PageHeader from '../../components/layout/PageHeader/PageHeader'

export default function ArticleDetailPage() {
  const { code } = useParams()
  const [lang, setLang] = useState('vi')
  const { status, data, error } = useDetailLoader(getArticle, lang, code)

  if (status === 'loading') return <LoadingState message={lang === 'vi' ? 'Đang tải bài viết...' : 'Loading article...'} />
  if (status === 'error') return <LoadingState type="error" message={error} />

  return (
    <div className="detail-page">
      <PageHeader
        lang={lang}
        onLangChange={setLang}
        breadcrumb={[
          { label: lang === 'vi' ? 'Bài viết' : 'Articles', to: '/#blog' },
          { label: data?.title || code },
        ]}
      />
      <div className="detail-page__inner fade-up">
        <div className="detail-hero">
          {data.imageUrl ? <img src={data.imageUrl} alt={data.imageAlt || data.title} /> : null}
        </div>
        <div className="detail-meta">{formatDate(data.publishedAt, lang)}</div>
        <h1>{data.title}</h1>
        <p className="detail-lead">{data.description}</p>
        {data.intro && <section><h2>Intro</h2><p>{data.intro}</p></section>}
        {data.origin && <section><h2>Origin</h2><p>{data.origin}</p></section>}
        {data.meaning && <section><h2>Cultural meaning</h2><p>{data.meaning}</p></section>}
        {data.context && <section><h2>Context</h2><p>{data.context}</p></section>}
        {data.content && <section><h2>Main content</h2><p>{data.content}</p></section>}
      </div>
    </div>
  )
}

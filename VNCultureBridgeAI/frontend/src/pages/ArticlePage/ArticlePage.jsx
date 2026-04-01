import { useState, useEffect } from 'react'
import { searchArticles } from '../../services/content.service'
import LoadingState from '../../components/common/LoadingState/LoadingState'
import PageHeader from '../../components/layout/PageHeader/PageHeader'
import Footer from '../../components/layout/Footer/Footer'
import CardGrid from '../../components/common/CardGrid/CardGrid'
import SectionHeading from '../../components/common/SectionHeading/SectionHeading'

export default function ArticlePage() {
    const [lang, setLang] = useState('vi')
    const [status, setStatus] = useState('loading')
    const [articles, setArticles] = useState([])
    const [error, setError] = useState(null)

    useEffect(() => {
        let ignore = false;
        setStatus('loading')
        searchArticles({ lang, limit: 30 })
            .then(data => {
                if (!ignore) {
                    setArticles(data)
                    setStatus('success')
                }
            })
            .catch(err => {
                if (!ignore) {
                    setError(err.message)
                    setStatus('error')
                }
            })
        return () => { ignore = true }
    }, [lang])

    if (status === 'loading') return <LoadingState message={lang === 'vi' ? 'Đang tải bài viết...' : 'Loading articles...'} />
    if (status === 'error') return <LoadingState type="error" message={error} />

    return (
        <div className="page-shell">
            <PageHeader
                lang={lang}
                onLangChange={setLang}
                breadcrumb={[
                    { label: lang === 'vi' ? 'Bài viết văn hóa' : 'Cultural Articles' },
                ]}
            />
            
            <main>
                <section className="content-section light-section" style={{ minHeight: '60vh' }}>
                    <SectionHeading 
                        badge={lang === 'vi' ? 'Câu chuyện & bài viết' : 'Stories & Articles'} 
                        title={lang === 'vi' ? 'Khám phá tri thức' : 'Explore Knowledge'} 
                        description={lang === 'vi' ? 'Tổng hợp những câu chuyện và góc nhìn sâu sắc về di sản văn hoá Việt Nam.' : 'A collection of stories and profound perspectives on Vietnamese cultural heritage.'} 
                    />
                    
                    {articles.length > 0 ? (
                        <div className="fade-up" style={{ width: 'min(1360px, calc(100% - 64px))', margin: '0 auto' }}>
                            <CardGrid 
                                items={articles} 
                                variant="blog-grid" 
                                actionLabel={lang === 'vi' ? 'Đọc tiếp' : 'Read more'} 
                                lang={lang} 
                                basePath="/articles" 
                            />
                        </div>
                    ) : (
                        <p style={{ textAlign: 'center', color: 'var(--muted)' }}>
                            {lang === 'vi' ? 'Chưa có bài viết nào.' : 'No articles found.'}
                        </p>
                    )}
                </section>
            </main>
            
            <Footer lang={lang} />
        </div>
    )
}

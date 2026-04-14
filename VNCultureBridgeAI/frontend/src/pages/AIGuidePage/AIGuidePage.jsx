import { useState } from 'react'
import { askAi } from '../../services/ai.service'
import CardGrid from '../../components/common/CardGrid/CardGrid'
import PageHeader from '../../components/layout/PageHeader/PageHeader'
import './AIGuidePage.css'

export default function AIGuidePage() {
  const [lang, setLang] = useState('vi')
  const [question, setQuestion] = useState('')
  const [history, setHistory] = useState([])
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState('')

  async function handleAsk(event) {
    event.preventDefault()
    try {
      setLoading(true)
      setError('')
      const data = await askAi({ question, lang })
      setHistory((current) => [
        ...current,
        {
          question,
          answer: data.answer,
          relatedArticles: data.relatedArticles || [],
        },
      ])
      setQuestion('')
    } catch (err) {
      setError(err.message)
    } finally {
      setLoading(false)
    }
  }

  return (
    <div className="detail-page ai-detail-page">
      <PageHeader
        lang={lang}
        onLangChange={setLang}
        breadcrumb={[{ label: 'Hướng dẫn AI' }]}
      />

      <div className="detail-page__inner ai-chat-shell fade-up">
        <h1>Hướng dẫn AI</h1>
        <p className="detail-lead">Hỏi nhanh về văn hoá Việt Nam từ dữ liệu đã kiểm duyệt.</p>

        <div className="chat-thread">
          {history.length === 0 ? (
            <div className="chat-bubble chat-bubble--assistant">
              Xin chào, hãy hỏi mình về lễ hội, ẩm thực, dân tộc hay nghệ thuật Việt Nam.
            </div>
          ) : null}
          {history.map((item, index) => (
            <div key={`${item.question}-${index}`} className="chat-group">
              <div className="chat-bubble chat-bubble--user">{item.question}</div>
              <div className="chat-bubble chat-bubble--assistant">{item.answer}</div>
              {item.relatedArticles?.length ? (
                <div className="chat-related">
                  <CardGrid items={item.relatedArticles} variant="blog-grid" actionLabel="Xem bài viết" lang={lang} basePath="/articles" />
                </div>
              ) : null}
            </div>
          ))}
        </div>

        <form className="ai-guide__composer" onSubmit={handleAsk}>
          <input
            value={question}
            onChange={(e) => setQuestion(e.target.value)}
            placeholder="Ví dụ: Tết có ý nghĩa gì?"
          />
          <button type="submit" className="gradient-button nav-link-button" disabled={loading || !question.trim()}>
            {loading ? '...' : 'Hỏi AI'}
          </button>
        </form>
        {error ? <p className="detail-lead">{error}</p> : null}
      </div>
    </div>
  )
}

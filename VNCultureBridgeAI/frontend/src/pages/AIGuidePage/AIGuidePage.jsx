import { useState } from 'react'
import { Link } from 'react-router-dom'
import { askAi } from '../../services/ai.service'
import CardGrid from '../../components/common/CardGrid/CardGrid'
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
      <div className="detail-page__inner ai-chat-shell fade-up">
        <Link to="/" className="text-link back-link">← Back home</Link>
        <h1>AI Guide</h1>
        <p className="detail-lead">Hỏi nhanh về văn hoá Việt Nam từ dữ liệu đã kiểm duyệt.</p>
        <div className="lang-toggle" style={{ marginBottom: 16 }}>
          <button type="button" className={lang === 'vi' ? 'active' : ''} onClick={() => setLang('vi')}>VI</button>
          <button type="button" className={lang === 'en' ? 'active' : ''} onClick={() => setLang('en')}>EN</button>
        </div>
        <div className="chat-thread">
          {history.length === 0 ? (
            <div className="chat-bubble chat-bubble--assistant">
              {lang === 'vi'
                ? 'Xin chào, hãy hỏi mình về lễ hội, ẩm thực, dân tộc hay nghệ thuật Việt Nam.'
                : 'Hello, ask me about Vietnamese festivals, cuisine, ethnic groups, or arts.'}
            </div>
          ) : null}
          {history.map((item, index) => (
            <div key={`${item.question}-${index}`} className="chat-group">
              <div className="chat-bubble chat-bubble--user">{item.question}</div>
              <div className="chat-bubble chat-bubble--assistant">{item.answer}</div>
              {item.relatedArticles?.length ? (
                <div className="chat-related">
                  <CardGrid items={item.relatedArticles} variant="blog-grid" actionLabel="Open" lang={lang} basePath="/articles" />
                </div>
              ) : null}
            </div>
          ))}
        </div>
        <form className="ai-guide__composer" onSubmit={handleAsk}>
          <input
            value={question}
            onChange={(e) => setQuestion(e.target.value)}
            placeholder={lang === 'vi' ? 'Ví dụ: Tết có ý nghĩa gì?' : 'Example: What does Tet mean?'}
          />
          <button type="submit" className="gradient-button nav-link-button" disabled={loading || !question.trim()}>
            {loading ? '...' : 'Ask'}
          </button>
        </form>
        {error ? <p className="detail-lead">{error}</p> : null}
      </div>
    </div>
  )
}
